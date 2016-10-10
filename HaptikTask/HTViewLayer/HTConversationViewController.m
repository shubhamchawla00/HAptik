//
//  HTConversationViewController.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTConversationViewController.h"
#import "JGActionSheet.h"

@interface HTConversationViewController ()<HTConversationProtocol,JGActionSheetDelegate>

@property (nonatomic, strong) NSArray *htMessages;
@property (nonatomic , assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSMutableArray *favoritiesArray;



@end

@implementation HTConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getConversationDataFromBackend];
    [self showTitle:@"Messages"];
    _segement.tintColor = self.navigationController.navigationBar.tintColor;
    _tableView.tableViewDelegate = self;
    _users = [[NSMutableArray alloc] init];
    _favoritiesArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getConversationDataFromBackend{
    __weak typeof(self) safeSelf = self;
    [HTDataAPI getConversationData:^(NSDictionary *aOptions) {
        if(aOptions && CHECK_NULL_VAL(aOptions[@"Response"])) {
            safeSelf.htMessages = aOptions[@"Response"];
            safeSelf.tableView.messagesData = safeSelf.htMessages;
            [safeSelf.tableView reloadData];
            for(int i = 0; i < [safeSelf.htMessages count]; i++) {
                HTMessage *message = [safeSelf.htMessages objectAtIndex:i];
                NSInteger present = [self isUserAlreadyPresent:message.user];
                if(present == -1){
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:message.user forKey:@"user"];
                    [dict setObject:@(1) forKey:@"messageCount"];
                    [_users addObject:dict];
                }else{
                    NSMutableDictionary *dict = [_users objectAtIndex:present];
                    NSInteger count = [[dict objectForKey:@"messageCount"] integerValue] + 1;
                    [dict setObject:@(count) forKey:@"messageCount"];
                }
            }
        }
    } onFailure:^(NSDictionary *aOptions) {
        ;
    }];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeShadowFromBar];
}

-(void) removeShadowFromBar {

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void) messageSelected:(NSInteger)messageIndex{
    if(messageIndex < 0 || messageIndex > [_htMessages count] -1) return;
    _selectedIndex = messageIndex;
    [self openActionSheet];
}

-(void) openActionSheet{
    JGActionSheet *actionSheet;
    NSArray *buttonTitles;
    NSArray *buttonImages;
    if([self isAlreadyPresentInFavorites:_htMessages[_selectedIndex]] == -1) {
        buttonTitles = @[@"Like"];
    }else {
        buttonTitles = @[@"Unlike"];
    }
    buttonImages = nil;
    
    actionSheet = [JGActionSheet actionSheetWithSections:@[[JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:buttonTitles buttonImages:buttonImages buttonStyle:JGActionSheetButtonStyleDefault],
                                                           [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel]]];
    actionSheet.delegate = self;
    actionSheet.insets = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    [actionSheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        sheet = nil;
    }];
    [actionSheet setOutsidePressBlock:^(JGActionSheet *sheet) {
        [sheet dismissAnimated:YES];
        sheet = nil;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [actionSheet showInView:self.view  animated:YES];
    });
}

-(void) actionSheet:(JGActionSheet *)actionSheet pressedButtonAtIndexPath:(NSIndexPath *)indexPath {
    if(0 == indexPath.section) {
        if(indexPath.row == 0) {
            if(_favoritiesArray){
                if([self isAlreadyPresentInFavorites:_htMessages[_selectedIndex]] == -1){
                    HTMessage *message = _htMessages[_selectedIndex];
                    [_favoritiesArray addObject:message.body];
                    NSInteger present = [self isUserAlreadyPresent:message.user];
                    if(present != -1){
                        NSMutableDictionary *dict = _users[present];
                        NSInteger likes = [[dict objectForKey:@"likesCount"] integerValue] + 1;
                        [dict setObject:@(likes) forKey:@"likesCount"];
                    }
                }else{
                    HTMessage *message = _htMessages[_selectedIndex];
                    [_favoritiesArray removeObject:message.body];
                    NSInteger present = [self isUserAlreadyPresent:message.user];
                    NSMutableDictionary *dict = _users[present];
                    NSInteger likes = [[dict objectForKey:@"likesCount"] integerValue] - 1;
                    [dict setObject:@(likes) forKey:@"likesCount"];
                }
            }else{
                _favoritiesArray = [[NSMutableArray alloc] init];
                if(_htMessages[_selectedIndex])
                {
                    HTMessage *message = _htMessages[_selectedIndex];
                    NSInteger present = [self isUserAlreadyPresent:message.user];
                    if(present != -1){
                        NSMutableDictionary *dict = _users[present];
                        NSInteger likes = [[dict objectForKey:@"likesCount"] integerValue] + 1;
                        [dict setObject:@(likes) forKey:@"likesCount"];
                    }
                }
                
            }
        }
    }
}


-(NSInteger) isAlreadyPresentInFavorites: (HTMessage *) message {
    NSInteger __block present = -1;
    if(_favoritiesArray == nil)
        return present;
    [_favoritiesArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
     {
         if([((NSString*)obj) isEqualToString: message.body])  // message body is considered unique
         {
             present = idx;
             return YES;
         }
         return NO;
     }];
    
    return present;
}

-(NSInteger) isUserAlreadyPresent: (HTUser *) user {
    NSInteger __block present = -1;
    if(_users == nil)
        return present;
    [_users indexOfObjectPassingTest:^BOOL(NSMutableDictionary * obj, NSUInteger idx, BOOL *stop)
     {
         HTUser *htUser = obj[@"user"];
         if([htUser.username isEqualToString: user.username])  // user name is considered unique
         {
             present = idx;
             return YES;
         }
         return NO;
     }];
    return present;
}


- (IBAction)segmentAction:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex == 0){
        self.tableView.forDetails = NO;
        self.tableView.messagesData = self.htMessages;
        [self.tableView reloadData];
    }else{
        self.tableView.forDetails = YES;
        self.tableView.usersData = [_users mutableCopy];
        [self.tableView reloadData];
    }
    
}

@end
