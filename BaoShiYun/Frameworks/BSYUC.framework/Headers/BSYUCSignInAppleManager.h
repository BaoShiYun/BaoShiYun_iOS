//
//  BSYUCSignInAppleManager.h
//  BSYUC
//
//  Created by Duane on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import <BSYLib/BSYSingletonKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYUCSignInAppleModel : NSObject

@property (nonatomic, copy) NSString  *user;
@property (nonatomic, copy) NSString  *familyName;
@property (nonatomic, copy) NSString  *givenName;
@property (nonatomic, copy) NSString  *email;
@property (nonatomic, copy) NSString  *identityToken;
@property (nonatomic, copy) NSString  *authorizationCode;

@end

typedef void(^BSYUCSignInAppleBlock)(BSYUCSignInAppleModel * _Nullable authModel, NSError * _Nullable error);

@interface BSYUCSignInAppleManager : NSObject

DEFINE_SINGLETON_FOR_H(BSYUCSignInAppleManager)

// 处理授权
- (void)signInWithApple:(BSYUCSignInAppleBlock)completion;

@end

NS_ASSUME_NONNULL_END
