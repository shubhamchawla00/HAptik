//
//  HTNetworkAPI.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HTTypes.h"
#import "HTGlobal.h"
static NSString *kUrlKey = @"UrlString";

@interface HTNetworkAPI : NSObject

+(void) getConversationData:(closure) aSuccessClosure onFailure:(closure) aFailedClosure;

@end
