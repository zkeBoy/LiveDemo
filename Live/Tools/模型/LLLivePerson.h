//
//  LLLivePerson.h
//  lives
//
//  Created by MliBo on 2017/7/31.
//  Copyright © 2017年 MliBo. All rights reserved.
//  主播 model

#import <Foundation/Foundation.h>

static NSString * const iconKey = @"portrait"; //封面
static NSString * const nameKey = @"nick";     //主播昵称

@interface LLLivePerson : NSObject
/*
 * icon
 * uid
 */
@property (nonatomic, strong, readonly) NSDictionary * act_info;
@property (nonatomic, copy, readonly)   NSString     * city;

/*
 * gender
 * id
 * level
 * nick
 * portrait
 */
@property (nonatomic, strong, readonly) NSDictionary * creator;

/*
 * cover
 * label = ({
   cl = (
 
   )
   "tab_key" = "\U6c14\U8d28";
   "tab_name" = "\U6c14\U8d28";
 })
 */
@property (nonatomic, strong, readonly) NSDictionary * extra;
@property (nonatomic, copy, readonly)   NSString     * group;
@property (nonatomic, copy, readonly)   NSString     * live_id;
@property (nonatomic, copy, readonly)   NSString     * landspace;
@property (nonatomic, strong, readonly) NSArray      * like;
@property (nonatomic, copy, readonly)   NSString     * link;
@property (nonatomic, copy, readonly)   NSString     * live_type;
@property (nonatomic, copy, readonly)   NSString     * multi;
@property (nonatomic, copy, readonly)   NSString     * name;
@property (nonatomic, copy, readonly)   NSString     * online_users; //在线人数
@property (nonatomic, copy, readonly)   NSString     * optimal;
@property (nonatomic, copy, readonly)   NSString     * room_id;
@property (nonatomic, copy, readonly)   NSString     * rotate;
@property (nonatomic, copy, readonly)   NSString     * share_addr;
@property (nonatomic, copy, readonly)   NSString     * slot;
@property (nonatomic, copy, readonly)   NSString     * stream_addr;
@property (nonatomic, copy, readonly)   NSString     * version;

@property (nonatomic, strong) NSDictionary * sourceData; //原始数据

@end
