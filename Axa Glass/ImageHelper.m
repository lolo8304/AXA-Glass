//
//  ImageHelper.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 26/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper

+(ImageHelper *)fromResourceName:(NSString *)file extension:(NSString *)ext {
    
    NSURL *resourceURL = [[NSBundle mainBundle] URLForResource: file withExtension:ext];
    return [[ImageHelper alloc] initWithURL: resourceURL];
}
+(ImageHelper *)fromURL:(NSURL *)resourceURL {
    return [[ImageHelper alloc] initWithURL: resourceURL];
}

-(id)initWithURL:(NSURL *)url {
    if ((self = [super init]) && url) {
        self.imageURL = url;
        self.fileName = url.lastPathComponent;
        if (!self.isLocalResource) {
            self.publicImageURL = url;
        }
        return self;
    }
    return nil;
}

- (BOOL)isLocalResource {
    /**
     true = if file://
     or http://localhost or https://localhost
     */
    
    return [self.imageURL.scheme isEqual: @"file"] || ([self.imageURL.scheme hasPrefix:@"http"] && [self.imageURL.host isEqualToString: @"localhost"]) ;
}

- (BOOL)isPublicAvailable {
    return self.publicImageURL != nil;
}
- (BOOL)hasDetectedResult {
    return self.detectedResult != nil;
}

- (NSData *) imageData {
    return [NSData dataWithContentsOfURL:self.imageURL];
}


- (NSURL *)uploadImage {
    if (!self.isPublicAvailable) {
        [self uploadImage: FALSE];
    }
    return self.publicImageURL;
}
- (BOOL)uploadAndDetectImage {
    if (!self.isPublicAvailable) {
        [self uploadImage: TRUE];
    } else {
        if (!self.hasDetectedResult) {
            [self detectImage:[self publicImageURL]];
        }
    }
    return self.isPublicAvailable && self.hasDetectedResult;
}

- (NSURL *)detectionServerURL:(NSURL *)url {
    NSError *errorURL = nil;
    NSString *urlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&errorURL];
    NSString *uploadURLStr = [NSString stringWithFormat:@"http://inventory42-focusdays14.rhcloud.com/UploadAndDetectServlet?detect=true&url=%@", [urlStr     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *uploadURL = [NSURL URLWithString: uploadURLStr];
    return uploadURL;
}

- (NSString *)detectImageServerResponse: (NSURL *) url {
    NSURL *uploadURL = [self detectionServerURL:url];
    NSError *errorSend = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: uploadURL
                                         cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    id response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorSend];
    if (errorSend == nil && [response isKindOfClass: [NSHTTPURLResponse class]] && [response statusCode] == 200) {
        return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSDictionary *) parseJSON: (NSString *) dataString {
    NSError *error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:[ dataString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error == nil) {
        if ([jsonData isKindOfClass:[NSDictionary class]]) {
            return jsonData;
        }
    }
    return nil;
}

- (void)updateDetectedResults: (NSDictionary *) dictionary {
    self.detectedResult = dictionary;
    if (dictionary) {
        self.publicImageURL= dictionary[@"image"];
        self.model = [[ImageModel alloc] initWithServerJson:dictionary];
        self.model.imageHelper = self;
    }
}

- (void)clearDetectedResults {
    self.publicImageURL = nil;
    self.detectedResult = nil;
    self.model = nil;
}

- (void) detectImage: (NSURL *) url {
    NSString *dataString = [self detectImageServerResponse:url];
    [self updateDetectedResults:[self parseJSON:dataString]];
}

- (void) uploadImage: (BOOL) detect {
    
    /** http://stackoverflow.com/questions/15410689/iphone-upload-multipart-file-using-afnetworking
     and
     https://github.com/AFNetworking
     **/
    
    NSArray *keys = [[NSArray alloc]initWithObjects:@"submit", nil];
    NSArray *values =[[NSArray alloc]initWithObjects:@"1", nil];
    
    NSURL *url = nil;
    if (detect) {
        url = [NSURL URLWithString:@"http://inventory42-focusdays14.rhcloud.com/UploadAndDetectServlet"];
    } else {
        url = [NSURL URLWithString:@"http://inventory42-focusdays14.rhcloud.com/UploadServlet"];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n", boundary];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *tempPostData = [NSMutableData data];
    [tempPostData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    for(int i=0;i<keys.count;i++){
        NSString *str = values[i];
        NSString *key =keys[i];
        NSLog(@"Key Value pair: %@-%@",key,str);
        [tempPostData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [tempPostData appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        // [tempPostData appendData:[@"\r\n--%@\r\n",boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [tempPostData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    // Sample file to send as data
    [tempPostData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Image\"; filename=\"%@\"\r\n", self.fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [tempPostData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *mydata = [self imageData];
    
    NSLog(@"Image data:%d",mydata.length);
    [tempPostData appendData:mydata];
    
    [tempPostData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:tempPostData];
    
    id response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSHTTPURLResponse *urlResponse = response;
    
    if (error == nil && [response isKindOfClass: [NSHTTPURLResponse class]] && [urlResponse statusCode] == 200) {
        
        NSString* dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (detect) {
            [self updateDetectedResults:[self parseJSON:dataString]];
        } else {
            self.publicImageURL = [NSURL fileURLWithPath: dataString];
        }
        return;
    } else {
        [self clearDetectedResults];
    }
}



@end
