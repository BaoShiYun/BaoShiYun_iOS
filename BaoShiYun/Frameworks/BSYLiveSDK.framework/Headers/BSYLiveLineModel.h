//
//  BSYLiveLineModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/19.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveLineModel : NSObject

@property (nonatomic, strong, readonly)NSString *lineId; ///线路id
@property (nonatomic, strong, readonly)NSString *lineName; ///线路名字

@end

NS_ASSUME_NONNULL_END
