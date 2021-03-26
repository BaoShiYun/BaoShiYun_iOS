//
//  BSYLiveStudentCountView.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/3.
//

#import "BSYLiveStudentCountView.h"

@interface BSYLiveStudentCountView()
@property (nonatomic, strong)UIView *container;
@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *countLabel;
@end


@implementation BSYLiveStudentCountView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.container];
    [self.container addSubview:self.iconImage];
    [self.container addSubview:self.countLabel];
}

- (void)updateConstraints {
   [super updateConstraints];
   @weakify(self);
   [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self);
       make.right.top.equalTo(self);
       make.height.mas_equalTo([BSYLiveStudentCountView viewSize].height);
   }];
   [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self);
       make.left.mas_equalTo(8);
       make.centerY.equalTo(self);
       make.width.mas_equalTo(12);
       make.height.mas_equalTo(12);
   }];
   [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self);
       make.left.equalTo(self.iconImage.mas_right).with.offset(4);
       make.top.mas_equalTo(4);
       make.height.mas_equalTo([BSYLiveStudentCountView viewSize].height-5);
       make.width.mas_greaterThanOrEqualTo(10);
       make.right.equalTo(self.container.mas_right).with.offset(-8);
   }];
}

#pragma mark ---
#pragma mark 懒加载
- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
        _container.layer.cornerRadius = 12;
        _container.layer.masksToBounds = YES;
        _container.backgroundColor = HexAlphaColor(0x000000, .4);
    }
    return _container;
}

- (UIImageView *)iconImage {
    if(!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = AssetsImage(@"live_student_cnt_icon");
    }
    return _iconImage;
}

- (UILabel *)countLabel {
    if(!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.numberOfLines = 1;
        _countLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:14];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.textColor = HexAlphaColor(0xFFFFFF, 0.8);
        _countLabel.text = @"0";
    }
    return _countLabel;
}

+ (CGSize)viewSize {
    return CGSizeMake(53, 24);
}

- (void)setStudentCount:(NSInteger)count {
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
}


@end
