//
//  BSYLiveChatMsgView.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/3.
//

#import "BSYLiveChatMsgView.h"
#import "BSYLiveIMRoleManager.h"
#import "BSYLiveChatViewTheme.h"
#import "BSYLiveIMMsgCellData.h"
#import "BSYLiveIMMsgCell.h"
#import "BSYLiveIMTextMsgCellData.h"
#import "BSYLiveIMTextMsgCell.h"
#import "BSYLiveIMImageMsgCellData.h"
#import "BSYLiveIMImageMsgCell.h"
#import "BSYLiveIMEventNotifyMsgCellData.h"
#import "BSYLiveIMEventNotifyMsgCell.h"
#import "BSYTimer.h"
#import "YBImageBrowser.h"



#define BSYLiveIMMessageController_RequestMsgCount      20
#define BSYLiveIMMessageController_HeaderHeight         10
#define BSYLiveIMMessageController_BottomMargin         20
#define BSYLiveIMMessageController_Width                [UIScreen mainScreen].bounds.size.width


#define BSYLiveIMMessageCellLoadTimer           0.8
#define BSYLiveIMMessageMsgMaxBlockCount        20

#define BSYLiveIMMessageMsgMaxMsgCount          200
#define BSYLiveIMMessageMsgKeepMsgCount         100

#define BSYLiveIMUIMsgsMaxCount                 1000


@interface BSYLiveChatMsgView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BSYLiveIMRoleManager *roleManager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *uiMsgs;
@property (nonatomic, strong) NSMutableArray *heightCache;
@property (nonatomic, assign) BOOL isFirstLoadingMsg;
@property (nonatomic, assign) BOOL isLoadingMsg;
@property (nonatomic, assign) BOOL isScrollBottom;
@property (nonatomic, assign) BOOL noMoreMsg;
@property (nonatomic, assign) BOOL disableRender;

@property (nonatomic, strong) UIImageView *topShadowView;
@property (nonatomic, strong) UIImageView *bottomShadowView;
@property (nonatomic, strong) UIButton *newMsgBtn;
@property (nonatomic, assign) NSInteger newMsgCount;
@property (nonatomic, assign) NSUInteger cellShowIndex;
@property (nonatomic, strong) BSYTimer *showMsgTimer;

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatarUrl;



@end

@implementation BSYLiveChatMsgView


- (void)setSelfUid:(NSString *)uid nickName:(NSString *)nickName avatarUrl:(NSString *)avatarUrl {
    self.uid = uid;
    self.nickName = nickName;
    self.avatarUrl = avatarUrl;
}

- (void)setRoleList:(NSArray *)roleList {
    if(roleList && roleList.count) {
        NSArray<BSYLiveIMRoleModel *> *roleModelList = [BSYLiveIMRoleModel mj_objectArrayWithKeyValuesArray:roleList];
        [self.roleManager initRoleList:roleModelList];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellShowIndex = 0;
    self.isFirstLoadingMsg = YES;
    self.isScrollBottom = YES;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
          self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, BSYLiveIMMessageController_HeaderHeight)];
    self.tableView.tableHeaderView = self.indicatorView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BSYLiveIMMessageController_BottomMargin)];
    self.uiMsgs = [[NSMutableArray alloc] init];
    [self.view addSubview:self.newMsgBtn];
    [self.newMsgBtn addTarget:self action:@selector(newMsgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.newMsgBtn.hidden = YES;
    [self startShowMsgTimer];
}

- (void)changeViewPortraitScreen:(BOOL)isPortrait {
    [self resizeSubviews:isPortrait];
    [self.tableView reloadData];
    [self scrollToBottom:NO];
}

- (void)resizeSubviews:(BOOL)isPortrait {
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    self.tableView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.newMsgBtn.frame = CGRectMake((viewWidth-72)/2.0, viewHeight-20-2, 72, 20);
    [BSYLiveIMMsgCellLayout setMaxCellWidth:viewWidth];
}


#pragma mark ---
#pragma mark 懒加载

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BSYLiveIMTextMsgCell class] forCellReuseIdentifier:NSStringFromClass([BSYLiveIMTextMsgCell class])];
        [_tableView registerClass:[BSYLiveIMImageMsgCell class] forCellReuseIdentifier:NSStringFromClass([BSYLiveIMImageMsgCell class])];
        [_tableView registerClass:[BSYLiveIMEventNotifyMsgCell class] forCellReuseIdentifier:NSStringFromClass([BSYLiveIMEventNotifyMsgCell class])];
    }
    return _tableView;
}

