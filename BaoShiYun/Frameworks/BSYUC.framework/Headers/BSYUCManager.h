//
//  BSYUCManager.h
//  BSYUC
//
//  Created by Duane on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <BSYLib/BSYSingletonKit.h>
#import <BSYLib/BSYObserverKit.h>
#import <BSYLib/BSYDataType.h>
#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BSYUCManagerDelegate <NSObject>

@optional

/*
 登录成功通知
 */
- (void)didLogin;

/*
 退出登录通知
 */
- (void)didLogout;

/*
 用户信息更新通知
 */
- (void)didUpdateUserInfo;

/*
 登录会话过期回调
 */
- (void)didTokenExpired;

@end

@class BSYUCUserInfoModel;
@class BSYUCAuthSessionModel;
@class BSYUCSignInAppleModel;

typedef void(^BSYLoginBlock)(NSError * _Nullable error, BSYUCAuthSessionModel * _Nullable loginModel);
typedef void(^BSYUCTokenBlock)(NSError * _Nullable error, NSString * _Nullable token);

@interface BSYUCManager : NSObject

DEFINE_SINGLETON_FOR_H(BSYUCManager)
DEFINE_OBSERVER_FOR_H(BSYUCManagerDelegate)

/*
 当前是否登录
 */
@property (nonatomic, assign, readonly) BOOL isLogin;

/*
 当前是否假登录成功
 */
@property (nonatomic, assign, readonly) BOOL isFakeLogin;

/*
 当前登录token
 */
@property (nonatomic, strong, readonly) NSString *accessToken;

/*
 当前登录用户信息
 */
@property (nonatomic, strong, readonly) BSYUCUserInfoModel *userInfo;

/*
 苹果审核禁止强制绑定手机号，使用此方法假登录成功，需要时再绑定手机号
 */
- (void)fakeLoginWithAppleModel:(BSYUCSignInAppleModel *)appleModel;

/*
 当前登录用户存储数据的文件路径
 */
- (NSString *)documentDirectory;

/*
 获取上传头像token
 */
- (void)getUploadImageTokenRequest:(BSYBlockNSString)completion;

/*
 获取登录验证码
 */
- (void)getLoginVerifyCode:(NSString *)mobile area:(NSString *)area completion:(BSYBlockNSError)completion;

/*
 获取登录语音验证码
 */
- (void)getLoginSoundVerifyCode:(NSString *)mobile area:(NSString *)area completion:(BSYBlockNSError)completion;

/*
 获取手机换绑验证码
 */
- (void)getRebindVerifyCode:(NSString *)mobile area:(NSString *)area completion:(BSYBlockNSError)completion;

/*
 获取手机换绑语音验证码
 */
- (void)getRebindSoundVerifyCode:(NSString *)mobile area:(NSString *)area completion:(BSYBlockNSError)completion;

/*
 已登录用户获取手机验证码
 */
- (void)getVerifyCode:(BSYBlockNSError)completion;

/*
 已登录用户获取语音验证码
 */
- (void)getSoundVerifyCode:(BSYBlockNSError)completion;

/*
 获取修换绑手机号的auth_token
 */
- (void)getChangeMobileTokenWithVerifyCode:(NSString *)verifyCode completion:(BSYUCTokenBlock)completion;

/*
 换绑手机
 */
- (void)changeMobile:(NSString *)mobile area:(NSString *)area verifyCode:(NSString *)verifyCode authCode:(NSString *)authCode  completion:(BSYBlockNSError)completion;

/*
 登录
 */
- (void)loginWithMobile:(NSString *)mobile area:(NSString *)area verifyCode:(NSString*)verifyCode completion:(BSYLoginBlock)completion;

/*
 苹果登录
 */
- (void)loginAppleWithAuthModel:(BSYUCSignInAppleModel *)authModel completion:(BSYLoginBlock)completion;

- (void)loginAppleWithAuthModel:(BSYUCSignInAppleModel *)authModel mobile:(nullable NSString *)mobile area:(nullable NSString *)area verifyCode:(nullable NSString *)verifyCode completion:(BSYLoginBlock)completion;

/*
 微信登录
 */
- (void)loginWeiXinWithAuthCode:(NSString *)authCode completion:(BSYLoginBlock)completion;

- (void)loginWeiXinWithAuthCode:(NSString *)authCode mobile:(nullable NSString *)mobile area:(nullable NSString *)area verifyCode:(nullable NSString *)verifyCode completion:(BSYLoginBlock)completion;

/*
 退出登录
 */
- (void)logoutWithcompletion:(BSYBlockVoid)completion;

/*
 当登录会话过期时调用
 */
- (void)tokenIsInvalid;

/*
 绑定微信, 重绑微信
 */
- (void)weixinBindWithAuthCode:(NSString *)authCode completion:(BSYBlockNSError)completion;

/*
 检查手机号格式, area:86
 */
+ (NSError *)checkPhoneNumber:(NSString *)phoneNumber area:(NSString *)area;

/*
 检查手机号格式, region:CN
 */
+ (NSError *)checkPhoneNumber:(NSString *)phoneNumber region:(NSString *)region;

/*
 检查验证码格式
 */
+ (NSError *)checkVerifyCode:(NSString *)code;

/*
 立即刷新用户信息
 */
- (void)refreshUserInfo:(BSYBlockNSError)completion;

/*
 检查是否需要刷新用户信息，如果需要才刷新（默认每天刷新一次）
 */
- (void)checkRefreshUserInfo;

/*
 修改用户信息
 */
- (void)updateUserInfo:(BSYUCUserInfoModel *)infoModel completion:(BSYBlockNSError)completion;

/*
 修改用户头像
 */
- (void)updateAvatar:(NSString *)url completion:(BSYBlockNSError)completion;

@end

NS_ASSUME_NONNULL_END
