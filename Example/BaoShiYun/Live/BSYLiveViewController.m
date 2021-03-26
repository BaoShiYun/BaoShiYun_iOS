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
#import <AVFoundation/AVFoundation.h>
#import "BSYAlertViewController.h"
#import "BSYInteractiveControlView.h"
#import "BSYLiveMenuViewController.h"
#import "BSYLiveRouteOptionController.h"
#import "BSYLiveResolutionOptionController.h"

@interface BSYLiveViewController ()<BSYLiveKitDelegate,BSYInteractiveLiveCameraContainerDelegate,BSYLiveOperateViewDelegate>
@property (nonatomic, strong)BSYLiveParam *liveParam;
@property (nonatomic, strong)BSYLiveKit *liveKit;
@property (nonatomic, assign)BOOL isLivePlaying;
@property (nonatomic, assign)BOOL isRtc;

@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)BSYLiveOperateView *playerOperateView;
@property (nonatomic, strong)UIView *lineView;

//Live
@property (nonatomic, strong)BSYLivePlayerContainerView *playerContainer;

//课件
@property (nonatomic, strong)UIView *coursewareContainer;
@property (nonatomic, assign)BOOL hasCourseware;

//互动直播
@property (nonatomic, assign)BOOL interactiveEnable;
@property (nonatomic, strong)BSYInteractiveLiveCameraContainer *cameraContainer;
@property (nonatomic, assign)BSYInteractiveLiveHandStatus handStatus; //当前自己的举手状态

@property (nonatomic, assign)BOOL defaultVideoMute; //设置自己视频是否开启
@property (nonatomic, assign)BOOL defaultAudioMute; //当前自己麦克风是否静音

//底部bar
@property (nonatomic, strong)BSYLiveBottomBar *bottomBar;

//IM
@property (nonatomic, strong)BSYLiveChatMsgView *chatMsgView;
@property (nonatomic, strong)BSYLiveChatInputController *chatInputView;


//SheetView弹窗
@property (nonatomic, strong)BSYAlertViewController *sheetView;


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
    self.view.backgroundColor = HexAlphaColor(0x0C0C0C, 1.0);
    self.handStatus = BSYInteractiveLiveHandStatus_UnHand;
    if (@available(iOS 11, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.playerContainer];
    [self.headView addSubview:self.coursewareContainer];
    [self.view addSubview:self.playerOperateView];
    [self.view addSubview:self.lineView];
    self.lineView.hidden = YES;
    [self.view addSubview:self.cameraContainer];
    self.cameraContainer.hidden = YES;
    [self.view addSubview:self.chatMsgView.view];
    [self addChildViewController:self.chatMsgView];
    @weakify(self);
    self.chatMsgView.pullLoadingBlock = ^{
        @strongify(self);
        [self requestLastestChatMsgHistory];
    };
    [self.view addSubview:self.bottomBar];
    [self.bottomBar setInteractiveEnable:NO];
    [self.bottomBar setLiveHandStatus:self.handStatus];
    
    
    self.bottomBar.actionBlock = ^(BSYLiveBottomBarActionType type) {
        @strongify(self);
        switch (type) {
            case BSYLiveBottomBarActionType_Like: {
                [self.liveKit addLikeCount:1];
            }
                break;
            case BSYLiveBottomBarActionType_TextInput: {
                [self showInputKeyboardView];
            }
                break;
            case BSYLiveBottomBarActionType_More: {
                [self showMenuView];
            }
                break;
            case BSYLiveBottomBarActionType_InteractiveHand: {
                
                [self.liveKit raiseHandRequestSucc:^{

                } fail:^(NSInteger code, NSString *desc) {
                    @strongify(self);
                    [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_UnHand];
                    [BSYHud showHUDError:desc];
                    
                }];
            }
                break;
            case BSYLiveBottomBarActionType_InteractiveUnHand: {
                [self.liveKit cancelRaiseHandSucc:^{
                   
                } fail:^(NSInteger code, NSString *desc) {
                    @strongify(self);
                    [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_Handing];
                    [BSYHud showHUDError:desc];
                }];
            }
                break;
            case BSYLiveBottomBarActionType_InteractiveOffStage: {
                [self showInteractiveControlView];
            }
                break;
            default:
                break;
        }
    };
    
    self.chatInputView.inputBlock = ^(NSString * _Nonnull string) {
        @strongify(self);
        [self.liveKit sendTextMsg:string succ:^{
            
        } fail:^(NSInteger code, NSString *desc) {
            
        }];
        [self.chatMsgView addSelfTextMsg:string];
    };
    
    [self loginLiveRoom];
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    CGFloat headViewHeight =  (UISCREEN_WIDTH*3.0/4.0);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(IPHONE_MARGIN_TOP);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(headViewHeight);
        make.width.mas_equalTo(UISCREEN_WIDTH);
    }];
    [self.playerContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.headView);
            
    }];
    [self.coursewareContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.headView);
            
    }];
    [self.playerOperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.headView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    CGFloat cameraHeight = UISCREEN_WIDTH/4.0*3.0/4.0;
    [self.cameraContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(cameraHeight);
    }];
    CGFloat bottomBarHeight = (IPHONE_MARGIN_BOTTOM>0?IPHONE_MARGIN_BOTTOM:0)+56;
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(bottomBarHeight);
    }];
    [self resizeChatViewWithRtc:self.isRtc];
}

