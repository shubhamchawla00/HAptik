//
//  HTViewController.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTViewController.h"
#import "HTThemeAPI.h"

@interface HTViewController ()

@end

@implementation HTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [HTThemeAPI colorWithHexCode:@"FCFCFC"];
    self.navigationController.navigationBar.translucent = NO;
      [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showTitle:(NSString *)title{
    if(title == nil) return;
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName: [HTThemeAPI mediumFontRelativeToSize:17.0f] }];
}

@end
