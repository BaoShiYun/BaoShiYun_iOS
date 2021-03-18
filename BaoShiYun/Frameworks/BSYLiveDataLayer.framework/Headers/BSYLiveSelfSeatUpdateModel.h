//
//  BSYLiveSelfSeatUpdateModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/5.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveSelfSeatUpdateType) {
    BSYLiveSelfSeatUpdateType_OnStage = 1, //上台
    BSYLiveSelfSeatUpdateType_OffStage = 2, //下台
};

@interface BSYLiveSelfSeatUpdateModel : BSYMediaModel
@property (nonatomic, strong)NSString *seatId;//席位id
@property (nonatomic, assign)BSYLiveSelfSeatUpdateType status;
@end

NS_ASSUME_NONNULL_END