- (BSYLiveIMRoleManager *)roleManager {
    if(!_roleManager) {
        _roleManager = [[BSYLiveIMRoleManager alloc] init];
    }
    return _roleManager;
}

- (UIImageView *)topShadowView {
    if(!_topShadowView) {
        _topShadowView = [[UIImageView alloc] init];
        _topShadowView.userInteractionEnabled = YES;
        _topShadowView.contentMode =UIViewContentModeScaleToFill;
        _topShadowView.image = AssetsImage(@"live_im_msg_top_shadow");
    }
    return _topShadowView;
}

- (UIImageView *)bottomShadowView {
    if(!_bottomShadowView) {
        _bottomShadowView = [[UIImageView alloc] init];
        _bottomShadowView.userInteractionEnabled = YES;
        _bottomShadowView.contentMode =UIViewContentModeScaleToFill;
        _bottomShadowView.image = AssetsImage(@"live_im_msg_bottom_shadow");
    }
    return _bottomShadowView;
}

- (UIButton *)newMsgBtn {
    if(!_newMsgBtn) {
        _newMsgBtn = [[UIButton alloc] init];
        [_newMsgBtn setImage:AssetsImage(@"live_im_new_msgs_btn") forState:UIControlStateNormal];
        [_newMsgBtn setImage:AssetsImage(@"live_im_new_msgs_btn") forState:UIControlStateHighlighted];
    }
    return _newMsgBtn;
}


#pragma mark ---
#pragma mark 业务

- (void)setChatMsgRenderDisable:(BOOL)disable {
    self.disableRender = disable;
    if(!disable) {
       if(self.uiMsgs.count>BSYLiveIMMessageMsgMaxMsgCount) {
            NSRange removeRange = NSMakeRange(0, self.uiMsgs.count-BSYLiveIMMessageMsgKeepMsgCount);
            [self.uiMsgs removeObjectsInRange:removeRange];
       }
        self.cellShowIndex = self.uiMsgs.count;
        [self.heightCache removeAllObjects];
        [self.tableView reloadData];
        [self scrollToBottom:NO];
    }
}

- (void)requestLastMessage {
    if(self.isLoadingMsg || self.noMoreMsg){
        return;
    }
    self.isLoadingMsg = YES;
    if(self.pullLoadingBlock) {
        self.pullLoadingBlock();
    }
}

- (void)showNewMessage:(BOOL)isShow {
    self.newMsgBtn.hidden = !isShow;
}

- (void)inserTableViewCell {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
      @strongify(self);
      if(self.isScrollBottom && self.uiMsgs.count>BSYLiveIMMessageMsgMaxMsgCount) {
          NSRange removeRange = NSMakeRange(0, self.uiMsgs.count-BSYLiveIMMessageMsgKeepMsgCount);
          [self.uiMsgs removeObjectsInRange:removeRange];
          self.cellShowIndex = self.uiMsgs.count;
          [self.tableView reloadData];
          [self.tableView layoutIfNeeded];
      } else {
          if(self.cellShowIndex<self.uiMsgs.count) {
              NSUInteger row = self.cellShowIndex;
              NSMutableArray *indexArray = [NSMutableArray array];
              if((self.uiMsgs.count-self.cellShowIndex)>BSYLiveIMMessageMsgMaxBlockCount) {
                  self.cellShowIndex = self.uiMsgs.count;
              } else {
                  self.cellShowIndex ++;
              }
              
              while (row<self.cellShowIndex) {
                  [indexArray addObject:[NSIndexPath indexPathForRow:row inSection:0]];
                  row ++;
              }
              [self.tableView beginUpdates];
              [self.tableView insertRowsAtIndexPaths:indexArray
              withRowAnimation:UITableViewRowAnimationFade];
              [self.tableView endUpdates];
              if(self.isScrollBottom) {
                 [self scrollToBottom:NO];
              } else {
                  self.newMsgCount += 1;
                  [self showNewMessage:YES];
              }
          }
      }
  });
}

#pragma mark ----
#pragma mark Timer

- (void)startShowMsgTimer {
    if(!self.showMsgTimer) {
        @weakify(self);
        self.showMsgTimer = [BSYTimer scheduledTimerWithTimeInterval:BSYLiveIMMessageCellLoadTimer repeats:YES queue:dispatch_get_main_queue() block:^{
            @strongify(self);
            if(!self.disableRender) {
                [self inserTableViewCell];
            }
        }];
    }
}

- (void)stopShowMsgTimer {
    if(self.showMsgTimer) {
        [self.showMsgTimer invalidate];
        self.showMsgTimer = nil;
    }
}



