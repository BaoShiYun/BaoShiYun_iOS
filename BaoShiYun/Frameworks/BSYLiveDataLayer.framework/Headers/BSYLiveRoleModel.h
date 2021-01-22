//
//  BSYLiveRoleModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveRoleType) {
    
    BSYLiveRoleType_Teacher=1, //老师
    BSYLiveRoleType_Assistant=2,//助教
    BSYLiveRoleType_ClassTeacher=3,//班主任
    BSYLiveRoleType_Admin=4,//管理员
    
};


@interface BSYLiveRoleModel : BSYMediaModel

@property (nonatomic, assign)uint64_t uid;
@property (nonatomic, assign)BSYLiveRoleType roleType;

@end

NS_ASSUME_NONNULL_END
