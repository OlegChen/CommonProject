//
//  UserInfoIconCell.h
//  FengYunDi
//
//  Created by Ease on 15/3/18.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "UserInfoIconCell.h"

@interface UserInfoIconCell ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleL;
@end

@implementation UserInfoIconCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_iconView) {
            _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(PaddingLeftWidth, 10, 24, 24)];
            [self.contentView addSubview:_iconView];
        }
        if (!_titleL) {
            _titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + PaddingLeftWidth, 12, SCREEN_WIDTH/2, 20)];
            _titleL.textAlignment = NSTextAlignmentLeft;
            _titleL.font = [UIFont systemFontOfSize:15];
            _titleL.textColor = [UIColor colorWithHexString:@"0x222222"];
            [self.contentView addSubview:_titleL];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title icon:(NSString *)iconName{
    _titleL.text = title;
    _iconView.image = [UIImage imageNamed:iconName];
}

+ (CGFloat)cellHeight{
    return 44;
}
#pragma mark Tip
- (void)prepareForReuse{
    [self removeTip];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)addTipIcon{
    CGFloat pointX = SCREEN_WIDTH - 40;
    CGFloat pointY = [[self class] cellHeight]/2;
    
#warning 数字 提示
    
//    [self.contentView addBadgeTip:kBadgeTipStr withCenterPosition:CGPointMake(pointX, pointY)];
}

- (void)removeTip{
//    [self.contentView removeBadgeTips];
}
@end
