//
//  NSString+Extension.m
//  Live
//
//  Created by MliBo on 2017/9/25.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (NSMutableAttributedString *)initAttriButedStringWithDictionary:(NSDictionary *)dictionary{
    NSString * string = [dictionary objectForKey:@"String"];
    UIColor * color = [dictionary objectForKey:@"Color"];
    UIFont * font = [dictionary objectForKey:@"Font"];
    NSDictionary * butes = @{NSForegroundColorAttributeName:color,
                             NSFontAttributeName:font};
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:string attributes:butes];
    return att;
}

@end
