//
//  BSYAlertViewController.h
//  BSYUILib
//
//  Created by Duane on 2020/12/8.
//


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYAlertControllerStyle) {
    KKBAlertControllerStyle_Alert = 0,
    KKBAlertControllerStyle_ActionSheet = 1,
    KKBAlertControllerStyle_SlideTop = 2,
    KKBAlertControllerStyle_SlideLeft = 3,
    KKBAlertControllerStyle_SlideRight = 4,
};

@interface BSYAlertController : NSObject

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, copy) void (^dismissComplete)(void);

- (instancetype)initWithView:(UIView *)view style:(BSYAlertControllerStyle)style;

@end

@interface BSYAlertViewController : UIViewController

@property (nonatomic, assign, readonly) BSYAlertControllerStyle style;

@property (nonatomic, copy) void (^dismissComplete)(void);

- (instancetype)initWithStyle:(BSYAlertControllerStyle)style;

- (void)showInController:(UIViewController *)controller;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
