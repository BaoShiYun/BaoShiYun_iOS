//
//  BSYLiveMenuViewController.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYLiveMenuType) {
    BSYLiveMenuType_Cancel,
    BSYLiveMenuType_Resolution,
    BSYLiveMenuType_Route,
};

typedef void(^BSYLiveMenuViewBlock)(BSYLiveMenuType menuType);

@interface BSYLiveMenuViewController : BSYAlertViewController

@property (nonatomic, copy)BSYLiveMenuViewBlock menuBlock;


@end

NS_ASSUME_NONNULL_END
