//
//  LLLivePerson.m
//  lives
//
//  Created by MliBo on 2017/7/31.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "LLLivePerson.h"
#import "NSDictionary+objAction.h"

@interface LLLivePerson ()
@property (nonatomic, strong) NSDictionary * act_info;
@property (nonatomic, copy)   NSString     * city;
@property (nonatomic, strong) NSDictionary * creator;
@property (nonatomic, strong) NSDictionary * extra;
@property (nonatomic, copy)   NSString     * group;
@property (nonatomic, copy)   NSString     * live_id;
@property (nonatomic, copy)   NSString     * landspace;
@property (nonatomic, strong) NSArray      * like;
@property (nonatomic, copy)   NSString     * link;
@property (nonatomic, copy)   NSString     * live_type;
@property (nonatomic, copy)   NSString     * multi;
@property (nonatomic, copy)   NSString     * name;
@property (nonatomic, copy)   NSString     * online_users;
@property (nonatomic, copy)   NSString     * optimal;
@property (nonatomic, copy)   NSString     * room_id;
@property (nonatomic, copy)   NSString     * rotate;
@property (nonatomic, copy)   NSString     * share_addr;
@property (nonatomic, copy)   NSString     * slot;
@property (nonatomic, copy)   NSString     * stream_addr;
@property (nonatomic, copy)   NSString     * version;
@end

@implementation LLLivePerson

- (void)setSourceData:(NSDictionary *)sourceData{
    if (sourceData.count) {
        self.act_info     = [sourceData objectForKey:@"act_info"];
        self.city         = [sourceData objectForKey:@"city"];
        self.creator      = [sourceData objectForKey:@"creator"];
        self.extra        = [sourceData objectForKey:@"extra"];
        self.group        = [sourceData stringObjectForKey:@"extra"];
        self.live_id      = [sourceData stringObjectForKey:@"id"];
        self.landspace    = [sourceData stringObjectForKey:@"landspace"];
        self.like         = [sourceData objectForKey:@"like"];
        self.live_type    = [sourceData stringObjectForKey:@"live_type"];
        self.multi        = [sourceData stringObjectForKey:@"multi"];
        self.name         = [sourceData stringObjectForKey:@"name"];
        self.online_users = [sourceData stringObjectForKey:@"online_users"];
        self.optimal      = [sourceData stringObjectForKey:@"optimal"];
        self.room_id      = [sourceData stringObjectForKey:@"room_id"];
        self.rotate       = [sourceData stringObjectForKey:@"rotate"];
        self.share_addr   = [sourceData stringObjectForKey:@"share_addr"];
        self.slot         = [sourceData stringObjectForKey:@"slot"];
        self.stream_addr  = [sourceData stringObjectForKey:@"stream_addr"];
        self.version      = [sourceData stringObjectForKey:@"version"];
    }
}


@end
