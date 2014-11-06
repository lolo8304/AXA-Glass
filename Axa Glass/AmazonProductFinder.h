//
//  AmazonProductFinder.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 02/11/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmazonProductFinder : NSObject

@property (nonatomic, strong) NSString * associateTag;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSString * secret;
@property (nonatomic, strong) NSString * timestamp;
@property (nonatomic, strong) NSString * signature;


+(AmazonProductFinder *)create: (NSString *)associateTag key: (NSString *) key secret: (NSString *) secret timestamp: (NSString *) timestamp signature: (NSString *) signature;

+(AmazonProductFinder *)create;

-(id)init:(NSString *)associateTag key: (NSString *) key secret: (NSString *) secret timestamp: (NSString *) timestamp signature: (NSString *) signature;

- (NSString *)searchByKeyword: (NSString *)keyword index: (NSString *) index;


@end
