//
//  BSYDataType.h
//  BSYLib
//
//  Created by Duane on 2019/3/18.
//  Copyright © 2019 KaiKeBa. All rights reserved.
//

#ifndef BSYDataType_h
#define BSYDataType_h

typedef void(^BSYBlockVoid)(void);
typedef void(^BSYBlockBool)(BOOL success);
typedef void(^BSYBlockId)(id _Nullable object);
typedef void(^BSYBlockNSString)(NSString * _Nullable string);
typedef void(^BSYBlockNSError)(NSError * _Nullable error);

typedef BOOL(^BSYBoolBlock)(void);
typedef id _Nullable (^BSYIdBlock)(void);
typedef NSString *_Nullable(^BSYNSStringBlock)(void);

static inline void dispatch_async_main(dispatch_block_t _Nullable block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

static inline void dispatch_after_main(NSTimeInterval delayInSeconds, dispatch_block_t _Nullable block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

static inline void dispatch_sync_main(dispatch_block_t _Nullable block) {
    if (NSThread.isMainThread) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

static inline void dispatch_run_main(dispatch_block_t _Nullable block) {
    if (NSThread.isMainThread) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

#endif /* BSYDataType_h */
