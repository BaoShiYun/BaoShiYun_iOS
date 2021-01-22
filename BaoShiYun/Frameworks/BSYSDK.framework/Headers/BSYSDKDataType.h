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

#endif /* BSYSDKDataType_h */
