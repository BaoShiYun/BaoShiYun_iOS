//
//  BSYVideoBottomBar.m
//  KaiKeBa
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import "BSYVideoBottomBar.h"
#import "GKSliderView.h"

@interface BSYVideoBottomBar ()<GKSliderViewDelegate>

@property (nonatomic, assign) BOOL                  isPlaying;
@property (nonatomic, assign) BOOL                  silderDraging;
@property (nonatomic, strong) UIView                *container;
@property (nonatomic, strong) LOTAnimationView       *playBtnLOT;
@property (nonatomic, strong) UIButton              *playBtn;
@property (nonatomic, strong) UIButton              *rateBtn;
@property (nonatomic, strong) UIButton              *resolutionBtn;
@property (nonatomic, strong) GKSliderView          *progressSlider;
@property (nonatomic, strong) UILabel               *timeLabel;
@property (nonatomic, strong) UIImageView           *maskImageView;
@property (nonatomic, assign) NSTimeInterval         duration;

@end


@implementation BSYVideoBottomBar

#pragma mark -
#pragma mark - Private Method

-(void)dealloc {
}
#pragma mark -- UI布局初始化

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    self.isPlaying = YES;
    self.silderDraging = NO;
    [self addSubview:self.maskImageView];
    [self addSubview:self.container];
    [self.playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.playBtn];
    [self.container insertSubview:self.playBtnLOT belowSubview:self.playBtn];
    [self.container addSubview:self.timeLabel];
    
    [self.rateBtn addTarget:self action:@selector(ratePlayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.rateBtn];
    
    [self.resolutionBtn addTarget:self action:@selector(resolutionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.resolutionBtn];
    [self.container addSubview:self.progressSlider];
    [self updatePlayButtonState:YES];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self).with.offset(10+IPHONE_SAFE_AREA.left);
        make.right.equalTo(self).with.offset(-10-IPHONE_SAFE_AREA.right);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(59+IPHONE_MARGIN_BOTTOM);
    }];
    
    [self.progressSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.container).with.offset(5);
        make.top.equalTo(self.container).with.offset(10);
        make.height.mas_equalTo(22);
        make.right.equalTo(self.container).with.offset(-5);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.container);
        make.top.equalTo(self.progressSlider.mas_bottom);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.playBtnLOT mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.playBtn);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.playBtn.mas_right).with.offset(22);
        make.centerY.equalTo(self.playBtn);
        make.width.mas_equalTo(300);
        make.height.mas_offset(16);
    }];
    
    [self.resolutionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.container).with.offset(-5);
        make.top.equalTo(self.playBtn);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(31.0);
    }];
    
    [self.rateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.resolutionBtn.mas_left).with.offset(-25);
        make.centerY.equalTo(self.resolutionBtn);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(31.0);
    }];
    
    
}


#pragma mark ----
#pragma mark 懒加载对象

- (UIImageView *)maskImageView {
    if(!_maskImageView) {
        _maskImageView = [UIImageView new];
        _maskImageView.contentMode = UIViewContentModeScaleToFill;
        _maskImageView.userInteractionEnabled = YES;
        _maskImageView.image = AssetsImage(@"player_mask_bottom");
        
    }
    return _maskImageView;
}

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] init];
    
    }
    return _container;
}


- (UIButton *)playBtn {
    if(!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _playBtn;
}


- (UIButton *)rateBtn {
    if(!_rateBtn) {
        _rateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rateBtn setTitle:@"倍速" forState:UIControlStateNormal];
        _rateBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _rateBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 10, 0);
        [_rateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rateBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    }
    return _rateBtn;
}

- (UIButton *)resolutionBtn {
    if(!_resolutionBtn) {
        _resolutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resolutionBtn setTitle:@"流畅" forState:UIControlStateNormal];
        _resolutionBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _resolutionBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 10, 0);
        [_resolutionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resolutionBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    }
    return _resolutionBtn;
}

- (LOTAnimationView *)playBtnLOT {
    if(!_playBtnLOT) {
        _playBtnLOT = [LOTAnimationView animationWithFilePath:[[BSYUtility mainBundleDirectory] stringByAppendingPathComponent:@"vod_play_button_pause/data.json"]];
        _playBtnLOT.loopAnimation = NO;
        _playBtnLOT.userInteractionEnabled = YES;
        _playBtnLOT.contentMode = UIViewContentModeScaleToFill;
    }
    return _playBtnLOT;
}


