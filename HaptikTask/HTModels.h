//
//  HTModels.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTUser : NSObject <NSObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *imageUrl;

+(HTUser*) initWithDictionary: (NSDictionary *) dict;

@end


@interface HTMessage : NSObject <NSObject>

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *messageTime;
@property (nonatomic, strong) HTUser *user;

+(HTMessage*) initWithDictionary: (NSDictionary *) dict;

@end


