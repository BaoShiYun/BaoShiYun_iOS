//
//  UIColor+HexColor.h
//  BSYUILib
//
//  Created by Duane on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

+(UIColor *) colorFromHexString:(NSString*)hexString;
+(UIColor *) colorFromHexString:(NSString*)hexString alpha:(CGFloat)alpha;
+(UIColor *) colorFromHex:(NSUInteger)hex;
+(UIColor *) colorFromHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
