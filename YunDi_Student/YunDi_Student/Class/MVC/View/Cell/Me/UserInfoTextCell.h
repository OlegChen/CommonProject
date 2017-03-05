//
//  UserInfoTextCell.h
//  FengYunDi
//
//  Created by Ease on 15/3/18.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#define kCellIdentifier_UserInfoTextCell @"UserInfoTextCell"

#import <UIKit/UIKit.h>

@interface UserInfoTextCell : UITableViewCell

- (void)setTitle:(NSString *)title value:(NSString *)value;
+ (CGFloat)cellHeight;
@end
