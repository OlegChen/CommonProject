//
//  MMPickerView.h
//  MMPickerView
//
//  Created by Madjid Mahdjoubi on 6/5/13.
//  Copyright (c) 2013 GG. All rights reserved.
//

#pragma mark -- 用法
/**
 *  用法
 
 [MMPickerView showPickerViewInView:self.view
 withStrings:_stringsArray
 withOptions:@{MMbackgroundColor: [UIColor whiteColor],
 MMtextColor: [UIColor blackColor],
 MMtoolbarColor: [UIColor whiteColor],
 MMbuttonColor: [UIColor grayColor],
 MMfont: [UIFont systemFontOfSize:18],
 MMvalueY: @3,
 MMselectedObject:_selectedString,
 MMtextAlignment:@1}
 completion:^(NSString *selectedString) {
 
 _label.text = selectedString;
 _selectedString = selectedString;
 }];

 
 
 */

#import <UIKit/UIKit.h>

extern NSString * const MMbackgroundColor;
extern NSString * const MMtextColor;
extern NSString * const MMtoolbarColor;
extern NSString * const MMbuttonColor;
extern NSString * const MMfont;
extern NSString * const MMvalueY;
extern NSString * const MMselectedObject;
extern NSString * const MMtoolbarBackgroundImage;
extern NSString * const MMtextAlignment;
extern NSString * const MMshowsSelectionIndicator;

@interface MMPickerView: UIView 

+(void)showPickerViewInView: (UIView *)view
                withStrings: (NSArray *)strings
                withOptions: (NSDictionary *)options
                 completion: (void(^)(NSString *selectedString))completion;

+(void)showPickerViewInView: (UIView *)view
                withObjects: (NSArray *)objects
                withOptions: (NSDictionary *)options
    objectToStringConverter: (NSString *(^)(id object))converter
       completion: (void(^)(id selectedObject))completion;

+(void)dismissWithCompletion: (void(^)(NSString *))completion;

@end
