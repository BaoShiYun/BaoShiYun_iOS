//
//  BSYInteractiveControlView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/3/2.
//

#import "BSYInteractiveControlDef.h"
#import "BSYAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface BSYInteractiveControlView : BSYAlertViewController
@property (nonatomic, copy)BSYInteractiveControlStatusBlock micBlock;
@property (nonatomic, copy)BSYInteractiveControlStatusBlock camBlock;
@property (nonatomic, copy)BSYInteractiveControlOffStageBlock offStageBlock;
@property (nonatomic, copy)BSYInteractiveControlCancelBlock cancelBlock;



- (instancetype)initWithCamEnable:(BOOL)isCamEnable withCamStatus:(BOOL)isCamOpen withMicEnable:(BOOL)isMicEnable withMicStatus:(BOOL)isMicOpen;

- (void)setCamStatus:(BOOL)isCamOpen;
- (void)setMicStatus:(BOOL)isMicOpen;
@end

NS_ASSUME_NONNULL_END
