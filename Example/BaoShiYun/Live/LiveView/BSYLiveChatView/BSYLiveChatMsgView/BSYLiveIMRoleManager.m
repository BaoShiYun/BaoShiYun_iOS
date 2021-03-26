//
//  BSYLiveIMRoleManager.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMRoleManager.h"

@interface BSYLiveIMRoleManager ()

@property (nonatomic, strong)NSMutableArray<BSYLiveIMRoleModel *> *roleList;

@end

@implementation BSYLiveIMRoleManager


- (void)initRoleList:(NSArray<BSYLiveIMRoleModel *> *)roleList {
    __block NSMutableArray *teacherList = [NSMutableArray array];
    __block NSMutableArray *assistantList = [NSMutableArray array];
    __block NSMutableArray *classTeacherList = [NSMutableArray array];
    //__block NSMutableArray *adminList = [NSMutableArray array];
    [roleList enumerateObjectsUsingBlock:^(BSYLiveIMRoleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (obj.roleType) {
            case BSYLiveIMRoleType_Teacher: {
                [teacherList addObject:obj];
            }
                break;
            case BSYLiveIMRoleType_Assistant: {
                [assistantList addObject:obj];
            }
                    break;
            case BSYLiveIMRoleType_ClassTeacher: {
                [classTeacherList addObject:obj];
            }
                    break;
            default:
                    break;
        }
    }];
    self.roleList = [NSMutableArray array];
    if(teacherList.count>0) {
        [self.roleList addObjectsFromArray:teacherList];
    }
    if(assistantList.count>0) {
        [self.roleList addObjectsFromArray:assistantList];
    }
    if(classTeacherList.count>0) {
        [self.roleList addObjectsFromArray:classTeacherList];
    }
}


- (BSYLiveIMRoleType)getRoleType:(NSString *)identifer {
    __block BSYLiveIMRoleType roleType = BSYLiveIMRoleType_Student;
    [self.roleList enumerateObjectsUsingBlock:^(BSYLiveIMRoleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *uid = [NSString stringWithFormat:@"%lld",obj.uid];
        if(identifer && [uid isEqualToString:identifer]) {
            roleType = obj.roleType;
            *stop = YES;
        }
    }];
    return roleType;
}

@end
