//
//  NSDictionary+Value.h
//  EagleApp
//
//  Created by duane on 2017/8/20.
//  Copyright © 2017年 duane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Value)

- (unsigned long long)unsignedLongLongForKey:(NSString *)key;
- (unsigned long)unsignedLongForKey:(NSString *)key;
- (unsigned int)unsignedIntForKey:(NSString *)key;
- (unsigned short)unsignedShortForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (unsigned char)unsignedCharForKey:(NSString *)key;
- (char)charForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (NSDate*)dateForKey:(NSString*)key;

@end

@interface NSMutableDictionary (Value)

- (void)setUnsignedLongLong:(unsigned long long)value forKey:(id)aKey;
- (void)setUnsignedLong:(unsigned long)value forKey:(id)aKey;
- (void)setUnsignedInt:(unsigned int)value forKey:(id)aKey;
- (void)setBool:(BOOL)value forKey:(id)aKey;
- (void)setInt:(int)value forKey:(id)aKey;
- (void)setUnsignedShort:(unsigned short)value forKey:(id)aKey;
- (void)setUnsignedChar:(unsigned char)value forKey:(id)aKey;
- (void)setChar:(char)value forKey:(id)aKey;
- (void)setDateWithTimeIntervalSince1970:(unsigned long)value forKey:(id)aKey;
- (void)setFloat:(float)value forKey:(id)aKey;
- (void)setNSStringWithUTF8String:(const char*)str forKey:(id)aKey;

@end
