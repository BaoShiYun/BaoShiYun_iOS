//
//  BSYUCDataType.h
//  BSYUC
//
//  Created by duane on 2021/1/19.
//

#ifndef BSYUCDataType_h
#define BSYUCDataType_h

typedef NS_ENUM(NSInteger, BSYUCRequestError) {
    BSYUCRequestErrorNeedMobile = -10000, // 手机号码不能为空
    BSYUCRequestErrorMobileError = -10001, // 手机号格式错误
    BSYUCRequestErrorMethError = -10002, // 发送方式必须是 1消息 或者 2语音
    BSYUCRequestErrorTypeError = -10003, // 发送类型必须是 1注册账号 或者 2修改账号
    BSYUCRequestErrorMinuteLimit = -10004, // 60 秒内只能发送 1 次
    BSYUCRequestErrorDayLimit = -10005, // 每天只能发送 10 次
    BSYUCRequestErrorNeedBind = -10490, // 该用户未注册，需要绑定手机注册
    BSYUCRequestErrorWeiXinError = -10491, // 获取微信信息失败
};

#endif /* BSYUCDataType_h */