- (void)resizeChatViewWithRtc:(BOOL)isRtc {
    @weakify(self);
    if(isRtc) {
        [self.chatMsgView.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.cameraContainer.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.bottomBar.mas_top);
        }];
    } else {
        [self.chatMsgView.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.lineView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.bottomBar.mas_top);
        }];
    }
}


#pragma mark ----
#pragma mark 懒加载
- (UIView *)headView {
    if(!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

- (BSYLiveOperateView *)playerOperateView {
    if(!_playerOperateView) {
        _playerOperateView = [[BSYLiveOperateView alloc] init];
        _playerOperateView.delegate = self;
    }
    return _playerOperateView;
}

- (BSYLivePlayerContainerView *)playerContainer {
    if(!_playerContainer) {
        _playerContainer = [[BSYLivePlayerContainerView alloc] init];
    }
    return _playerContainer;
}

- (UIView *)coursewareContainer {
    if(!_coursewareContainer) {
        _coursewareContainer = [[UIView alloc] init];
    }
    return _coursewareContainer;
}

- (UIView *)lineView {
    if(!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HexAlphaColor(0x2C2C2E, 1.0);
    }
    return _lineView;
}

- (BSYLiveKit *)liveKit {
    if(!_liveKit) {
        _liveKit = [[BSYLiveKit alloc] initWithParameter:self.liveParam];
        [_liveKit setMainVideoContainerView:self.playerContainer];
        _liveKit.delegate = self;
    }
    return _liveKit;
}


- (BSYInteractiveLiveCameraContainer *)cameraContainer {
    if(!_cameraContainer) {
        _cameraContainer = [[BSYInteractiveLiveCameraContainer alloc] init];
        _cameraContainer.roomDelegate = self;
        _cameraContainer.mySeat.userId = self.liveParam.userId;
        _cameraContainer.mySeat.nickName = self.liveParam.nickName;
        _cameraContainer.mySeat.avatarUrl = self.liveParam.avatarUrl;
    }
    return _cameraContainer;
}

- (BSYLiveBottomBar *)bottomBar {
    if(!_bottomBar) {
        _bottomBar = [[BSYLiveBottomBar alloc] init];
        _bottomBar.likeBtn.favorDisplayView = self.view;
    }
    return _bottomBar;
}

- (BSYLiveChatMsgView *)chatMsgView {
    if(!_chatMsgView) {
        _chatMsgView = [[BSYLiveChatMsgView alloc] init];
    }
    return _chatMsgView;
}

- (BSYLiveChatInputController *)chatInputView {
    if(!_chatInputView) {
        _chatInputView = [[BSYLiveChatInputController alloc] init];
        _chatInputView.status = BSYLiveIMInputStatus_InputNone;
        _chatInputView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        _chatInputView.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _chatInputView;
}




#pragma mark ---
#pragma mark 音视频权限
- (BOOL)authorizationStatusIsAllowForMediaType:(AVMediaType)mediaType{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus==AVAuthorizationStatusRestricted || authStatus==AVAuthorizationStatusDenied) {
        return NO;
    } else {
        return YES;
    }
}

- (void)requestAuthorizationForMediaType:(AVMediaType)mediaType {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)showMediaAuthorizationAlert:(AVMediaType)mediaType {
    NSString *title = @"";
    NSString *detail = @"";
    if([mediaType isEqualToString:AVMediaTypeVideo] || [mediaType isEqualToString:AVMediaTypeAudio]) {
        if([mediaType isEqualToString:AVMediaTypeVideo]) {
            title = @"无法开启摄像头";
            detail = @"请在系统的“设置-隐私-相机”选项中，允许访问你的手机相机";
        } else if ([mediaType isEqualToString:AVMediaTypeAudio]) {
            title = @"无法开启麦克风";
            detail = @"请在系统的“设置-隐私-麦克风”选项中，允许访问你的手机麦克风";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                  
        }];
        [alert addAction:cancelAction];
        @weakify(self);
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"前往设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self requestAuthorizationForMediaType:mediaType];
        }];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark ----
#pragma mark Menu

//展示菜单页面
- (void)showMenuView {
    [self clearSheetView];
    BSYLiveMenuViewController *menuController = [[BSYLiveMenuViewController alloc] initWithStyle:KKBAlertControllerStyle_ActionSheet];
    self.sheetView = menuController;
    [menuController showInController:self];
    @weakify(self);
    menuController.menuBlock = ^(BSYLiveMenuType menuType) {
        @strongify(self);
        switch (menuType) {
            case BSYLiveMenuType_Cancel: {
                self.sheetView = nil;
            }
                break;
            case BSYLiveMenuType_Resolution: {
                [self showLiveResolutionOptionView];
            }
                break;
            case BSYLiveMenuType_Route: {
                [self showLiveRouteOptionView];
            }
                break;
            default:
                break;
        }
    };
}

//展示清晰度页面
- (void)showLiveResolutionOptionView {
    [self clearSheetView];
    BSYLiveLineModel *lineModel = [self.liveKit getCurrentLiveLine];
    if(lineModel) {
        BSYLiveResolutionOptionController *resolutionOptionView = [[BSYLiveResolutionOptionController alloc] initResolutionList:[self.liveKit getResolutionListWithLineId:lineModel.lineId] currentResolution:[self.liveKit getCurrentLiveResolution]];
        self.sheetView = resolutionOptionView;
        [resolutionOptionView showInController:self];
        @weakify(self);
        resolutionOptionView.selectedBlock = ^(BSYLiveResolutionModel * _Nonnull selectedResolution) {
            @strongify(self);
            self.sheetView = nil;
            [BSYHud showHUDMessage:[NSString stringWithFormat:@"正在切换%@...请稍后",selectedResolution.resolutionName]];
            [self.playerOperateView showLoadingView];
            [self.liveKit switchResolution:selectedResolution.resolution  succ:^{
            } fail:^(NSInteger code, NSString *desc) {
                [self.playerOperateView hideLoadingView];
            }];
        };
        
        resolutionOptionView.cancelBlock = ^{
            @strongify(self);
            self.sheetView = nil;
        };
    }
}

//展示线路页面
- (void)showLiveRouteOptionView {
    [self clearSheetView];
    BSYLiveRouteOptionController *routeOptionView  = [[BSYLiveRouteOptionController alloc] initRouteList:[self.liveKit getLiveLineList] currentRoute:[self.liveKit getCurrentLiveLine]];
    self.sheetView = routeOptionView;
    [routeOptionView showInController:self];
    @weakify(self);
    routeOptionView.selectedBlock = ^(BSYLiveLineModel * _Nonnull selectedRoute) {
        @strongify(self);
        self.sheetView = nil;
        [BSYHud showHUDMessage:[NSString stringWithFormat:@"正在切换%@...请稍后",selectedRoute.lineName]];
        [self.playerOperateView showLoadingView];
        [self.liveKit switchLineWithId:selectedRoute.lineId succ:^{
                    
        } fail:^(NSInteger code, NSString *desc) {
            [self.playerOperateView hideLoadingView];
        }];
    };
    
    routeOptionView.cancelBlock = ^{
        @strongify(self);
        self.sheetView= nil;
    };
}

#pragma mark ---
#pragma mark IM
- (void)requestLastestChatMsgHistory {
    @weakify(self);
    [self.liveKit getLastMessageHistorySucc:^(NSArray<BSYLiveChatMsgModel *> *msgList) {
        @strongify(self);
        [self.chatMsgView insertLastMsgHistoryList:msgList];
    } fail:^(NSInteger code, NSString *desc) {
    }];
}



- (void)showInputKeyboardView {
    self.chatInputView.status = BSYLiveIMInputStatus_InputKeyboard;
    [self presentViewController:self.chatInputView animated:NO completion:nil];
}

- (void)showInputFaceView {
    self.chatInputView.status = BSYLiveIMInputStatus_InputFace;
    [self presentViewController:self.chatInputView animated:NO completion:nil];
}

- (void)hideInputView {
    [self.chatInputView resetInputWithAnimated:NO];
}

#pragma mark -----
#pragma mark 更新直播间
- (void)initLiveRoomFinish {
    [self.playerOperateView setLiveTitle:[self.liveKit getLiveName]];
    self.isRtc = [self.liveKit isRtcLive];
    [self.bottomBar setIsRtc:self.isRtc];
    self.cameraContainer.hidden = !self.isRtc;
    self.lineView.hidden = self.isRtc;
    if(self.isRtc) {
        [self.cameraContainer reloadData];
    }
    [self resizeChatViewWithRtc:self.isRtc];
    [self requestLastestChatMsgHistory];
}

- (void)resetLiveRoom {
    [self logoutLiveRoom];
}

- (void)closeView {
    [self resetLiveRoom];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginLiveRoom {
    [self.playerOperateView showLoadingView];
    [self.liveKit loginLive];
}
- (void)logoutLiveRoom {
    [self.liveKit logoutLive];
}

- (void)refreshLiveRoomWithLoadingView:(BOOL)isShow {
    if(isShow) {
        [self.playerOperateView showLoadingView];
    }
    @weakify(self);
    [self.liveKit refreshLiveSucc:^{
        @strongify(self);
        if(isShow) {
            [self.playerOperateView hideLoadingView];
        }
    } fail:^(NSInteger code, NSString *desc) {

        if(isShow) {
            [BSYHud showHUDError:@"刷新直播间失败"];
        }
    }];
}


#pragma mark ----
#pragma mark SheetView
- (void)clearSheetView {
    if(_sheetView) {
        [_sheetView dismissAnimated:NO];
        _sheetView = nil;
    }
    [self hideInputView];
}



#pragma mark ----
#pragma mark BSYInteractiveLiveCameraContainerDelegate

- (void)loadCell:(BSYInteractiveLiveCameraCell *)cell index:(NSInteger)index {
    if (cell.isEmpty) {
        return;
    }
    if (cell.isTeacher) {
        [self.liveKit setTeacherVideoContainerView:cell.mediaContentView];
        
    } else if (cell.isSelf) {
        [self.liveKit setSelfBroadcastVideoContainerView:cell.mediaContentView];
    } else {
        [self.liveKit setRemoteUserVideoContainerViewWithUid:cell.uid containerView:cell.mediaContentView];
    }
}




#pragma mark ---
#pragma mark BSYLiveOperateViewDelegate

- (void)operateViewReturnButtonAction {
    if(self.isLivePlaying) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你确认结束观看吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                  
        }];
        [alert addAction:cancelAction];
        @weakify(self);
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self closeView];
        }];
        [alert addAction:confirmAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        [self closeView];
    }
}