#pragma mark ----
#pragma mark tableView

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.isScrollBottom == NO) {
//        [self scrollToBottom:NO];
//        if (indexPath.row == self.uiMsgs.count-1) {
//            self.isScrollBottom = YES;
//        }
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellShowIndex;//self.uiMsgs.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    BSYLiveIMMsgCellData *data = self.uiMsgs[indexPath.row];
    height = [data contentSize].height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSYLiveIMMsgCellData *data = self.uiMsgs[indexPath.row];
    BSYLiveIMMsgCell *cell = nil;
    if (!data.reuseId) {
        if([data isKindOfClass:[BSYLiveIMTextMsgCellData class]]) {
          data.reuseId = NSStringFromClass([BSYLiveIMTextMsgCell class]);
        } else if ([data isKindOfClass:[BSYLiveIMImageMsgCellData class]]) {
            data.reuseId = NSStringFromClass([BSYLiveIMTextMsgCell class]);
        } else if ([data isKindOfClass:[BSYLiveIMEventNotifyMsgCellData class]]) {
            data.reuseId = NSStringFromClass([BSYLiveIMTextMsgCell class]);
        } else {
            return nil;
        }
    }
    cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId forIndexPath:indexPath];
    [cell fillWithData:self.uiMsgs[indexPath.row]];
    if(data.reuseId && [data.reuseId isEqualToString:NSStringFromClass([BSYLiveIMImageMsgCell class])]) {
        __block BSYLiveIMImageMsgCellData *imageCellData = (BSYLiveIMImageMsgCellData *)data;
        __block BSYLiveIMImageMsgCell *imageCell = (BSYLiveIMImageMsgCell *)cell;
        cell.tapHandle = ^{
            if(imageCellData) {
                BSYLiveChatMsgImageElem *imageItem = imageCellData.imageInfo;
                if(imageItem) {
                    YBIBImageData *data = [YBIBImageData new];
                    data.imageURL = [imageCellData orgImageUrl];
                    data.projectiveView = imageCell.thumbImageView;
                    YBIBImageLayout *imageLayout = [[YBIBImageLayout alloc] init];
                    imageLayout.horizontalFillType =  YBIBImageFillTypeCompletely;
                    imageLayout.verticalFillType = YBIBImageFillTypeCompletely;
                    data.layout = imageLayout;
                    YBImageBrowser *browser = [YBImageBrowser new];
                    browser.dataSourceArray = @[data];
                    browser.currentPage = 0;
                    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
                    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
                    [browser show];
                }
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark ---
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if(bottomOffset-20 <= height) {
        self.newMsgCount = 0;
        [self showNewMessage:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y <= 0){
        [self requestLastMessage];
    }
    [self setScrollBottomStatus];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setScrollBottomStatus];
}

- (void)setScrollBottomStatus {
    CGFloat height = self.tableView.frame.size.height;
    CGFloat contentOffsetY = self.tableView.contentOffset.y;
    CGFloat bottomOffset = self.tableView.contentSize.height - contentOffsetY;
    if (bottomOffset-20 <= height) {
       //在最底部
        self.isScrollBottom = YES;
        self.newMsgCount = 0;
        [self showNewMessage:NO];
    } else {
       self.isScrollBottom = NO;
    }
}

- (void)scrollToBottom:(BOOL)animate {
    if (self.uiMsgs.count > 0) {
        self.isScrollBottom = YES;
        CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
        if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
            yOffset = self.tableView.contentSize.height - self.tableView.frame.size.height;
            [self.tableView setContentOffset:CGPointMake(0, yOffset) animated:animate];
        }
    }
}



#pragma mark ---
#pragma mark IM消息

- (BSYLiveIMMsgCellData *)converChatMsgModelToChatMsgUIData:(BSYLiveChatMsgModel *)msgModel {
    BSYLiveIMMsgCellData *data = nil;
    if(msgModel) {
        if(msgModel.msgType==BSYLiveChatMsgTypeText) {
            BSYLiveChatMsgTextElem *textElem = msgModel.textElem;
            if(textElem) {
                BSYLiveIMTextMsgCellData *textData = [[BSYLiveIMTextMsgCellData alloc] init];
                textData.content = textElem.message;
                data = (id)textData;
            }
        } else if(msgModel.msgType==BSYLiveChatMsgTypeImage) {
            BSYLiveChatMsgImageElem *imgElem = msgModel.imageElem;
            if(imgElem) {
                BSYLiveIMImageMsgCellData *imageData = [[BSYLiveIMImageMsgCellData alloc] init];
                imageData.imageInfo = imgElem;
                data = (id)imageData;
            }
        }
        if(data) {
            data.identifier = msgModel.userId;
            data.name = msgModel.nickName;
            if(msgModel.userId && [msgModel.userId isEqualToString:self.uid]) {
                data.roleType = BSYLiveIMRoleType_Self;
            } else {
                data.roleType = [self.roleManager getRoleType:msgModel.userId];
            }
        }
    }
    return data;
}

- (void)addSelfTextMsg:(NSString *)text {
    BSYLiveIMTextMsgCellData *textData = [[BSYLiveIMTextMsgCellData alloc] init];
    textData.content = text;
    textData.identifier = self.uid;
    textData.name = self.nickName?self.nickName:self.uid;
    textData.roleType = BSYLiveIMRoleType_Self;
    [self.uiMsgs insertObject:textData atIndex:self.cellShowIndex];
}

- (void)insertLastMsgHistoryList:(NSArray<BSYLiveChatMsgModel *> *)msgList {
    if(msgList && msgList.count>0) {
        NSMutableArray *list = [NSMutableArray array];
        for (BSYLiveChatMsgModel *msgModel in msgList) {
            BSYLiveIMMsgCellData *data = [self converChatMsgModelToChatMsgUIData:msgModel];
            [list addObject:data];
        }
        if(list.count>0) {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, list.count)];
            [self.uiMsgs insertObjects:list atIndexes:indexSet];
            self.cellShowIndex = self.uiMsgs.count;
            [self.heightCache removeAllObjects];
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            if(!self.isFirstLoadingMsg){
                CGFloat visibleHeight = 0;
                for (NSInteger i = 0; i < list.count; ++i) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    visibleHeight += [self tableView:self.tableView heightForRowAtIndexPath:indexPath];
                }
                if(self.noMoreMsg){
                    visibleHeight -= BSYLiveIMMessageController_HeaderHeight;
                }
                [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentOffset.y + visibleHeight, self.tableView.frame.size.width, self.tableView.frame.size.height) animated:NO];
            } else {
                [self scrollToBottom:NO];
            }
        }
    } else {
        self.noMoreMsg = YES;
    }
    self.isLoadingMsg = NO;
    self.isFirstLoadingMsg = NO;
}

