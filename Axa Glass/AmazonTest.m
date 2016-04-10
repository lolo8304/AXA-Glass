//
//  AmazonTest.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 02/11/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "AmazonTest.h"
#import "RWMAmazonProductAdvertisingManager.h"

@implementation AmazonTest


- (void)testSearch {
    
    self.response = nil;
    RWMAmazonProductAdvertisingManager *manager = [[RWMAmazonProductAdvertisingManager alloc] initWithAccessKeyID:@"AKIAJUENEBFA76BPFK7A" secret:@"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"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [@{
                                         @"Service" : @"AWSECommerceService",
                                         @"Operation" : @"ItemSearch",
                                         @"SearchIndex" : @"All",
                                         @"ResponseGroup" : @"ItemAttributes",
                                         @"AssociateTag" : @"lolo8304-21"
                                         } mutableCopy];
    
    [manager enqueueStringRequestOperationWithMethod:@"GET" parameters:[parameters copy] success:^(NSString *responseString) {
       // NSXMLParser *parser;
        
    } failure:^(NSError *error) {
        self.response = error;
    }];
    
}

@end
