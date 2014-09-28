//
//  ProtectionModel.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ProtectionModel.h"
#import "ProtectionGroupModel.h"

@implementation ProtectionModel

- (id)init {
    self = [super init];
    if (self) {
        self.groups = [NSMutableArray array];
    }
    return self;
}


- (id) initWithJson:(NSDictionary*)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [self init];
        if (self) {
            self.identifier = dict[@"id"];
            
            self.groups = [NSMutableArray array];
            
            for (NSDictionary * item in dict[@"items"]) {
                ProtectionGroupModel * model = [[ProtectionGroupModel alloc] initWithJson:item];
                [self.groups addObject:model];
            }
            
            return self;
        }
    }
    return nil;
}



@end
