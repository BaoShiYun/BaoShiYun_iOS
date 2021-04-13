//
//  BSYVideoViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/8.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoViewController.h"
#import "BSYVodOperateView.h"


@interface BSYVideoViewController ()

@property (nonatomic, strong)BSYVodOperateView *operateView;
@property (nonatomic, strong)BSYPlayerView *playerView;
@property (nonatomic, strong)NSString *mediaId;
@property (nonatomic, strong)BSYDownloadModel *downloadModel;
@property (nonatomic, assign)BOOL isLocal;

@end

@implementation BSYVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.operateView];
    if(!IS_IPAD) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
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

@end
