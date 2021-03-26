//
//  BSYLiveOperateView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/2/24.
//


NS_ASSUME_NONNULL_BEGIN

@protocol BSYLiveOperateViewDelegate <NSObject>

- (void)operateViewReturnButtonAction;


@end


@interface BSYLiveOperateView : UIView

@property (nonatomic, weak)id<BSYLiveOperateViewDelegate> delegate;

- (void)setLiveTitle:(NSString *)title;
- (void)setStudentCountShow:(BOOL)isShow;
- (void)setStudentCount:(NSInteger)count;

- (void)showLoadingView;
- (void)hideLoadingView;

@end

NS_ASSUME_NONNULL_END
