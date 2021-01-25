//
//  BSYUC3rdLoginManager.h
//  BSYUC
//
//  Created by Duane on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import <BSYLib/BSYSingletonKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYUC3rdAuthModel : NSObject

@property (nonatomic, copy) NSString  *openid;
@property (nonatomic, copy) NSString  *accessToken;
@property (nonatomic, copy) NSDate    *expiration;

@property (nonatomic, strong)NSDictionary* extDic;//每个平台特有的字段有可能会加在此处，有可能为nil

@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString  *iconurl;
@property (nonatomic, copy) NSString  *gender;

@end


typedef void(^BSYUC3rdAuthBlock)(BSYUC3rdAuthModel * _Nullable authModel, NSError * _Nullable error);
typedef void(^BSYUC3rdLoginBlock)(BSYUC3rdAuthBlock _Nullable authBlock);

typedef void(^BSYUCWeiXinAuthBlock)(NSString * _Nullable authCode, NSError * _Nullable error);
typedef void(^BSYUCWeiXinLoginBlock)(BSYUCWeiXinAuthBlock _Nullable authBlock);


@interface BSYUC3rdLoginManager : NSObject

DEFINE_SINGLETON_FOR_H(BSYUC3rdLoginManager)

@property (nonatomic, strong, readonly) NSString *weixinAppId;
@property (nonatomic, strong, readonly) NSString *weixinAppSecret;
@property (nonatomic, strong, readonly) NSString *weixinUniversalLink;

@property (nonatomic, copy) BSYUCWeiXinLoginBlock weixinLoginBlock;

- (void)configWexin:(NSString *)appId appSecret:(NSString *)appSecret universalLink:(NSString *)universalLink;

@end

NS_ASSUME_NONNULL_END