#pragma mark ---
#pragma mark 互动

- (void)confirmInvitOnStageStatus:(BOOL)isAgree withFromTeacherId:(NSString *)teacherId {
    [self.liveKit confirmInvitBroadcast:isAgree  withTeacherId:teacherId succ:^{
            
    } fail:^(NSInteger code, NSString *desc) {
            
    }];
}

- (void)onStageMsgAlert:(NSString *)teacherId {
    @weakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"老师向你发起上台邀请，确定要接受上台吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self confirmInvitOnStageStatus:NO withFromTeacherId:teacherId];
    }];
    [alert addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"接受" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self confirmInvitOnStageStatus:YES withFromTeacherId:teacherId];
    }];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)showInteractiveControlView {
    [self clearSheetView];
    BOOL videoAuthStatus = [self authorizationStatusIsAllowForMediaType:AVMediaTypeVideo];
    BOOL audioAuthStatus = [self authorizationStatusIsAllowForMediaType:AVMediaTypeAudio];
    BOOL camStatus = (videoAuthStatus&&![self.liveKit getSelfBroadcastVideoMute])?YES:NO;
    BOOL micStatus = (audioAuthStatus&&![self.liveKit getSelfBroadcastAudioMute])?YES:NO;
    BSYInteractiveControlView *controllView  = [[BSYInteractiveControlView alloc] initWithCamEnable:![self.liveKit getSelfBroadcastVideoDisable] withCamStatus:camStatus withMicEnable:![self.liveKit getSelfBroadcastAudioDisable] withMicStatus:micStatus];
    self.sheetView = controllView;
    [controllView showInController:self];
    @weakify(self);
    controllView.cancelBlock = ^{
        @strongify(self);
        self.sheetView = nil;
    };
    controllView.camBlock = ^(BOOL isOpen) {
        @strongify(self);
        if(isOpen && !videoAuthStatus) {
            [self clearSheetView];
            //摄像头验证
            [self performSelector:@selector(showMediaAuthorizationAlert:) withObject:AVMediaTypeVideo afterDelay:0.5];
        } else {
            [self.liveKit modifyBroadcastMuteVideo:!isOpen];
        }
        
    };
    controllView.micBlock = ^(BOOL isOpen) {
        @strongify(self);
        if(isOpen && !audioAuthStatus) {
            [self clearSheetView];
            [self performSelector:@selector(showMediaAuthorizationAlert:) withObject:AVMediaTypeAudio afterDelay:0.5];
        } else {
            [self.liveKit modifyBroadcastMuteAudio:!isOpen];
        }
    };
    controllView.offStageBlock = ^{
        @strongify(self);
        [self.liveKit disConnectBroadcastSucc:^{
            
        } fail:^(NSInteger code, NSString *desc) {
            [BSYHud showHUDError:desc];
        }];
    };
}




