//
//  HTDataAPI.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTNetworkAPI.h"
@interface HTDataAPI : NSObject

+(void) getConversationData:(closure) aSuccessClosure onFailure:(closure) aFailedClosure;

@end
