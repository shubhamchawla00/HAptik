//
//  HTMessageTableViewCell.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMessageTableViewCell.h"

@interface HTTextMessageTableViewCell : HTMessageTableViewCell
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@end
