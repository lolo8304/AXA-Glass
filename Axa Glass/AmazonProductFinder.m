//
//  AmazonProductFinder.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 02/11/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "AmazonProductFinder.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation AmazonProductFinder

+(AmazonProductFinder *)create:(NSString *)associateTag key:(NSString *)key secret:(NSString *)secret timestamp: (NSString *) timestamp signature:(NSString *)signature {
    return [[AmazonProductFinder alloc] init: associateTag key: key secret: secret timestamp: timestamp signature: signature];
}

+(AmazonProductFinder *)create {
    return [[AmazonProductFinder alloc] init: nil key: nil secret: nil timestamp: nil signature: nil];
}

-(id)init:(NSString *)associateTag key:(NSString *)key secret:(NSString *)secret timestamp: (NSString *) timestamp signature:(NSString *)signature {
    if (self = [super init]) {
        if (!associateTag) {
            associateTag = @"lolo8304-21";
        }
        if (!signature || !timestamp) {
            timestamp = @"2014-11-02T07%3A13%3A12.000Z";
            signature = @"AAJgKCfcykx%2FZmcrE5kU8mGZCFUbEgxtBxjH%2BYlVYIE%3D";
        }
        if (!key || !secret) {
            key = @"AKIAJUENEBFA76BPFK7A";
            secret = @"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";
        }
        self.associateTag = associateTag;
        self.key = key;
        self.secret = secret;
        self.timestamp = timestamp;
        self.signature = signature;
        return self;
    }
    return nil;
}

- (NSString *)createTimestamp {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat: @"YYYY-MM-DDThh:mm:ssZ"];
    
    NSDate *now = [[NSDate alloc] init];
    return [format stringFromDate:now];
}

- (NSString *)createSignature {
    NSString * parameters = @"string to hash";
    NSString *salt = self.secret;
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)nil];
    return base64Hash;
}

- (NSString *)searchByKeyword: (NSString *)keyword index: (NSString *) index {
    /** http://webservices.amazon.com/onca/xml?AWSAccessKeyId=AKIAJUENEBFA76BPFK7A&AssociateTag=lolo8304-21&Keywords=harry%20potter&Operation=ItemSearch&SearchIndex=Books&Service=AWSECommerceService&Timestamp=2014-11-02T07%3A13%3A12.000Z&Version=2013-08-01&Signature=AAJgKCfcykx%2FZmcrE5kU8mGZCFUbEgxtBxjH%2BYlVYIE%3D
     **/
    
     NSString *mainURLString = [NSString stringWithFormat:@"http://webservices.amazon.com/onca/xml?AWSAccessKeyId=%@&AssociateTag=%@&Operation=ItemSearch&Service=AWSECommerceService&Timestamp=%@&Version=2013-08-01&Signature=%@", self.key, self.associateTag, self.timestamp, self.signature];
    NSString *searchURLString = [NSString stringWithFormat:@"%@&SearchIndex=%@&Keywords=%@", mainURLString, index, keyword];
    NSURL *searchURL = [NSURL URLWithString: searchURLString];
    return nil;
}


@end