- (GKSliderView *)progressSlider {
    if(!_progressSlider) {
        _progressSlider = [GKSliderView new];
        _progressSlider.backgroundColor = [UIColor clearColor];
        _progressSlider.delegate = self;
        _progressSlider.maximumTrackTintColor = HexAlphaColor(0xFFFFFF, .15);
        _progressSlider.bufferTrackTintColor = HexAlphaColor(0xD1ECF7, .4);
        _progressSlider.minimumTrackTintColor = HexAlphaColor(0x00CAFF, 1.0);
        [_progressSlider setThumbImage:AssetsImage(@"player_progress_slider_thumb") forState:UIControlStateNormal];
        [_progressSlider setThumbImage:AssetsImage(@"player_progress_slider_thumb") forState:UIControlStateHighlighted];
        _progressSlider.sliderHeight = 2.0f;
        _progressSlider.bufferValue = 0.0;
        [_progressSlider hideLoading];
        _progressSlider.value = 0.0;
        _progressSlider.userInteractionEnabled = YES;
    }
    return _progressSlider;
}


- (UILabel *)timeLabel {
    if(!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont fontWithName:@"Arial" size:12];;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"00:00 / 00:00";
        _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}


#pragma mark ---
#pragma mark BtnAction

- (void)playAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(bottomBarPlayAction)]) {
        [self updatePlayButtonState:!self.isPlaying];
        [self.delegate bottomBarPlayAction];
    }
}


- (void)ratePlayAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(bottomBarRateAction)]) {
        [self.delegate bottomBarRateAction];
    }
}

- (void)resolutionButtonAction {
    if(self.delegate && [self.delegate respondsToSelector:@selector(bottomBarResolutionAction)]) {
        [self.delegate bottomBarResolutionAction];
    }
}

#pragma mark -
#pragma mark - GKSliderViewDelegate 拖动进度条的进度
- (void)sliderTouchBegan:(float)value {
    self.progressSlider.value = value;
    self.silderDraging = YES;
}
- (void)sliderValueChanged:(float)value {
    // 滑块滑动中
    self.progressSlider.value = value;
    self.silderDraging = YES;
    [self updateTimeView];
    //拖动滑竿更新视频时间显示的label文字
    
}
- (void)sliderTouchEnded:(float)value {
    // 滑块滑动结束
    self.progressSlider.value = value;
    if(self.delegate && [self.delegate respondsToSelector:@selector(bottomBarVideoSliderProgressUpdate:)]) {
        [self.delegate bottomBarVideoSliderProgressUpdate:value];
    }
    self.silderDraging = NO;
}
- (void)sliderTapped:(float)value {
    // 滑杆点击
    [self sliderTouchEnded:value];
}



#pragma mark --
#pragma mark 视图更新
- (void)setVideoDurationTime:(NSTimeInterval)duration {
    self.duration = duration;
    [self updateTimeView];
}

- (void)updateVideoBufferProgress:(float)bufferProgress {
    self.progressSlider.bufferValue = bufferProgress;
}

- (void)updateVideoPlayProgress:(float)progress {
    if(!self.silderDraging) {
       self.progressSlider.value = progress;
       [self updateTimeView];
    }
}

- (void)updateTimeView {
    if(self.duration>0) {
        NSTimeInterval currentTime = self.progressSlider.value * self.duration;
        NSString *curTimeString = [BSYVideoBottomBar durTimeStringFormate:currentTime];
        NSString *durationTimeString = [BSYVideoBottomBar durTimeStringFormate:self.duration];
        self.timeLabel.text = [NSString stringWithFormat:@"%@ / %@",curTimeString,durationTimeString];
        
    }
    
   
}

- (void)setResolutionTitle:(NSString *)title {
    [self.resolutionBtn setTitle:title forState:UIControlStateNormal];
}

- (void)updatePlayButtonState:(BOOL)isPlaying{
    if(self.isPlaying!=isPlaying) {
        self.isPlaying = isPlaying;
        NSString *lotPath = nil;
        if (self.isPlaying) {
            lotPath = [[BSYUtility mainBundleDirectory] stringByAppendingPathComponent:@"vod_play_button_play/data.json"];
        }else {
            lotPath = [[BSYUtility mainBundleDirectory] stringByAppendingPathComponent:@"vod_play_button_pause/data.json"];
        }
        [self.playBtnLOT reloadAnimationWithFilePath:lotPath];
        [self.playBtnLOT play];
    }
}

- (void)setSilderDragingState:(BOOL)silderDraging {
    if(self.silderDraging!=silderDraging) {
        self.silderDraging = silderDraging;
    }
}

- (void)resetVideoBottomBarState {
    //重置状态到初始化
    self.isPlaying = NO;
    self.silderDraging = NO;
    [self updatePlayButtonState:NO];
    self.progressSlider.value = 0.0;
    self.progressSlider.bufferValue = 0.0;
    self.progressSlider.userInteractionEnabled = YES;
}


+ (NSString *)durTimeStringFormate:(NSTimeInterval)time {
    if (time <= 0.0) {
        return @"00:00";
    }
    
    NSInteger seconds = ((NSInteger)time) % 60;
    NSInteger minutes = time / 60;
    if(minutes>=60) {
        NSInteger hours = minutes / 60;
        minutes = minutes % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours,(long)minutes, (long)seconds];
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    }
    
}

@end
