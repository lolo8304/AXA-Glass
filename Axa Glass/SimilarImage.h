//
//  SimilarImage.h
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimilarImage : NSObject

@property (nonatomic, strong) NSString * imageName;
@property (nonatomic, strong) NSString * keywords;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, strong) NSString * currency;


- (id) initWithJson:(NSDictionary*)dict;

@end
