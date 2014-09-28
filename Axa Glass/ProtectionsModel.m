//
//  ProtectionsModel.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ProtectionsModel.h"
#import "ProtectionModel.h"

@implementation ProtectionsModel

+ (ProtectionsModel*)sharedManager {
    static ProtectionsModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}



- (id)init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (ImageModel *) modelAtIndex:(NSUInteger) index {
    if (index < [self.items count]) {
        return self.items[index];
    }
    return nil;
}

#define kTotalElements 4

- (void) loadData {
    [self.items removeAllObjects];
    NSError * error = nil;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *jsonName = [NSString stringWithFormat:@"myprotections"];
    NSString *path = [bundle pathForResource: jsonName ofType: @"json"];
    NSString *data = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error!=nil) {
        LoggerError(0, @"File not found %@", path);
    }
    id jsonData = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    if (error!=nil) {
        LoggerError(0, @"JsonData is empty for %@", path);
    }

    for (NSDictionary * jsonItem in jsonData) {
        ProtectionModel * model = [[ProtectionModel alloc] initWithJson:jsonItem];
        if (!IsEmpty(model)) {
            [self.items addObject:model];
            LoggerData(2, @"model=%@", model);
        }
    }
    
    
}


@end
