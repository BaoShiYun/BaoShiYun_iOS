//
//  BSYLiveLineModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/19.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  线路Model
 */
@interface BSYLiveLineModel : NSObject

/**
 *   @brief  线路id
 */
@property (nonatomic, strong, readonly)NSString *lineId;

/**
 *   @brief  线路名字
 */
@property (nonatomic, strong, readonly)NSString *lineName;

@end

NS_ASSUME_NONNULL_END
