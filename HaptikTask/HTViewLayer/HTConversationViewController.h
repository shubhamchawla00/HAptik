//
//  HTConversationViewController.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTViewController.h"
#import "HTConversationTableView.h"


@interface HTConversationViewController : HTViewController

@property (weak, nonatomic) IBOutlet HTConversationTableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segement;

@end
