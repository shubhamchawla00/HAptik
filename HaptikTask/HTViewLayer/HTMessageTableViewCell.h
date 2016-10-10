//
//  HTMessageTableViewCell.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@end
