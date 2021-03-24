//
//  BSYLiveViewController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/3/23.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYLiveViewController.h"
#import "BSYLiveOperateView.h"
#import "BSYLivePlayerContainerView.h"
#import "BSYLiveBottomBar.h"
#import "BSYLiveChatInputController.h"
#import "BSYLiveChatMsgView.h"
#import "BSYInteractiveLiveCameraContainer.h"

@interface BSYLiveViewController ()
@property (nonatomic, strong)BSYLiveParam *liveParam;
@property (nonatomic, strong)BSYLiveKit *liveKit;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)BSYLiveOperateView *playerOperateView;

//Live
@property (nonatomic, strong)BSYLivePlayerContainerView *playerContainer;

//课件
@property (nonatomic, strong)UIView *coursewareContainer;
@property (nonatomic, assign)BOOL hasCourseware;


//互动直播
@property (nonatomic, assign)BOOL interactiveEnable;
@property (nonatomic, strong)BSYInteractiveLiveCameraContainer *cameraContainer;
@property (nonatomic, strong)UIView *teacherContainer;
@property (nonatomic, assign)BSYInteractiveLiveHandStatus handStatus; //当前自己的举手状态

@property (nonatomic, assign)BOOL defaultVideoMute; //设置自己视频是否开启
@property (nonatomic, assign)BOOL defaultAudioMute; //当前自己麦克风是否静音

//底部bar
@property (nonatomic, strong)BSYLiveBottomBar *bottomBar;

//IM
@property (nonatomic, strong)BSYLiveChatMsgView *chatMsgView;
@property (nonatomic, strong)BSYLiveChatInputController *chatInputView;



@end

@implementation BSYLiveViewController

- (instancetype)initWithLiveParam:(BSYLiveParam *)liveParam {
    self = [super init];
    if(self) {
        self.liveParam = liveParam;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




@end
