//
//  NSString+pinyin.h
//  BSYLib
//
//  Created by duane on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (pinyin)

- (NSString *)chineseToPinyin;
- (NSString *)chinnesToInitial;
- (BOOL)isIncludeChineseIn;
- (NSString *)first;

@end

NS_ASSUME_NONNULL_END
