//
//  BSYLiveIMRoleModel.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveIMRoleType) {
    
    BSYLiveIMRoleType_Teacher=1, //老师
    BSYLiveIMRoleType_Assistant=2,//助教
    BSYLiveIMRoleType_ClassTeacher=3,//班主任
    BSYLiveIMRoleType_Admin=4,//管理员
    BSYLiveIMRoleType_Student=1000,//学生
    BSYLiveIMRoleType_Self=1001,//学生
    
};

@interface BSYLiveIMRoleModel : NSObject

@property (nonatomic, assign)unsigned long long uid;
@property (nonatomic, assign)BSYLiveIMRoleType roleType;

@end

NS_ASSUME_NONNULL_END
