//
//  BSYSDKDataType.h
//  BSYSDK
//
//  Created by Duane on 2020/11/6.
//

#ifndef BSYSDKDataType_h
#define BSYSDKDataType_h

typedef int64_t intID;
typedef uint64_t uintID;

typedef NS_ENUM(NSInteger, BSYAppClientType) {
    BSYAppClientTypeIOS = 1, // iOS
    BSYAppClientTypeAndroid = 2, // Android
    BSYAppClientTypeWeb = 3, // Web
};

typedef NS_ENUM(NSInteger, BSYRequestStatus) {
    BSYRequestStatusOk = 1, // 成功
};

typedef NS_ENUM(NSInteger, BSYRequestError) {
    BSYRequestErrorServer = -1, // 系统错误
    BSYRequestErrorHttp = -2, // Http错误
    BSYRequestErrorParam = -3, // 参数错误
};

#endif /* BSYSDKDataType_h */
