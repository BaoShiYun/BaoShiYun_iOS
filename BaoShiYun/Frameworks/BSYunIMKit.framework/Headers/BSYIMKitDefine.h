//
//  BSYIMKitDefine.h
//  BSYIMKit
//
//  Created by zddMac on 2020/10/30.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 成功通用回调
typedef void (^BSYIMSuccess)(void);
/// 失败通用回调
typedef void (^BSYIMFail)(int code, NSString * desc);
//
typedef void (^BSYIMGetMsgSuccess)(NSArray *msgList);

/// 登录状态
typedef NS_ENUM(NSInteger, BSYIMLoginStatus) {
    BSYIM_STATUS_LOGINED                   = 1,  ///< 已登录
    BSYIM_STATUS_LOGINING                  = 2,  ///< 登录中
    BSYIM_STATUS_LOGOUT                    = 3,  ///< 无登录
};


