//
//  BSYResponseModel.h
//  BSYSDK
//
//  Created by Duane on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYResponseModel : NSObject

@property (nonatomic, assign) NSInteger code; //请求状态码
@property (nonatomic, strong) NSString *msg; //状态描述
@property (nonatomic, strong) id data;

@property (nonatomic, strong, nullable) id result;

@end

NS_ASSUME_NONNULL_END