#pragma mark ---
#pragma mark BSYLiveKitDelegate


#pragma mark 直播基础相关回调
- (void)loginSuccess {
    [self initLiveRoomFinish];
    [self.playerOperateView hideLoadingView];
    [self.playerContainer setContainerPlayerStatus:BSYLivePlayerStatus_UnStart];
}

- (void)loginFail:(NSInteger)code message:(NSString *)msg {
    [self logoutLiveRoom];
    @weakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"直播间登录失败，点击确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self closeView];
    }];
    [alert addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}


- (void)onRecvForceOffline {
    [self logoutLiveRoom];
    @weakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号在别处登录，点击确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self closeView];
    }];
    [alert addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}


- (void)onRecvUserSigExpired {
    [self logoutLiveRoom];
    @weakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"授权过期,点击确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self closeView];
    }];
    [alert addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)onRecvLiveUserInfo:(BSYLiveUserInfo *)userInfo {
    [self.chatMsgView setSelfUid:userInfo.userId nickName:userInfo.nickName avatarUrl:userInfo.avatarUrl];
    self.cameraContainer.mySeat.userId = userInfo.userId;
    self.cameraContainer.mySeat.nickName = userInfo.nickName;
    self.cameraContainer.mySeat.avatarUrl = userInfo.avatarUrl;
}

