//
//  BSYLiveIMModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveRoleModel;
@interface BSYLiveIMModel : BSYMediaModel
@property (nonatomic, assign) NSInteger imGroupId;
@property (nonatomic, strong) NSString *sig; //IM登录sig
@property (nonatomic, strong) NSString *timGroupId;   //腾讯im群id
/**
*   @brief 角色列表
*   roleList 内容结构
*   [
*      {
*        uid,
*        roleType 1=老师 2=助教 3=班主任 4=管理员,
*      }
*   ]
*/
@property (nonatomic, strong) NSArray *roleList;  //

@end

NS_ASSUME_NONNULL_END
