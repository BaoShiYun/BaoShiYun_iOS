//
//  BSYLiveChatMsgView.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/3.
//

NS_ASSUME_NONNULL_BEGIN


typedef void (^BSYLiveChatMsgViewPullLoadingBlock)(void);

@interface BSYLiveChatMsgView : UIViewController

@property (nonatomic, copy)BSYLiveChatMsgViewPullLoadingBlock pullLoadingBlock;


//重新布局UI根据横竖屏
- (void)changeViewPortraitScreen:(BOOL)isPortrait;


- (void)setSelfUid:(NSString *)uid nickName:(NSString *)nickName avatarUrl:(NSString *)avatarUrl;

- (void)setChatMsgRenderDisable:(BOOL)disable;

- (void)setRoleList:(NSArray *)roleList;


- (void)addSelfTextMsg:(NSString *)text;

- (void)insertLastMsgHistoryList:(NSArray<BSYLiveChatMsgModel *> *)msgList;

- (void)addChatMsg:(BSYLiveChatMsgModel *)msgModel;

- (void)addEventNotify:(BSYLiveEventNotifyModel *)notifyModel;


@end

NS_ASSUME_NONNULL_END
