//
//  BSYLiveEnterClassRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveEnterClassRequest : BSYMediaRequest

- (instancetype)initEnterCode:(NSString *)enterCode UserId:(NSString *)userId LiveId:(NSString *)liveId;

@end

NS_ASSUME_NONNULL_END
