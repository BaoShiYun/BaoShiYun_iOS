//
//  BSYVideoViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/8.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoViewController.h"
#import "BSYVodOperateView.h"
#import "BSYVideoRateController.h"
#import "BSYVideoResolutionController.h"
#import "BSYVideoResolutionDspModel.h"


@interface BSYVideoViewController ()<BSYVodOperateViewDelegate,BSYVideoPlayerDelegate>

@property (nonatomic, strong)BSYVodOperateView *operateView;
@property (nonatomic, strong)BSYPlayerView *playerView;
@property (nonatomic, strong)BSYVodVideoModel *videoModel;
@property (nonatomic, strong)BSYVodVideoQualityModel *qualityModel;
@property (nonatomic, strong)BSYAlertViewController *alertViewController;
@property (nonatomic, strong)NSString *mediaId;
@property (nonatomic, strong)BSYDownloadModel *downloadModel;
@property (nonatomic, strong)Reachability *reachability;
@property (nonatomic, assign)NSTimeInterval curTime;
@property (nonatomic, assign)BOOL isLocal;
@property (nonatomic, assign)BOOL isPause;


@end

@implementation BSYVideoViewController

- (instancetype)initWithMediaId:(NSString *)mediaId {
    self = [super init];
    if(self) {
        self.isLocal = NO;
        self.mediaId = mediaId;
    }
    return self;
}

