//
//  BSYLiveNotifyTextStyleModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/12/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 通知事件显示模版 仅使用在： BSYLiveEventNotifyType_Customize
 */

@interface BSYLiveNotifyTextStyleModel : NSObject

/**
 *   @brief  文字
 */
@property (nonatomic, strong, readonly)NSString *text;

/**
 *   @brief  颜色值 例如:#00FFFFFF
 */
@property (nonatomic, strong, readonly)NSString *color;

@end

NS_ASSUME_NONNULL_END