- (void)addChatMsg:(BSYLiveChatMsgModel *)msgModel {
    
    BSYLiveIMMsgCellData *data = [self converChatMsgModelToChatMsgUIData:msgModel];
    if(data) {
        if(self.uiMsgs.count>BSYLiveIMUIMsgsMaxCount) {
            NSInteger local = MAX(self.cellShowIndex,BSYLiveIMUIMsgsMaxCount/2);
            NSInteger length = self.uiMsgs.count-local;
            [self.uiMsgs removeObjectsInRange:NSMakeRange(local,length)];
        }
        [self.uiMsgs addObject:data];
    }
}

- (void)addEventNotify:(BSYLiveEventNotifyModel *)notifyModel {
    if(notifyModel) {
        BSYLiveIMEventNotifyMsgCellData *eventData = [[BSYLiveIMEventNotifyMsgCellData alloc] init];
        eventData.actionName = notifyModel.nickname;
        eventData.action = notifyModel.templateMsg;
        eventData.event = notifyModel.name;
        eventData.isCustomizeStyle = NO;
        if(notifyModel.eventType==BSYLiveEventNotifyType_RedPacket) {
            eventData.actionColor =  BSYLiveIMEventNotifyMessage_RedPacketColor;
            eventData.eventColor = BSYLiveIMEventNotifyMessage_RedPacketColor;
        } else if (notifyModel.eventType==BSYLiveEventNotifyType_Purchase) {
            eventData.actionColor = BSYLiveIMEventNotifyMessage_PurchaseColor;
            eventData.eventColor = BSYLiveIMEventNotifyMessage_PurchaseColor;
        } else if (notifyModel.eventType==BSYLiveEventNotifyType_Customize) {
            eventData.eventColor = BSYLiveIMEventNotifyMessage_PurchaseColor;
            eventData.isCustomizeStyle = YES;
            eventData.customizeStyleDetail = notifyModel.contentTextStyleList;
        }
        if(self.uiMsgs.count>BSYLiveIMUIMsgsMaxCount) {
            NSInteger local = MAX(self.cellShowIndex,BSYLiveIMUIMsgsMaxCount/2);
            NSInteger length = self.uiMsgs.count-local;
            [self.uiMsgs removeObjectsInRange:NSMakeRange(local,length)];
        }
        [self.uiMsgs addObject:eventData];
    }
}


- (void)newMsgBtnAction {
    [self scrollToBottom:YES];
}

- (void)dealloc {
    [self stopShowMsgTimer];
}


@end
