//
//  HTThemeAPI.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTThemeAPI.h"

#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define MEDIUM_FONT @"HelveticaNeue-Light"

@implementation HTThemeAPI

+(UIColor*)colorWithHexCode:(NSString*)hexCodeString{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexCodeString];
    [scanner scanHexInt:&rgbValue];
    return RGBColor(rgbValue, 1.0);
}

+(UIFont *) mediumFontRelativeToSize: (CGFloat) size
{
    return [UIFont fontWithName: MEDIUM_FONT size: size];
}

+(UIFont *) actionSheetLabelFont
{
    return [self mediumFontRelativeToSize:16];
}

+(UIFont *) actionSheetCancelFont
{
    return [self mediumFontRelativeToSize:16];
}

+(UIColor *) separatorColor {
    return [UIColor colorWithRed: 0 green:0 blue:0 alpha: 0.26];
}
@end
