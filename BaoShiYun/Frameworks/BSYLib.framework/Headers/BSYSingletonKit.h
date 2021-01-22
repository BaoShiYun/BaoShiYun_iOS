//
//  BSYSingletonKit.h
//  BSYLib
//
//  Created by Duane on 2020/11/3.
//

#ifndef BSYSingletonKit_h
#define BSYSingletonKit_h


#define DEFINE_SINGLETON_FOR_H(className) \
+ (className *)shareInstance; \
+(instancetype) alloc __attribute__((unavailable("call shareInstance instead"))); \
+(instancetype) new __attribute__((unavailable("call shareInstance instead"))); \
-(instancetype) copy __attribute__((unavailable("call shareInstance instead"))); \
-(instancetype) mutableCopy __attribute__((unavailable("call shareInstance instead")));

#define DEFINE_SINGLETON_FOR_M(className) \
+ (className *)shareInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
}); \
return shared##className; \
} \
\
+(id) allocWithZone:(struct _NSZone *)zone \
{ \
return [className shareInstance]; \
} \
\
-(id) copyWithZone:(struct _NSZone *)zone \
{ \
return [className shareInstance]; \
} \
\
-(id) mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return [className shareInstance]; \
}


#endif /* BSYSingletonKit_h */
