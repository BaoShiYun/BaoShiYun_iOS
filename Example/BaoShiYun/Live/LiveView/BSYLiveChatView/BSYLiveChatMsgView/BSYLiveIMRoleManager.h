//
//  BSYLiveIMRoleManager.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "BSYLiveIMRoleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveIMRoleManager : NSObject

- (void)initRoleList:(NSArray<BSYLiveIMRoleModel *> *)roleList;

- (BSYLiveIMRoleType)getRoleType:(NSString *)identifer;

@end

NS_ASSUME_NONNULL_END
