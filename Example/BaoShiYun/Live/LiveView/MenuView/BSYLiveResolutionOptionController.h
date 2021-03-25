//
//  BSYLiveResolutionOptionController.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^BSYLiveResolutionOptionBlock)(BSYLiveResolutionModel *selectedResolution);
typedef void(^BSYLiveResolutionOptionCancelBlock)(void);

@interface BSYLiveResolutionOptionController : BSYAlertViewController

@property (nonatomic, copy)BSYLiveResolutionOptionBlock selectedBlock;
@property (nonatomic, copy)BSYLiveResolutionOptionCancelBlock cancelBlock;

- (instancetype)initResolutionList:(NSArray<BSYLiveResolutionModel *> * __nullable)resolutionList currentResolution:(BSYLiveResolutionModel * __nullable)curResolution;

@end

NS_ASSUME_NONNULL_END