- (void)onRecvLiveRoleList:(NSArray *)roleList {
    [self.chatMsgView setRoleList:roleList];
}

- (void)onRecvLiveOnlineCountDisplay:(BOOL)isDisplay {
    [self.playerOperateView setStudentCountShow:isDisplay];
}


- (void)onRecvLiveOnlineCount:(NSUInteger)onlineCount {
   [self.playerOperateView setStudentCount:onlineCount];
}


- (void)onRecvLikeTotalCount:(NSUInteger)totalCount newAddCount:(NSUInteger)addCount {
    [self.bottomBar setLikeCount:totalCount newAddCount:addCount];
}


- (void)onRecvLiveRoomAllMuteStatus:(BOOL)isAllMute {
    [self.bottomBar setAllMute:isAllMute];
}


#pragma mark 直播状态相关回调
- (void)onRecvLiveStatusChangeStart {
    self.isLivePlaying = YES;
    [self.playerContainer setContainerPlayerStatus:BSYLivePlayerStatus_Living];
    [self.playerOperateView showLoadingView];
    [self.bottomBar setInteractiveEnable:self.interactiveEnable];
}

- (void)onRecvLiveStatusChangeEnd:(BOOL)normalEnd {
    if(normalEnd) {
        self.isLivePlaying = NO;
        [self.playerOperateView hideLoadingView];
        [self.playerContainer setContainerPlayerStatus:BSYLivePlayerStatus_LiveEnd];
    } else {
        [BSYHud showHUDError:@"直播出错啦"];
    }
    [self.bottomBar setInteractiveEnable:NO];
    [self.liveKit removeTeacherVideoContainerView];
}


