//
//  HTConversationTableView.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTModels.h"

@protocol HTConversationProtocol <NSObject>

-(void) messageSelected:(NSInteger) messageIndex;

@end

@interface HTConversationTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *messagesData;
@property (nonatomic, strong) NSArray *usersData;

@property (nonatomic, weak) id<HTConversationProtocol> tableViewDelegate;
@property (nonatomic, assign) BOOL forDetails;
@end
