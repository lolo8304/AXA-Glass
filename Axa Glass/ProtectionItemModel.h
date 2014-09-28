//
//  ProtectionItemModel.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtectionItemModel : NSObject


@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSNumber * insuredSum;
@property (nonatomic, strong) NSNumber * deductible;
@property (nonatomic) BOOL covered;
@property (nonatomic, strong) NSString * coveredById;
@property (nonatomic, strong) NSNumber * premium;

@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, strong) NSString * category;


- (id) initWithJson:(NSDictionary*)dict;

@end
