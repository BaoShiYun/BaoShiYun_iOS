//
//  BSYLiveOperateBottomBar.m
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//

#import "BSYLiveOperateBottomBar.h"

@interface BSYLiveOperateBottomBar()

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIImageView *bgView;

@end



@implementation BSYLiveOperateBottomBar


- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
}


- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
}


#pragma mark --
#pragma mark 懒加载

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UIImageView *)bgView {
    if(!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.userInteractionEnabled = YES;
        _bgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgView;
}

@end
