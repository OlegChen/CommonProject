//
//  UserInfoTextCell.m
//  FengYunDi
//
//  Created by Ease on 15/3/18.
//  Copyright (c) 2015年 chen. All rights reserved.
//



#import "UserInfoTextCell.h"

@interface UserInfoTextCell ()
@property (strong, nonatomic) UILabel *titleL, *valueL;
@property (strong, nonatomic) UIScrollView *scrollV;
@end

@implementation UserInfoTextCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_titleL) {
            _titleL = [[UILabel alloc] initWithFrame:CGRectMake(PaddingLeftWidth, 12, 80, 20)];
            _titleL.textAlignment = NSTextAlignmentLeft;
            _titleL.font = [UIFont systemFontOfSize:15];
            _titleL.textColor = [UIColor colorWithHexString:@"0x888888"];
            [self.contentView addSubview:_titleL];
        }
        if (!_valueL) {
            _scrollV = [UIScrollView new];
            _scrollV.showsHorizontalScrollIndicator = _scrollV.showsVerticalScrollIndicator = NO;
            _valueL = [UILabel new];
            _valueL.textAlignment = NSTextAlignmentLeft;
            _valueL.font = [UIFont systemFontOfSize:15];
            _valueL.textColor = [UIColor colorWithHexString:@"0x222222"];
            [_scrollV addSubview:_valueL];
            [self.contentView addSubview:_scrollV];
            [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_titleL.mas_right);
                make.top.bottom.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-PaddingLeftWidth);
            }];
            [_valueL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.centerY.equalTo(_scrollV);
                make.height.equalTo(_titleL);
            }];
        }
        
    }
    return self;
}

- (void)setTitle:(NSString *)title value:(NSString *)value{
    _titleL.text = title;
    _valueL.text = value;
    [self.contentView updateConstraintsIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollV.contentSize = CGSizeMake(CGRectGetWidth(_valueL.frame), CGRectGetHeight(_scrollV.frame));
    });
}

+ (CGFloat)cellHeight{
    return 44;
}
@end
