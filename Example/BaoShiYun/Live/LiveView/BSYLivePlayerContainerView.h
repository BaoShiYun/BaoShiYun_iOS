//
//  BSYLivePlayerContainerView.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//


typedef NS_ENUM(NSUInteger, BSYLivePlayerStatus) {
    BSYLivePlayerStatus_Unknown,
    BSYLivePlayerStatus_UnStart,
    BSYLivePlayerStatus_Living,
    BSYLivePlayerStatus_Suspend, //直播暂停
    BSYLivePlayerStatus_LiveEnd,
    BSYLivePlayerStatus_Interrupt, //强制中断
};


NS_ASSUME_NONNULL_BEGIN

@interface BSYLivePlayerContainerView : UIView

- (void)setContainerPlayerStatus:(BSYLivePlayerStatus)status;

@end

NS_ASSUME_NONNULL_END
