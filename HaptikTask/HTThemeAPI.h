//
//  HTThemeAPI.h
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HTThemeAPI : NSObject
+(UIColor*)colorWithHexCode:(NSString*)hexCodeString;
+(UIFont *) mediumFontRelativeToSize: (CGFloat) size;
+(UIFont *) actionSheetLabelFont;
+(UIFont *) actionSheetCancelFont;
+(UIColor *) separatorColor;

@end
