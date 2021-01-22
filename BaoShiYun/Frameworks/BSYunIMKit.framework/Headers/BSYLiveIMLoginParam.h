//
//  BSYLiveIMLoginParam.h
//  BSYunIMKit
//
//  Created by zddMac on 2020/11/5.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMLoginParam : NSObject

@property (nonatomic, strong)NSString *uid;       //用户id
@property (nonatomic, strong)NSString *nickName; //用户昵称
@property (nonatomic, strong)NSString *avatarUrl; //头像信息


@property (nonatomic, assign) NSInteger imGroupId;   //（选填）
@property (nonatomic, strong) NSString *sig;         //签名
@property (nonatomic, strong) NSString *timGroupId;  //腾讯im群id

@end

NS_ASSUME_NONNULL_END
