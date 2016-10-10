//
//  HTTypes.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SATypes_h
#define SATypes_h
#endif

typedef void (^closure)(NSDictionary* aOptions);
typedef NS_ENUM(NSInteger, HTStatusCode) {
    HTStatusCodeSuccess = 200,
    HTStatusCodeFailedError = 500,
};
