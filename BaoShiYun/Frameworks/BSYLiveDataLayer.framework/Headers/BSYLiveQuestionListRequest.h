//
//  BSYLiveQuestionListRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveQuestionListRequest : BSYLiveBaseRequest

- (instancetype)initWithLiveId:(NSString *)liveId UserId:(NSString *)uid;

@end

NS_ASSUME_NONNULL_END
