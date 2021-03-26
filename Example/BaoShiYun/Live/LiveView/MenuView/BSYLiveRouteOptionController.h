//
//  BSYLiveRouteOptionController.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BSYLiveRouteOptionBlock)(BSYLiveLineModel *selectedRoute);
typedef void(^BSYLiveRouteOptionCancelBlock)(void);

@interface BSYLiveRouteOptionController : BSYAlertViewController

@property (nonatomic, copy)BSYLiveRouteOptionBlock selectedBlock;
@property (nonatomic, copy)BSYLiveRouteOptionCancelBlock cancelBlock;

- (instancetype)initRouteList:(NSArray<BSYLiveLineModel *> *)lineList currentRoute:(BSYLiveLineModel *)curLine;

@end

NS_ASSUME_NONNULL_END
