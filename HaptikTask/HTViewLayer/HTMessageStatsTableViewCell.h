//
//  HTMessageStatsTableViewCell.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMessageStatsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLAbel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *messagesCount;
@property (weak, nonatomic) IBOutlet UILabel *likedMEssagesCount;
@end
