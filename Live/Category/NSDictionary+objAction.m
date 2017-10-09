//
//  NSDictionary+objAction.m
//  lives
//
//  Created by MliBo on 2017/7/31.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "NSDictionary+objAction.h"

@implementation NSDictionary (objAction)

- (NSString *)stringObjectForKey:(NSString *)key{
    if ([[self objectForKey:key] isKindOfClass:[NSString class]]) {
        return [self objectForKey:key];
    }
    return [NSString stringWithFormat:@"%@",[self objectForKey:key]];
}

@end
