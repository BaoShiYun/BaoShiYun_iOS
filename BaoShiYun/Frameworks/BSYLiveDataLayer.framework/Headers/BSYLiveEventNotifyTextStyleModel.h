//
//  BSYLiveEventNotifyTextStyleModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveEventNotifyTextStyleModel : BSYMediaModel

@property (nonatomic, strong)NSString *text; //文字
@property (nonatomic, strong)NSString *color; //#00FFFFFF

@end

NS_ASSUME_NONNULL_END
