//
//  BSYLiveBottomBar.h
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//

#import "FavorEmitter.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveBottomBarActionType) {
    BSYLiveBottomBarActionType_Like, //点赞
    BSYLiveBottomBarActionType_TextInput, //聊天文字输入
    BSYLiveBottomBarActionType_More, //菜单
    BSYLiveBottomBarActionType_InteractiveHand, //举手互动
    BSYLiveBottomBarActionType_InteractiveUnHand, //取消举手
    BSYLiveBottomBarActionType_InteractiveOffStage, //挂断
};

typedef NS_ENUM(NSUInteger, BSYInteractiveLiveHandStatus) {   //举手状态
    BSYInteractiveLiveHandStatus_UnHand, //未举手
    BSYInteractiveLiveHandStatus_Handing, //举手中
    BSYInteractiveLiveHandStatus_OnStage, //上台
};



typedef void (^BSYLiveBottomBarActionBlock)(BSYLiveBottomBarActionType type);

@interface BSYLiveBottomBar : UIView

@property (nonatomic, strong, readonly)FavorEmitter *likeBtn;
@property (nonatomic, copy)BSYLiveBottomBarActionBlock actionBlock;

- (void)setLiveHandStatus:(BSYInteractiveLiveHandStatus)handStatus;
- (void)setIsRtc:(BOOL)isRtc;
- (void)setInteractiveEnable:(BOOL)enable;
- (void)setAllMute:(BOOL)isMute;
- (void)setLikeCount:(NSUInteger)likeCount newAddCount:(NSInteger)addCount;

@end

NS_ASSUME_NONNULL_END
