//
//  BSYVideoTopBar.m
//  KaiKeBa
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import "BSYVideoTopBar.h"
#import "BSYTimer.h"

#define KKPLAYER_BACK_BTN_HEIGHT      30
#define KKPLAYER_BACK_BTN_WIDTH       30


@interface BSYVideoTopBar ()
@property (nonatomic, strong) UIView                   *container;
@property (nonatomic, strong) UIImageView              *cellularIcon;
@property (nonatomic, strong) UIButton                 *backButton;
@property (nonatomic, strong) UILabel                  *msgLabel;
@property (nonatomic, strong) UIImageView              *maskImageView;
@property (nonatomic, strong) UILabel                  *timeLabel;
@property (nonatomic, strong) BSYTimer                 *timer;
@end


@implementation BSYVideoTopBar

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}


#pragma mark -- UI布局初始化
- (void)createSubView {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.maskImageView];
    [self addSubview:self.container];
    [self.backButton addTarget:self action:@selector(topViewGoBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.backButton];
    [self.container addSubview:self.cellularIcon];
    [self.container addSubview:self.msgLabel];
    [self.container addSubview:self.timeLabel];
    [self switchNetworkState:BSYVideoTopBarNetworkIcon_Wifi];
    [self startTimer];
}


#pragma mark --
#pragma mark 视图布局约束

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
         make.edges.equalTo(self);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.equalTo(self);
        make.top.equalTo(self).with.offset(IPHONE_MARGIN_TOP+15);
        make.height.mas_equalTo(KKPLAYER_BACK_BTN_HEIGHT);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7+IPHONE_SAFE_AREA.left);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(KKPLAYER_BACK_BTN_WIDTH);
        make.height.mas_equalTo(KKPLAYER_BACK_BTN_HEIGHT);
    }];
    
    [self.cellularIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.backButton.mas_right).with.offset(7);
        make.centerY.equalTo(self.backButton);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(19);
    }];
    
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.cellularIcon.mas_right).with.offset(7);
        make.centerY.equalTo(self.backButton);
        make.height.mas_equalTo(@25.);
        make.right.equalTo(self.timeLabel.mas_left).with.offset(-10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.mas_equalTo(-17-IPHONE_SAFE_AREA.right);
        make.height.equalTo(self.msgLabel);
        make.centerY.equalTo(self.msgLabel);
        
    }];
}
- (BOOL)needsUpdateConstraints {
    return YES;
}


#pragma mark --
#pragma mark 懒加载对象

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIImageView *)cellularIcon {
    if(!_cellularIcon) {
        _cellularIcon = [[UIImageView alloc] init];
    }
    return _cellularIcon;
}

- (UIImageView *)maskImageView {
    if(!_maskImageView) {
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.contentMode = UIViewContentModeScaleAspectFill;
        _maskImageView.userInteractionEnabled = YES;
        _maskImageView.image = AssetsImage(@"player_mask_top");
    }
    return _maskImageView;
}

- (UIButton *)backButton {
    if(!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:AssetsImage(@"player_back_btn") forState:UIControlStateNormal];
        _backButton.backgroundColor = [UIColor clearColor];
    }
    return _backButton;
}

- (UILabel *)msgLabel {
    if(!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.backgroundColor = [UIColor clearColor];
        _msgLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.textColor = HexAlphaColor(0xFFFFFF, 1.0);
    }
    return _msgLabel;
}

- (UILabel *)timeLabel {
    if(!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = HexAlphaColor(0xFFFFFF, 1.0);
    }
    return _timeLabel;
}

#pragma mark --
#pragma mark 设置topBar信息

//切换显示4G图标
- (void)switchNetworkState:(BSYVideoTopBarNetworkIcon)state {
    switch (state) {
        case BSYVideoTopBarNetworkIcon_Wifi:
            self.cellularIcon.image = AssetsImage(@"wifi_icon_top");
            break;
        case BSYVideoTopBarNetworkIcon_4G:
             self.cellularIcon.image = AssetsImage(@"cellular_icon_top");
            break;
        case BSYVideoTopBarNetworkIcon_Local:
             self.cellularIcon.image = AssetsImage(@"local_icon_top");
            break;
        default:
            break;
    }
}
     
//设置title
- (void)setVideoTopBarTitle:(NSString *)title {
    if (!title) {
        title = @"";
    }
    self.msgLabel.text = title;
}

#pragma mark --
#pragma mark ---- Action
- (void)topViewGoBackAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(topBarReturnBtnAction)]) {
        [self.delegate topBarReturnBtnAction];
    }
}

#pragma mark -
#pragma mark - 横竖屏切换
- (void)changeViewPortraitScreen:(BOOL)isPortrait {
    if(isPortrait) {
        self.msgLabel.hidden = YES;
    } else {
        self.msgLabel.hidden = NO;
    }
}



#pragma mark ---
- (void)startTimer {
    if(self.timer==nil) {
        @weakify(self);
        self.timer = [BSYTimer scheduledTimerWithTimeInterval:1.0 repeats:YES queue:dispatch_get_main_queue() block:^{
            @strongify(self);
            [self timerAction];
        }];
    }
}
- (void)timerAction {
    NSDate *date = [NSDate date];
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"HH:mm"];
    NSString *time = [mdf stringFromDate:date];
    self.timeLabel.text = time;
}


- (void)stopTimer {
    if(self.timer) {
       [self.timer invalidate];
       self.timer = nil;
    }
    
}

- (void)dealloc {
    [self stopTimer];
}



@end
