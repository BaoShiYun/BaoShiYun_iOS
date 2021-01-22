//
//  BSYObserverKit.h
//  BSYLib
//
//  Created by Duane on 2020/11/3.
//

#ifndef BSYObserverKit_h
#define BSYObserverKit_h


//观察者
#define DEFINE_OBSERVER_FOR_H(protocolName) \
\
@property (nonatomic, strong) NSHashTable<id<protocolName>> *observers; \
\
- (void)addObserver:(id <protocolName>)observer; \
- (void)removeObserver:(id <protocolName>)Observer;

#define DEFINE_OBSERVER_FOR_M(protocolName) \
- (NSHashTable *)observers { \
if (_observers == nil) { \
_observers = [NSHashTable<id<protocolName>> hashTableWithOptions:NSHashTableWeakMemory]; \
} \
return _observers; \
} \
\
- (void)addObserver:(id <protocolName>)observer { \
if ([self.observers containsObject:observer]) { \
return; \
} \
[self.observers addObject:observer]; \
} \
\
- (void)removeObserver:(id<protocolName>)Observer { \
[self.observers removeObject:Observer]; \
} \
\
- (void)notifyObserverWithSelector:(SEL)selector { \
[self notifyObserverWithSelector:selector withObject:nil]; \
} \
\
- (void)notifyObserverWithSelector:(SEL)selector withObject:(id)object { \
[self notifyObserverWithSelector:selector withObject:object withObject:nil]; \
} \
\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
- (void)notifyObserverWithSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 { \
[[self.observers allObjects] enumerateObjectsUsingBlock:^(id<protocolName>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { \
if ([obj respondsToSelector:selector]) { \
[obj performSelector:selector withObject:object1 withObject:object2]; \
} \
}]; \
} \
_Pragma("clang diagnostic pop")


#endif /* BSYObserverKit_h */
