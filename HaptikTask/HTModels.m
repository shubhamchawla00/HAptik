//
//  HTModels.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTModels.h"
#import "HTGlobal.h"

@implementation HTUser

+(HTUser*) initWithDictionary: (NSDictionary *) dict {
    if(dict == nil) return nil;
    HTUser *user = [[HTUser alloc] init];
    if(CHECK_NULL_VAL(dict[@"Name"])) {
        user.name = dict[@"Name"];
    }
    if(CHECK_NULL_VAL(dict[@"image-url"])) {
        user.imageUrl = dict[@"image-url"];
    }
    if(CHECK_NULL_VAL(dict[@"username"])) {
        user.username = dict[@"username"];
    }
    return user;
}

@end

@implementation HTMessage

+(HTMessage*) initWithDictionary: (NSDictionary *) dict {
    if(dict == nil) return nil;
    
    HTMessage *message = [[HTMessage alloc] init];
    message.user = [HTUser initWithDictionary:dict];
    message.body = CHECK_NULL_VAL(dict[@"body"]);
    message.messageTime = CHECK_NULL_VAL(dict[@"message-time"]);
    return message;
}

@end
