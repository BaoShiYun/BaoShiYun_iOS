//
//  BSYLiveFeedbackRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveFeedbackRequest : BSYLiveBaseRequest

- (instancetype)initContent:(NSString *)content Uid:(NSString *)uid LiveId:(NSString *)liveId LiveName:(NSString *)liveName;

@end

NS_ASSUME_NONNULL_END
