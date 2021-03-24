//
//  BSYLiveOperateTopBar.h
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//


NS_ASSUME_NONNULL_BEGIN

@protocol BSYLiveOperateTopBarDelegate <NSObject>

- (void)topBarReturnButtonAction;

@end

@interface BSYLiveOperateTopBar : UIView

@property (nonatomic, weak) id<BSYLiveOperateTopBarDelegate> delegate;

- (void)setLiveTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
