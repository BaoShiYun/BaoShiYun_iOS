//
//  BSYLiveResolutionModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/19.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
  清晰度Model
 */
@interface BSYLiveResolutionModel : NSObject

/**
 *   @brief  清晰度类型  org 、lsd、  lhd、  lud
 *   @discussion org-原始 lsd-超清  lhd-高清  lud-清晰
 */
@property (nonatomic, strong, readonly)NSString *resolution;

/**
 *   @brief  清晰度名称描述 ：原始 、超清 、高清 、清晰
 */
@property (nonatomic, strong, readonly)NSString *resolutionName;

@end

NS_ASSUME_NONNULL_END
