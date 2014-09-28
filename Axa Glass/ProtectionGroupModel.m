//
//  ProtectionGroupModel.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ProtectionGroupModel.h"
#import "ProtectionItemModel.h"

@implementation ProtectionGroupModel : NSObject 

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (id) initWithJson:(NSDictionary*)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [self init];
        if (self) {
            self.identifier = dict[@"group"][@"id"];
            self.title = dict[@"group"][@"title"];
            
            self.items = [NSMutableArray array];
            
            for (NSDictionary * item in dict[@"items"]) {
                ProtectionItemModel * model = [[ProtectionItemModel alloc] initWithJson:item];
                [self.items addObject:model];
            }
            
            return self;
        }
    }
    return nil;
}


- (NSString *)description {
    NSMutableString  * string = [NSMutableString stringWithFormat:@"%@ %@ - items count %lu", self.identifier, self.title, (long)[self.items count]];
    for (ProtectionGroupModel * model in self.items) {
        [string appendFormat:@"\n%@", model];
    }
    return string;
    
}

@end
