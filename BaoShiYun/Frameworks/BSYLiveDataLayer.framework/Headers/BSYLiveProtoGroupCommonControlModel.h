//
//  BSYLiveProtoGroupCommonControlModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveGroupCommonControlType)
{
    BSYLiveGroupCommonControlType_ScriptMsg=2, //剧本直播Msg脚本协议
    BSYLiveGroupCommonControlType_CameraStreamStatus=1001, //机位流状态（推流/断流）
    BSYLiveGroupCommonControlType_SwitchMasterCamera=1002, //主机位切换通知
    BSYLiveGroupCommonControlType_ShowCourseWare=1003, //课件直播开关
    BSYLiveGroupCommonControlType_RtcLiveStatus=1004, //RTC直播状态（推流/断流）
    
};

@interface BSYLiveProtoGroupCommonControlModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  //群id
@property (nonatomic, assign)BSYLiveGroupCommonControlType controlType; //控制类型 
@property (nonatomic, strong)id params; //与controlType 相匹配的数据结构
@end

NS_ASSUME_NONNULL_END