- (void)onRecvLivePreparePlaying {
    
}

- (void)onRecvLiveStatusPlaying:(BOOL)isPlaying {
    [self.playerOperateView hideLoadingView];
}


- (void)onRecvLiveStatusBuffering:(BOOL)isBuffering {
    if(isBuffering) {
        [self.playerOperateView showLoadingView];
    } else {
        [self.playerOperateView hideLoadingView];
    }
    
}


- (void)onRecvCurrentLiveLine:(BSYLiveLineModel *)lineModel resolution:(BSYLiveResolutionModel *)resolutionModel {
    
}

#pragma mark Rtc互动直播回调

- (void)onRecvLiveInteractiveType:(BSYLiveInteractiveType)InteractiveType {
    if(InteractiveType==BSYLiveInteractiveType_None) {
        self.interactiveEnable = NO;
        [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_UnHand];
    } else if(InteractiveType==BSYLiveInteractiveType_VideoAndAudio) {
        self.interactiveEnable = YES;
    } else if(InteractiveType==BSYLiveInteractiveType_Audio) {
        self.interactiveEnable = YES;
    }
    if(self.isLivePlaying) {
        [self.bottomBar setInteractiveEnable:self.interactiveEnable];
    }
}


- (void)onRecvTeacherAudioMute:(BOOL)audioMute {
    self.cameraContainer.teacher.audioMute = audioMute;
    [self.cameraContainer cellForTeacher].audioMute = audioMute;
}

- (void)onRecvTeacherVideoMute:(BOOL)videoMute {
    self.cameraContainer.teacher.videoMute = videoMute;
    [self.cameraContainer cellForTeacher].videoMute = videoMute;
}



- (void)onRecvTeacherVolumeChange:(NSUInteger)volumeValue {
    [self.cameraContainer cellForTeacher].volume = volumeValue;
}

- (void)onRecvInvitBroadcastFromTeacherUid:(NSString *)uid {
    [self clearSheetView];
    [self performSelector:@selector(onStageMsgAlert:) withObject:uid afterDelay:0.5];
}

- (void)onRecvSelfBroadcastConnectChangeStatus:(BOOL)isConnect  withReasonType:(BSYLiveInteractiveStatusReasonType)reasonType {
    self.cameraContainer.isOnStage = isConnect;
    if(isConnect) {
        if(reasonType==BSYLiveInteractiveStatusReasonType_TeacherConfirm) {
            [BSYHud showHUDError:@"您已经上台"];
        }
        [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_OnStage];
        
    } else {
        if(reasonType==BSYLiveInteractiveStatusReasonType_TeacherCancel) {
            [BSYHud showHUDError:@"您已被老师请下台"];
        }
        [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_UnHand];
    }
}

- (void)onRecvSelfRaiseHandChangeStatus:(BOOL)isRaiseHand withReasonType:(BSYLiveInteractiveStatusReasonType)reasonType {
    if(isRaiseHand) {
        [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_Handing];
    } else {
        if(reasonType==BSYLiveInteractiveStatusReasonType_TeacherCancel) {
            [BSYHud showHUDError:@"您已被老师请出等候队列"];
        }
        [self.bottomBar setLiveHandStatus:BSYInteractiveLiveHandStatus_UnHand];
    }
}


- (void)onRecvAllBroadcastAudioDisable:(BOOL)allAudioDisable {
    if(allAudioDisable) {
       // [BSYHud showHUDError:@"你已被老师关闭麦克风"];
        //self.cameraContainer.audioDisable = allAudioDisable;
    }
    
}


- (void)onRecvSelfBroadcastAudioDisable:(BOOL)audioDisable {
    self.cameraContainer.audioDisable = audioDisable;
    if(audioDisable) {
        [BSYHud showHUDError:@"您已被老师关闭麦克风"];
    }
    
}

