//
//  ProtectionModel.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 29/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProtectionModel : NSObject

@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSMutableArray * groups;

- (id) initWithJson:(NSDictionary*)dict;

@end