- (instancetype)initWithLocalVideo:(BSYDownloadModel *)downLoadModel {
    self = [super init];
    if(self) {
        self.isLocal = YES;
        self.downloadModel = downLoadModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    self.playerView.delegate = self;
    [self.view addSubview:self.operateView];
    self.operateView.delegate = self;
    if(!IS_IPAD) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChangedOrientation:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    if(self.isLocal) {
        [self playLocalVideo];
    } else {
        [self playOnlineVideo];
    }
}

- (void)playOnlineVideo {
    @weakify(self);
    BSYPlayInfo *playInfo = [[BSYPlayInfo alloc] initWithMediaId:self.mediaId];
    [self.operateView showLoadingView:YES];
    playInfo.finishBlock = ^(BSYVodVideoModel * _Nonnull vodVideo) {
        @strongify(self);
        self.videoModel = vodVideo;
        [self.playerView playVodViedo:vodVideo withCustomId:nil];
        [self initNetworkTools];
        self.qualityModel = self.playerView.qualityModel;
        [self.operateView setVideoTopBarTitle:vodVideo.title];
        BSYVideoResolutionDspModel *resolutionDspModel = [[BSYVideoResolutionDspModel alloc] initWithResolution:self.qualityModel.resolution];
        [self.operateView setResolutionTitle:resolutionDspModel.resolutionName];
    };
    
    playInfo.errorBlock = ^(NSError * _Nonnull error) {
        @strongify(self);
        [self.operateView showErrorMsg:error.domain];
    };
    [playInfo start];
}


- (void)playLocalVideo {
    if(self.downloadModel) {
        [self.operateView setVideoTopBarTitle:self.downloadModel.fileName];
        [self.operateView switchNetworkState:BSYVideoTopBarNetworkIcon_Local];
        [self.operateView showLoadingView:YES];
        [self.operateView setResolutionTitle:self.downloadModel.resolutionDes];
        [self.playerView playLocalVideo:self.downloadModel];
    } else {
        [self.operateView showErrorMsg:@"传入参数错误"];
    }
   
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.operateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
}


- (BSYPlayerView *)playerView {
    if(!_playerView) {
        _playerView = [[BSYPlayerView alloc] init];
        _playerView.backgroundColor = [UIColor blackColor];
    }
    return _playerView;
}

- (BSYVodOperateView *)operateView {
    if(!_operateView) {
        _operateView = [[BSYVodOperateView alloc] init];
    }
    return _operateView;
}

#pragma mark ----
#pragma mark 横竖屏

- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if(IS_IPAD) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = (int)orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (void)deviceDidChangedOrientation:(UIInterfaceOrientation)orientation {
    [self.operateView changedOrientation];
}


#pragma mark --
#pragma mark 网络
- (void)initNetworkTools {
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}

-(void)reachabilityChanged:(NSNotification*)notification {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    [self updateNetworkStatusChanged:status];
}

- (void)updateNetworkStatusChanged:(NetworkStatus)networkStatus {
    switch (networkStatus) {
        case NotReachable:
            break;
        case ReachableViaWiFi:
            if(!self.isLocal) {
                [self.operateView switchNetworkState:BSYVideoTopBarNetworkIcon_Wifi];
            }
            break;
        case ReachableViaWWAN: {
            if(self.playerView.playing && !self.isLocal) {
                [self.operateView switchNetworkState:BSYVideoTopBarNetworkIcon_4G];
                [BSYHud showHUDError:@"正在使用蜂窝数据"];
            }
        }
            break;
        default:
            break;
    }
}

- (void)resetNetworkTools {
    [self.reachability stopNotifier];
}


#pragma mark ----
#pragma mark BSYVideoPlayerDelegate

-(void)videoPlayerIsReadyToPlayVideo:(BSYPlayerView *)playerView {
    [self.operateView showLoadingView:NO];
    [self.operateView setVideoDurationTime:playerView.duration];
    if(self.isPause) {
        [self.playerView pause];
    }
}


-(void)videoPlayerDidReachEnd:(BSYPlayerView *)playerView {
    [self.operateView showErrorMsg:@"播放结束"];
}

-(void)videoPlayer:(BSYPlayerView *)playerView timeDidChange:(float)time {
    NSTimeInterval durTime = playerView.duration;
    NSTimeInterval curTime = playerView.currentPlaybackTime;
    self.curTime = curTime;
    if(durTime>0.0) {
        if(curTime>durTime) {
            curTime=durTime;
        }
        [self.operateView updateVideoPlayProgress:curTime/durTime];
    }
}

-(void)videoPlayer:(BSYPlayerView *)playerView loadedTimeRangeDidChange:(float)duration {
    NSTimeInterval durTime = playerView.duration;
    NSTimeInterval loadedTime = duration;
    if(durTime>0.0) {
        if(loadedTime>durTime) {
            loadedTime=durTime;
        }
        [self.operateView updateVideoBufferProgress:loadedTime/durTime];
    }
}

-(void)videoPlayerPlaybackBufferEmpty:(BSYPlayerView *)playerView {
    [self.operateView showLoadingView:YES];
}

-(void)videoPlayerPlaybackLikelyToKeepUp:(BSYPlayerView *)playerView {
    [self.operateView showLoadingView:NO];
}

-(void)videoPlayer:(BSYPlayerView *)playerView receivedTimeOut:(BSYPlayerViewTimeOut)timeOut {
    [self.operateView showErrorMsg:@"加载超时"];
}

-(void)videoPlayer:(BSYPlayerView *)playerView didFailWithError:(NSError *)error {
    [self.operateView showErrorMsg:error.domain];
}

-(void)videoPlayer:(BSYPlayerView *)playerView ChangePlayerLayer:(AVPlayerLayer *)playerLayer {
    
}


#pragma mark ---
#pragma mark BSYVodOperateViewDelegate

- (void)operateViewReturnBtnAction {
    if(!IS_IPAD) {
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)operateViewPlayAction {
    self.isPause = !self.isPause;
    if(self.isPause) {
        [self.playerView pause];
    } else {
        [self.playerView play];
    }
    [self.operateView updatePlayButtonState:!self.isPause];
}

- (void)operateViewRateAction {
    [self.operateView showOperateView:NO];
    float rate = self.playerView.player.rate;
    BSYVideoRateController *rateCtrl = [[BSYVideoRateController alloc] initWithDefaultRate:rate];
    [rateCtrl showInController:self];
    @weakify(self);
    rateCtrl.rateSelectBlock = ^(float rate) {
        @strongify(self);
        [self.playerView setPlayerRate:rate];
        [self.operateView showOperateView:YES];
    };
    rateCtrl.cancelBlock = ^{
        @strongify(self);
        [self.operateView showOperateView:YES];
    };
    
}

- (void)operateViewResolutionAction {
    [self.operateView showOperateView:NO];
    BSYVideoResolutionDspModel *curResolution = nil;
    NSMutableArray<BSYVideoResolutionDspModel *> *resolutionList = [NSMutableArray<BSYVideoResolutionDspModel *> array];
    if(self.isLocal) {
        curResolution = [[BSYVideoResolutionDspModel alloc] initWithResolution:self.downloadModel.resolution];
        [resolutionList addObject:curResolution];
    } else {
        if(self.qualityModel) {
            curResolution = [[BSYVideoResolutionDspModel alloc] initWithResolution:self.qualityModel.resolution];
        }
        if(self.videoModel && self.videoModel.mediaMetaInfo) {
            for (BSYVodVideoQualityModel *qualityModel in self.videoModel.mediaMetaInfo.videoGroup) {
                BSYVideoResolutionDspModel *dspModel = [[BSYVideoResolutionDspModel alloc] initWithResolution:qualityModel.resolution];
                [resolutionList addObject:dspModel];
            }
        }
    }
    
    BSYVideoResolutionController *resolutionCtrl = [[BSYVideoResolutionController alloc] initResolutionList:resolutionList defaultResolution:curResolution];
    [resolutionCtrl showInController:self];
    @weakify(self);
    resolutionCtrl.resolutionSelectBlock = ^(BSYVideoResolutionDspModel *resolutionDsp) {
        @strongify(self);
        [self.operateView showLoadingView:YES];
        self.qualityModel = [self getQualityModelWithResolution:resolutionDsp.resolution];
        [self.playerView switchQuality:self.qualityModel withCustomId:nil];
        [self.playerView scrub:self.curTime];
        [self.operateView showOperateView:YES];
        [self.operateView setResolutionTitle:resolutionDsp.resolutionName];
    };
    resolutionCtrl.cancelBlock = ^{
        @strongify(self);
        [self.operateView showOperateView:YES];
    };
}

- (BSYVodVideoQualityModel *)getQualityModelWithResolution:(NSString *)resolution {
    if(self.videoModel && self.videoModel.mediaMetaInfo) {
        for (BSYVodVideoQualityModel *qualityModel in self.videoModel.mediaMetaInfo.videoGroup) {
            if([qualityModel.resolution isEqualToString:resolution]) {
                return qualityModel;
            }
        }
    }
    return nil;
}

- (void)operateViewVideoSliderProgressUpdate:(float)progress {
    if(self.playerView.playing) {
        [self.playerView scrub:self.playerView.duration*progress];
    }
}


- (void)dealloc {
    [self resetNetworkTools];
}

@end
