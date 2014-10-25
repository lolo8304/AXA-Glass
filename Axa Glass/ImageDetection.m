//
//  ImageDetection.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 25/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageDetection.h"

@implementation ImageDetection

+(ImageDetection *)detectResourceNamed:(NSString *)file extension:(NSString *)ext {

    NSURL *resourceURL = [[NSBundle mainBundle] URLForResource: file withExtension:ext];
    return [[ImageDetection alloc] initWithURL: resourceURL];
}
+(ImageDetection *)detectImageByURL:(NSURL *)resourceURL {
    return [[ImageDetection alloc] initWithURL: resourceURL];
}

-(id)initWithURL:(NSURL *)url {
    if ((self = [super init]) && url) {
        self.imageURL = url;
        self.fileName = url.lastPathComponent;
        return self;
    }
    return nil;
}

- (NSDictionary *)uploadAndDetectImage {
    return [self uploadAndDetectImage_NSMutableURL];
}

- (NSDictionary *)uploadAndDetectImage_NSMutableURL {
    /** http://stackoverflow.com/questions/15410689/iphone-upload-multipart-file-using-afnetworking
     and
     https://github.com/AFNetworking
     **/
    
    NSArray *keys = [[NSArray alloc]initWithObjects:@"submit", nil];
    NSArray *values =[[NSArray alloc]initWithObjects:@"1", nil];
    
    NSURL *url = [NSURL URLWithString:@"http://inventory42-focusdays14.rhcloud.com/UploadAndDetectServlet"];
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
    
    NSData *mydata = [NSData dataWithContentsOfURL:self.imageURL];

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
        id jsonData = [NSJSONSerialization JSONObjectWithData:[ dataString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            if ([jsonData isKindOfClass:[NSDictionary class]]) {
                return jsonData;
            }
        }
        return nil;
    } else {
        return nil;
    }
}

- (NSURL *)newTempFileURLNamed: (NSString *)fileName {
    NSString* tempPath = NSTemporaryDirectory();
    NSString* tempFile = [tempPath stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:tempFile];
}
@end
