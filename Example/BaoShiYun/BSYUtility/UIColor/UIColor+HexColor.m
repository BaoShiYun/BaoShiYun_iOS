//
//  UIColor+HexColor.m
//  BSYUILib
//
//  Created by Duane on 2020/11/3.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+(UIColor *) colorFromHex:(NSUInteger)hexValue {
    UIColor *color = nil;
    if ((hexValue >> 24) > 0) //AARRGGBB
    {
        color = [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                                 blue:((float)(hexValue & 0xFF))/255.0
                                alpha:((float)((hexValue & 0xFF000000) >> 24))/255.0];
    }
    else //RRGGBB
    {
        color = [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                                 blue:((float)(hexValue & 0xFF))/255.0
                                alpha:1.0];
    }
    return color;
}

+(UIColor *) colorFromHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    return [[self colorFromHex:hex] colorWithAlphaComponent:alpha];
}

/**
 *  get UIClolor from hex string
 */
+(UIColor *)colorFromHexString:(NSString *)hex{
    return [self colorFromHexString:hex alpha:1];
}

+(UIColor *) colorFromHexString:(NSString*)hex alpha:(CGFloat)alpha {
    hex= [[hex uppercaseString] substringFromIndex:1];
    if (hex.length != 6) {
        return nil;
    }
    CGFloat valueArray[3];
    NSArray *strArray=[NSArray arrayWithObjects:[hex substringWithRange:NSMakeRange(0, 2)],[hex substringWithRange:NSMakeRange(2, 2)],[hex substringWithRange:NSMakeRange(4, 2)] ,nil];
    for( int i=0;i<strArray.count;i++){
        hex=strArray[i];
        CGFloat value=([hex characterAtIndex:0]>'9'?[hex characterAtIndex:0]-'A'+10:[hex characterAtIndex:0]-'0')*16.0f+([hex characterAtIndex:1]>'9'?[hex characterAtIndex:1]-'A'+10:[hex characterAtIndex:1]-'0');
        valueArray[i]=value;
    }
    return [UIColor colorWithRed:valueArray[0]/255 green:valueArray[1]/255 blue:valueArray[2]/255 alpha:alpha];
}

@end
