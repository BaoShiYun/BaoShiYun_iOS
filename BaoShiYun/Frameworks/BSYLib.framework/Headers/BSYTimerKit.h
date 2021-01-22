//
//  BSYTimerKit.h
//  BSYLib
//
//  Created by Duane on 2020/11/3.
//

#ifndef BSYTimerKit_h
#define BSYTimerKit_h

#import <BSYLib/BSYTimer.h>

//timer
#define DEFINE_TIMER_FOR_H() \
\
@property (nonatomic, strong, nullable) BSYTimer *timer; \
\
- (void)stopTimer; \
- (void)startTimer:(NSTimeInterval)interval block:(void(^)(void))block; \
- (void)startTimer:(NSTimeInterval)interval fireNow:(BOOL)fireNow block:(void(^)(void))block;

#define DEFINE_TIMER_FOR_M() \
\
- (void)startTimer:(NSTimeInterval)interval block:(void(^)(void))block { \
[self startTimer:interval fireNow:YES block:block]; \
} \
- (void)startTimer:(NSTimeInterval)interval fireNow:(BOOL)fireNow block:(void(^)(void))block { \
[self stopTimer]; \
\
self.timer = [BSYTimer scheduledTimerWithTimeInterval:interval repeats:YES queue:dispatch_get_main_queue() block:^(void) { \
if (block) { \
block(); \
} \
}]; \
if (fireNow && block) { \
block(); \
} \
} \
\
- (void)stopTimer { \
[self.timer invalidate]; \
self.timer = nil; \
}


#endif /* BSYTimerKit_h */
