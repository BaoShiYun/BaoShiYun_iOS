//
//  BSYVideoBottomBar.h
//  KaiKeBa
//
//  Created by zddMac on 2019/3/14.
//  Copyright © 2019 kaikeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSYVideoBottomBarDelegate <NSObject>

- (void)bottomBarPlayAction;
- (void)bottomBarRateAction;
- (void)bottomBarResolutionAction;
- (void)bottomBarVideoSliderProgressUpdate:(float)progress;

@end


@interface BSYVideoBottomBar : UIView
@property (nonatomic, weak) id<BSYVideoBottomBarDelegate> delegate;

- (void)setResolutionTitle:(NSString *)title;
- (void)setVideoDurationTime:(NSTimeInterval)duration;
- (void)updateVideoBufferProgress:(float)bufferProgress;
- (void)updateVideoPlayProgress:(float)progress;
- (void)updatePlayButtonState:(BOOL)isPlaying;

@end







