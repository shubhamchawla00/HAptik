//
//  HTConversationTableView.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTConversationTableView.h"
#import "HTTextMessageTableViewCell.h"
#import "HTModels.h"
#import "UIImageView+AFNetworking.h"
#import "HTMessageStatsTableViewCell.h"

@implementation HTConversationTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_forDetails) {
        if(_usersData)
            return [_usersData count];
        else
            return 0;
    } else{
        if(_messagesData)
            return _messagesData.count;
        else
            return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_forDetails) {
        static NSString *identifier  = @"MessageStatsTableViewCell";
        HTMessageStatsTableViewCell *cell = (HTMessageStatsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HTMessageStatsTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else{
        static NSString *identifier  = @"TextMessageTableViewCell";
        HTTextMessageTableViewCell *cell = (HTTextMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HTTextMessageTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!_forDetails) {
        HTTextMessageTableViewCell *tableCell = (HTTextMessageTableViewCell*)cell;
        HTMessage *message = _messagesData[indexPath.row];
        [tableCell.messageTextView setText:message.body];
        if(indexPath.row > 0) {
            HTMessage *previousMessage = _messagesData[indexPath.row - 1];
            if([previousMessage.user.name isEqualToString:message.user.name]){
                tableCell.topViewHeight.constant = 0;
                [tableCell.profileImage setImage:nil];
                return;
                
            }
        }
        tableCell.topViewHeight.constant = 20;
        [tableCell.nameLabel setText:message.user.name];
        NSArray* messageWords = [message.messageTime componentsSeparatedByString: @"T"];
        [tableCell.timeLabel setText:messageWords[1]];
        
        if(message.user.imageUrl)
            [tableCell.profileImage setImageWithURL:[NSURL URLWithString:message.user.imageUrl]];
        else
            [tableCell.profileImage setImage:[UIImage imageNamed:@"placeHolder"]];
    }else {
        HTMessageStatsTableViewCell *tableCell = (HTMessageStatsTableViewCell*)cell;
        NSDictionary *dict = _usersData[indexPath.row];
        HTUser *user = dict[@"user"];
        if(user.imageUrl)
            [tableCell.profileImage setImageWithURL:[NSURL URLWithString:user.imageUrl]];
        else
            [tableCell.profileImage setImage:[UIImage imageNamed:@"placeHolder"]];
        [tableCell.nameLAbel setText:user.name];
        
        [tableCell.messagesCount setText:[NSString stringWithFormat:@"%ld",(long)[dict[@"messageCount"] integerValue]]];
        [tableCell.likedMEssagesCount setText:[NSString stringWithFormat:@"%ld",(long) [self getLikesCount:user]]];
    }
}

-(NSInteger) getLikesCount:(HTUser*) user{
    
    for(NSMutableDictionary *dict  in _usersData){
        HTUser *htUser = dict[@"user"];
        if([htUser.name isEqualToString:user.name]){
            return [dict[@"likesCount"] integerValue] ;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_forDetails){
        CGFloat height = 60;
        HTMessage *message = _messagesData[indexPath.row];
        
        if(indexPath.row > 0) {
            HTMessage *previousMessage = _messagesData[indexPath.row - 1];
            if([previousMessage.user.name isEqualToString:message.user.name]){
                height =height - 20;
            }
        }
        return height;
    } else {
        return 80;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_forDetails) return;
    if([_tableViewDelegate respondsToSelector:@selector(messageSelected:)]){
        [_tableViewDelegate messageSelected:indexPath.row];
    }
}


@end
