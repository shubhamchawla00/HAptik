//
//  HTDataAPI.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTDataAPI.h"
#import "HTModels.h"

@implementation HTDataAPI

+(void) getConversationData:(closure) aSuccessClosure onFailure:(closure) aFailedClosure {
    
    [HTNetworkAPI getConversationData:^(NSDictionary *aOptions) {
        NSMutableArray *htMessages = [NSMutableArray array];
        if(aOptions && CHECK_NULL_VAL(aOptions[@"Response"])) {
            NSDictionary *response = aOptions[@"Response"];
            if(CHECK_NULL_VAL(response[@"messages"])) {
                NSArray* messages = response[@"messages"];
                for(NSDictionary *message in messages) {
                    HTMessage *htMessage = [HTMessage initWithDictionary:message];
                    if(htMessage) {
                        [htMessages addObject:htMessage];
                    }
                }
            }
        }
        if(aSuccessClosure) {
            aSuccessClosure(@{@"Response":htMessages});
        }
    } onFailure:^(NSDictionary *aOptions) {
        if(aFailedClosure) {
            aFailedClosure(aOptions);
        }
    }];
    
}

@end
