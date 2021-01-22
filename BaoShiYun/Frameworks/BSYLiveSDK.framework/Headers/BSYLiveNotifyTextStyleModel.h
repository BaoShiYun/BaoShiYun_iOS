//
//  BSYLiveNotifyTextStyleModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/12/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveNotifyTextStyleModel : NSObject

@property (nonatomic, strong, readonly)NSString *text; //文字
@property (nonatomic, strong, readonly)NSString *color; //#00FFFFFF

@end

NS_ASSUME_NONNULL_END
