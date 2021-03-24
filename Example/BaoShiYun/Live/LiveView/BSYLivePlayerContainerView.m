//
//  BSYLivePlayerContainerView.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYLivePlayerContainerView.h"

@interface BSYLivePlayerContainerView()

@property (nonatomic, strong)UIView *statusContainer;
@property (nonatomic, strong)UILabel *livingStatusLabel;
@property (nonatomic, strong)UIImageView *liveStatusIcon;

@end

@implementation BSYLivePlayerContainerView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self addSubview:self.statusContainer];
        [self.statusContainer addSubview:self.livingStatusLabel];
        [self.statusContainer addSubview:self.liveStatusIcon];
    }
    return self;
}


- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.statusContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-30);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(52);
    }];
    
    [self.liveStatusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.top.equalTo(self.statusContainer);
        make.height.width.mas_equalTo(21);
            
    }];
    
    [self.livingStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.left.right.equalTo(self.statusContainer);
        make.height.mas_equalTo(20);
    }];
}


- (UILabel *)livingStatusLabel {
    if(!_livingStatusLabel) {
        _livingStatusLabel = [[UILabel alloc] init];
        _livingStatusLabel.numberOfLines = 1;
        _livingStatusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _livingStatusLabel.textAlignment = NSTextAlignmentCenter;
        _livingStatusLabel.textColor = [UIColor whiteColor];
    }
    return _livingStatusLabel;
}

- (UIImageView *)liveStatusIcon {
    if(!_liveStatusIcon) {
        _liveStatusIcon = [[UIImageView alloc] init];
    }
    return _liveStatusIcon;
}

- (UIView *)statusContainer {
    if(!_statusContainer) {
        _statusContainer = [[UIView alloc] init];
    }
    return _statusContainer;
}


- (void)setContainerPlayerStatus:(BSYLivePlayerStatus)status {
    UIImage *iconImage = nil;
    NSString *msg = @"";
    
    switch (status) {
        case BSYLivePlayerStatus_UnStart: {
            self.statusContainer.hidden = NO;
            msg = @"直播未开始";
            iconImage = AssetsImage(@"live_status_unstart_icon");
        }
            break;
        case BSYLivePlayerStatus_Living: {
            self.statusContainer.hidden = YES;
        }
            break;
        case BSYLivePlayerStatus_Suspend: {
            self.statusContainer.hidden = NO;
            iconImage = AssetsImage(@"live_status_end_icon");
            msg = @"直播中断";
        }
            break;
        case BSYLivePlayerStatus_LiveEnd: {
            self.statusContainer.hidden = NO;
            msg = @"休息一下~";
            iconImage = AssetsImage(@"live_status_end_icon");
        }
            break;
        default: {
            self.statusContainer.hidden = NO;
            iconImage = AssetsImage(@"live_status_end_icon"); 
            msg = @"未知错误";
        }
            break;
    }
    self.liveStatusIcon.image = iconImage;
    self.livingStatusLabel.text = msg;
}

@end
