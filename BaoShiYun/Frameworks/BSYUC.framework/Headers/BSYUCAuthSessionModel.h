//
//  BSYUCAuthSessionModel.h
//  BSYUC
//
//  Created by Duane on 2020/11/6.
//

#import <BSYUC/BSYUCModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYUCAuthSessionModel : BSYUCModel

@property (nonatomic, copy)NSString *accessToken;
@property (nonatomic, copy)NSString *groupId;
@property (nonatomic, copy)NSString *userMark;

@property (nonatomic, readonly)BOOL isLogin;
@property (nonatomic, assign)BOOL isFakeLogin;

@end

NS_ASSUME_NONNULL_END
