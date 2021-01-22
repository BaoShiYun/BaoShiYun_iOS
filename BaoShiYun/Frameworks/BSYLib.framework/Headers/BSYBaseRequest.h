//
//  BSYBaseRequest.h
//  BSYLib
//
//  Created by Duane on 2020/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYRequestMethod) {
    BSYRequestMethodGET = 0,
    BSYRequestMethodPOST,
    BSYRequestMethodHEAD,
    BSYRequestMethodPUT,
    BSYRequestMethodDELETE,
    BSYRequestMethodPATCH,
};

typedef NS_ENUM(NSInteger, BSYRequestSerializerType) {
    BSYRequestSerializerTypeHTTP = 0,
    BSYRequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger, BSYResponseSerializerType) {
    BSYResponseSerializerTypeHTTP,
    BSYResponseSerializerTypeJSON,
    BSYResponseSerializerTypeXMLParser,
};

@class BSYBaseRequest;

typedef void(^BSYBaseRequestBlock)(__kindof BSYBaseRequest *request);

@protocol BSYRequestDelegate <NSObject>

@optional

- (NSString *)baseUrl;

- (NSString *)requestUrl;

- (NSTimeInterval)requestTimeoutInterval;

- (nullable id)requestArgument;

- (BSYRequestMethod)requestMethod;

- (BSYRequestSerializerType)requestSerializerType;

- (BSYResponseSerializerType)responseSerializerType;

- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;

- (nullable NSURLRequest *)buildCustomUrlRequest;

@end

@interface BSYBaseRequest : NSObject<BSYRequestDelegate>

@property (nonatomic, strong, readonly, nullable) NSData *responseData;
@property (nonatomic, strong, readonly, nullable) id responseJSONObject;
@property (nonatomic, strong, readonly, nullable) id responseObject;
@property (nonatomic, strong, readonly, nullable) NSString *responseString;
@property (nonatomic, strong, readonly, nullable) NSError *error;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) BOOL ignoreCache;

- (void)startWithCompletionBlockWithSuccess:(nullable BSYBaseRequestBlock)success failure:(nullable BSYBaseRequestBlock)failure;

- (void)stop;

@end

@interface NSError (BSYBaseRequest)

- (NSString *)requestErrorMessage;

@end

NS_ASSUME_NONNULL_END