- (void)onRecvSelfBroadcastVideoDisable:(BOOL)videoDisable {
    self.cameraContainer.videoDisable = videoDisable;
    if(videoDisable) {
        [BSYHud showHUDError:@"您已被老师关闭摄像头"];
    }
    
}


- (void)onRecvSelfBroadcastAudioMute:(BOOL)audioMute {
    self.cameraContainer.mySeat.audioMute = audioMute;
    [self.cameraContainer cellForMyself].audioMute = (audioMute || [self.liveKit getSelfBroadcastAudioDisable]);
}


- (void)onRecvSelfBroadcastVideoMute:(BOOL)videoMute {
    self.cameraContainer.mySeat.videoMute = videoMute;
    [self.cameraContainer cellForMyself].videoMute = (videoMute || [self.liveKit getSelfBroadcastVideoDisable]);
}



- (void)onRecvSelfBroadcastVolumeChange:(NSUInteger)volumeValue {
    [self.cameraContainer cellForMyself].volume = volumeValue;
}


- (void)onRecvRemoteBroadcastAudioMute:(BOOL)audioMute withUid:(NSString *)uid {
    [self.cameraContainer seatForUser:uid].audioMute = audioMute;
    [self.cameraContainer cellForUser:uid].audioMute = audioMute;
}

- (void)onRecvRemoteBroadcastVideoMute:(BOOL)videoMute withUid:(NSString *)uid {
    [self.cameraContainer seatForUser:uid].videoMute = videoMute;
    [self.cameraContainer cellForUser:uid].videoMute = videoMute;
}


- (void)onRecvRemoteBroadcastVolumeChangeWithUid:(NSString *)uid volumeValue:(NSUInteger)volumeValue {
    [self.cameraContainer cellForUser:uid].volume = volumeValue;
}

- (void)onRecvRemoteBroadcastUserListChange:(NSArray<BSYLiveBroadcastUserModel *> *)remoteUserList {
    self.cameraContainer.remoteUserList = remoteUserList;
    
}




#pragma mark 白板相关回调
- (void)onRecvWhiteboardMode:(BOOL)hasWhiteboard {
    self.hasCourseware = hasWhiteboard;
    self.coursewareContainer.hidden = !hasWhiteboard;
    if(self.hasCourseware) {
        [self.liveKit setWhiteboardContainer:self.coursewareContainer];
    } else {
        [self.liveKit quitWhiteboard];
    }
}

- (void)onRecvChatMessage:(BSYLiveChatMsgModel *)msg {
    [self.chatMsgView addChatMsg:msg];
}


#pragma mark 业务工具相关回调
- (void)onRecvExamUrl:(NSString *)url {
    if(url) {
        @weakify(self);
        [self.liveKit getQuestionTokenSucc:^(NSString *token) {
            @strongify(self);
            NSURL *questionUrl = [NSURL URLWithString:url];
            NSString *actionUrl = [NSString stringWithFormat:@"%@%@token=%@&theme=dark", url, questionUrl.query.length>0 ? @"&":@"?",token];
           //todo 展示评测页面
            
        } fail:^(NSInteger code, NSString *desc) {
            [BSYHud showHUDError:desc];
        }];
    }
}

- (void)onRecvCommonUrl:(NSString *)url {
    //通用链接
}

#pragma mark 直播带货相关回调
- (void)onRecvRedPacketUrl:(NSString *)url {
    //口令红包页面链接
}

- (void)onRecvProductsOnShelf:(BSYLiveShelfModel *)shelfModel {
    //展示货架
}

- (void)onRecvProductsOffShelf:(BSYLiveShelfModel *)shelfModel {
    //移除货架
}


- (void)onRecvEventNotify:(BSYLiveEventNotifyModel *)notifyModel {
    if(notifyModel.showPosition==BSYLiveEventNotifyPosition_Barrage || notifyModel.showPosition==BSYLiveEventNotifyPosition_BothImAndBarrage) {
        //todo 展示弹幕消息
    }
    if(notifyModel.showPosition==BSYLiveEventNotifyPosition_ImMessage || notifyModel.showPosition==BSYLiveEventNotifyPosition_BothImAndBarrage) {
        [self.chatMsgView addEventNotify:notifyModel];
    }
    
}



@end
