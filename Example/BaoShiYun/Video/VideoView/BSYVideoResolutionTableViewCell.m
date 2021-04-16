//
//  BSYVideoResolutionTableViewCell.m
//  KaiKeBa
//
//  Created by zddMac on 2019/4/24.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import "BSYVideoResolutionTableViewCell.h"

@interface BSYVideoResolutionTableViewCell()

@property (nonatomic, strong)UILabel *titleLabel;

@end


@implementation BSYVideoResolutionTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self createSubView];
    }
    return self;
}

+ (CGFloat)cellHeight {
    return 40.0;
}

- (void)createSubView {
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@40.0);
        make.height.mas_equalTo(@20.0);
        
    }];
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = HexAlphaColor(0xffffff, 1.0);
    }
    return _titleLabel;
}


- (void)setTitleText:(NSString *)titleText withHighlight:(BOOL)highlight {
    self.titleLabel.text = titleText;
    if(highlight) {
        self.titleLabel.textColor = HexAlphaColor(0x00CAFF, 1.0);
    } else {
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    
}


@end
