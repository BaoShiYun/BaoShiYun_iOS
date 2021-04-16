//
//  BSYVodOperateView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/4/12.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSYVideoTopBar.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BSYVodOperateViewDelegate <NSObject>

- (void)operateViewReturnBtnAction;
- (void)operateViewPlayAction;
- (void)operateViewRateAction;
- (void)operateViewResolutionAction;
- (void)operateViewVideoSliderProgressUpdate:(float)progress;

@end


@interface BSYVodOperateView : UIView

@property (nonatomic, weak) id<BSYVodOperateViewDelegate> delegate;

- (void)showLoadingView:(BOOL)isShow;
- (void)showOperateView:(BOOL)isShow;
- (void)showErrorMsg:(NSString *)errMsg;
- (void)setVideoTopBarTitle:(NSString *)title;
- (void)switchNetworkState:(BSYVideoTopBarNetworkIcon)state;
- (void)setResolutionTitle:(NSString *)title;
- (void)setVideoDurationTime:(NSTimeInterval)duration;
- (void)updateVideoBufferProgress:(float)bufferProgress;
- (void)updateVideoPlayProgress:(float)progress;
- (void)updatePlayButtonState:(BOOL)isPlaying;
- (void)changedOrientation;


@end

NS_ASSUME_NONNULL_END
