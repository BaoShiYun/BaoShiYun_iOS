//
//  BSYLiveInteractiveSeatModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveInteractiveSeatModel : BSYMediaModel

@property (nonatomic, strong)NSString *seatId;//席位id
@property (nonatomic, assign)NSInteger status;//状态
@property (nonatomic, strong)NSString *uid; //用户id
@property (nonatomic, strong)NSString *nickname;//用户昵称
@property (nonatomic, assign)BOOL videoMute;//视频开启关闭状态
@property (nonatomic, assign)BOOL audioMute;//音频开启关闭状态
@property (nonatomic, assign)BOOL videoDisable;//视频是否允许使用（老师控制）
@property (nonatomic, assign)BOOL audioDisable;//音频是否允许使用（老师控制）

@end

NS_ASSUME_NONNULL_END
