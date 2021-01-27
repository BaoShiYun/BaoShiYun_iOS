//
//  BSYSDKConfig+UC.h
//  BSYUC
//
//  Created by DuanGuangming on 2021/1/25.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYSDKConfig (UC)

- (void)getBSYUidWithTenantId:(uintID)tenantId tenantUid:(NSString *)tenantUid isSaasUser:(BOOL)isSaasUser completion:(BSYSDKGetUidBlock)completion;

@end

NS_ASSUME_NONNULL_END
