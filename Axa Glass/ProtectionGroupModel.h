//
//  ProtectionGroupModel.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtectionGroupModel : NSObject


@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSMutableArray * items;


- (id) initWithJson:(NSDictionary*)dict;

@end
