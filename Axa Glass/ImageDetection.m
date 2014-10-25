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

- (NSData *)uploadAndDetectImage {
    
    /** based on http://nthn.me/posts/2012/objc-multipart-forms.html **/
    
    NSURL *url = [NSURL URLWithString:@"http://inventory42-focusdays14.rhcloud.com/UploadAndDetectServlet"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"YOUR_BOUNDARY_STRING";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", self.fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"submit\"\r\n\r\n%d", 1] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:body];
    id response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil && [response isKindOfClass: [NSHTTPURLResponse class]] && [response statusCode] == 200) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if (error!=nil) {
            return nil;
        }
        return jsonData;
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
