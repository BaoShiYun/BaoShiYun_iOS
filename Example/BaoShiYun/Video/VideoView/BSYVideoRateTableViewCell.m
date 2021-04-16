//
//  BSYVideoRateTableViewCell.m
//  KaiKeBa
//
//  Created by zddMac on 2019/4/24.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import "BSYVideoRateTableViewCell.h"

@interface BSYVideoRateTableViewCell()
@property (nonatomic, strong)UILabel *xLabel;
@property (nonatomic, strong)UILabel *titleLabel;

@end


@implementation BSYVideoRateTableViewCell

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
    [self.contentView addSubview:self.xLabel];
    [self.contentView addSubview:self.titleLabel];
}



- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.xLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_centerX).with.mas_offset(-17.0);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.width.mas_equalTo(@9.0);
        make.height.mas_equalTo(@17.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.xLabel.mas_right).with.mas_offset(@4.0);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@25.0);
        make.height.mas_equalTo(@17.0);
        
    }];
}

- (UILabel *)xLabel {
    if(!_xLabel) {
        _xLabel = [UILabel new];
        _xLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        _xLabel.textAlignment = NSTextAlignmentRight;
        _xLabel.text = @"x";
        _xLabel.backgroundColor = [UIColor clearColor];
        _xLabel.textColor = [UIColor whiteColor];
    }
    return _xLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];;
    }
    return _titleLabel;
}

- (void)setTitleText:(NSString *)titleText withHighlight:(BOOL)highlight {
    self.titleLabel.text = titleText;
    if(highlight) {
        self.xLabel.textColor = HexAlphaColor(0x00CAFF, 1.0);
        self.titleLabel.textColor =HexAlphaColor(0x00CAFF, 1.0);
    } else {
        self.xLabel.textColor = [UIColor whiteColor];;
        self.titleLabel.textColor = [UIColor whiteColor];;
    }
    
}


@end
