//
//  BSYLiveInfoModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveStatus) {
    BSYLiveStatus_Unknown,
    BSYLiveStatus_UnStart,
    BSYLiveStatus_Living,
    BSYLiveStatus_Suspend, //直播暂停
    BSYLiveStatus_LiveEnd,
    BSYLiveStatus_Interrupt, //强制中断
};

@class BSYLiveRouteModel;
@class BSYLiveIMModel;
@class BSYRtcLiveInfoModel;
@interface BSYLiveInfoModel : BSYMediaModel

@property (nonatomic, strong)NSString *liveId; //直播id
@property (nonatomic, strong)NSString *enterCode;//
@property (nonatomic, strong)NSString *liveName; //直播名
@property (nonatomic, strong)NSString *operId; //
@property (nonatomic, assign)NSInteger memberQuota; //教室容量
@property(nonatomic, assign) NSUInteger createTime;//创建时间戳（毫秒）
@property (nonatomic, assign)NSUInteger expectStartTime; //计划直播开始时间（毫秒）
@property (nonatomic, assign)NSInteger expectDurationTime; //计划直播时长(秒)
@property (nonatomic, assign)NSUInteger actualStartTime; //实际开始时间（毫秒）
@property (nonatomic, assign)NSUInteger effectiveTime;  //推流过期时间（毫秒）
@property (nonatomic, assign)BSYLiveStatus liveStatus;//教室状态
@property (nonatomic, strong)NSString *workStatus; //工作状态，对应之前的教室状态。running:推流中 stopped:没有流
@property (nonatomic, strong)NSString *type;  //多机位直播：multiCamera 普通直播：private
@property (nonatomic, strong)NSString *mediaId; //媒体id
@property (nonatomic, strong)NSString *token; //直播间token
@property (nonatomic, strong)NSArray<BSYLiveRouteModel *> *liveRouteList; //直播线路组列表
@property (nonatomic, strong)BSYLiveIMModel *imGroupInfo;
@property (nonatomic, strong)NSString *h5Url;//h5直播观看链接
@property (nonatomic, assign)BOOL isConfigGoods;//手机直播货架是否显示（审核使用） yes-显示

@property (nonatomic, assign)BOOL showCourseWareTag;//是否为课件模式 YES-课件模式  NO-非课件模式
@property (nonatomic, assign)BSYLiveStatus rtcStatus;//教室状态
@property (nonatomic, strong)BSYRtcLiveInfoModel *rtcInfo; //rtc直播信息


@end

NS_ASSUME_NONNULL_END
