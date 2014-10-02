//
//  ProtectionItemModel.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ProtectionItemModel.h"

@implementation ProtectionItemModel

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
            self.type = dict[@"type"];
            self.identifier = dict[@"id"];
            self.title = dict[@"title"];
            self.image = dict[@"image"];

//            self.covered = [@"true" isEqualToString: (dict[@"insurance"][@"covered"])];
            self.covered = dict[@"insurance"][@"covered"];
            self.coveredById = dict[@"insurance"][@"coveredById"];

            /* if type == "coverage" */
            self.insuredSum = dict[@"insurance"][@"insuredSum"];
            self.deductible = dict[@"insurance"][@"deductible"];
            self.premium = dict[@"insurance"][@"premium"];

            /* if type == "object-capture" */
            self.price = dict[@"insurance"][@"price"];
            self.category = dict[@"insurance"][@"category"];            
            return self;
        }
    }
    return nil;
}


- (NSString *)description {
    NSString * b = nil;
    if (self.covered) {
        b = @"true";
    } else {
        b = @"false";
    }
    NSMutableString  * string = [NSMutableString stringWithFormat:@"%@ %@ %@ %@ %@", self.identifier, self.title, self.type, self.insuredSum, b ];
    return string;
    
}

@end
