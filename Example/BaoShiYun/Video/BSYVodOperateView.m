//
//  BSYVodOperateView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/12.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVodOperateView.h"
#import "BSYVideoBottomBar.h"

@protocol BSYPlayerOperateViewDelegate <NSObject>


@end

@interface BSYVodOperateView()<UIGestureRecognizerDelegate,BSYVideoTopBarDelegate,BSYVideoBottomBarDelegate>
@property (nonatomic, strong) UIView                  *container;

@property (nonatomic, strong) BSYVideoTopBar           *topBar;
@property (nonatomic, strong) BSYVideoBottomBar        *bottomBar;
@property (nonatomic, strong) UIButton                *lockBtn;
@property (nonatomic, strong) LOTAnimationView         *loadingAnimateLOT;
@property (nonatomic, strong) UILabel                 *loadingMsgLabel;

//手势操作
@property (nonatomic, strong) UITapGestureRecognizer   *tapGesture;
@property (nonatomic, strong) UIView                  *gestureView;

@property (nonatomic, assign) BOOL isShowOperate;

@end


@implementation BSYVodOperateView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    [self addSubview:self.container];
    [self.container addSubview:self.gestureView];
    [self.gestureView addGestureRecognizer:self.tapGesture];
    [self.container addSubview:self.topBar];
    self.topBar.delegate = self;
    [self.container addSubview:self.bottomBar];
    self.bottomBar.delegate = self;
    [self.container addSubview:self.lockBtn];
    [self.lockBtn addTarget:self action:@selector(lockBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    
    [self.gestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.topBar.mas_bottom);
        make.left.right.equalTo(self.container);
        make.bottom.equalTo(self.bottomBar.mas_top);
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.top.equalTo(self.container);
        make.height.mas_equalTo(116);
            
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.container);
        make.height.mas_equalTo(164);
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.container.mas_right).with.offset(-18-IPHONE_MARGIN_TOP);
        make.centerY.equalTo(self.container);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
    }];
    
    
}

#pragma mark ---
#pragma mark 懒加载

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
        _container.clipsToBounds = YES;
        _container.userInteractionEnabled = YES;
        _container.backgroundColor = [UIColor clearColor];
    }
    return _container;
}
- (UIView *)gestureView {
    if(!_gestureView) {
        _gestureView = [[UIView alloc] init];
        _gestureView.clipsToBounds = YES;
        _gestureView.userInteractionEnabled = YES;
        _gestureView.backgroundColor = [UIColor clearColor];
    }
    return _gestureView;
}

- (UITapGestureRecognizer *)tapGesture {
    if(!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

- (BSYVideoTopBar *)topBar {
    if(!_topBar) {
        _topBar = [[BSYVideoTopBar alloc] init];
    }
    return _topBar;
}


- (BSYVideoBottomBar *)bottomBar {
    if(!_bottomBar) {
        _bottomBar = [[BSYVideoBottomBar alloc] init];
        _bottomBar.backgroundColor = [UIColor clearColor];
    }
    return _bottomBar;
}

- (UIButton *)lockBtn {
    if(!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:AssetsImage(@"lock") forState:UIControlStateNormal];
    }
    return _lockBtn;
}


- (LOTAnimationView *)loadingAnimateLOT {
    if(!_loadingAnimateLOT) {
        _loadingAnimateLOT = [LOTAnimationView animationWithFilePath:[[BSYUtility mainBundleDirectory] stringByAppendingPathComponent:@"player_loading_indicator/data.json"]];
        _loadingAnimateLOT.loopAnimation = YES;
        _loadingAnimateLOT.userInteractionEnabled = YES;
        _loadingAnimateLOT.contentMode = UIViewContentModeScaleToFill;
    }
    return _loadingAnimateLOT;
}

- (UILabel *)loadingMsgLabel {
    if(!_loadingMsgLabel) {
        _loadingMsgLabel = [[UILabel alloc] init];
        _loadingMsgLabel.numberOfLines = 1;
        _loadingMsgLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _loadingMsgLabel.text = @"正在努力加载，请稍后..";
        _loadingMsgLabel.textAlignment = NSTextAlignmentCenter;
        _loadingMsgLabel.textColor = HexAlphaColor(0xFFFFFF, 1.0);
    }
    return _loadingMsgLabel;
}


#pragma mark ---
#pragma mark Action

- (void)showLoadingView:(BOOL)isShow {
    
}

- (void)showErrorMsg:(NSString *)errMsg {
    
}
- (void)setVideoTopBarTitle:(NSString *)title {
    [self.topBar setVideoTopBarTitle:title];
}
- (void)switchNetworkState:(BSYVideoTopBarNetworkIcon)state {
    [self.topBar switchNetworkState:state];
}
- (void)setResolutionTitle:(NSString *)title {
    [self.bottomBar setResolutionTitle:title];
}
- (void)setVideoDurationTime:(NSTimeInterval)duration {
    [self.bottomBar setVideoDurationTime:duration];
}
- (void)updateVideoBufferProgress:(float)bufferProgress {
    [self.bottomBar updateVideoBufferProgress:bufferProgress];
}
- (void)updateVideoPlayProgress:(float)progress {
    [self.bottomBar updateVideoPlayProgress:progress];
}
- (void)updatePlayButtonState:(BOOL)isPlaying {
    [self.bottomBar updatePlayButtonState:isPlaying];
}
- (void)lockBtnAction {
    
}

- (void)tapGestureAction {
    
}


#pragma mark ---
#pragma mark BSYVideoTopBarDelegate

- (void)topBarReturnBtnAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewReturnBtnAction)]) {
        [self.delegate operateViewReturnBtnAction];
    }
}


#pragma mark ---
#pragma mark BSYVideoBottomBarDelegate

- (void)bottomBarPlayAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewPlayAction)]) {
        [self.delegate operateViewPlayAction];
    }
}
- (void)bottomBarRateAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewRateAction)]) {
        [self.delegate operateViewRateAction];
    }
}
- (void)bottomBarResolutionAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewResolutionAction)]) {
        [self.delegate operateViewResolutionAction];
    }
}
- (void)bottomBarVideoSliderProgressUpdate:(float)progress {
    if(self.delegate && [self.delegate respondsToSelector:@selector(operateViewVideoSliderProgressUpdate:)]) {
        [self.delegate operateViewVideoSliderProgressUpdate:progress];
    }
}




@end
