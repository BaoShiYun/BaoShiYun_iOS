//
//  BSYHud.h
//  BSYUILib
//
//  Created by Duane on 2020/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYHud : NSObject

+ (void)setHUDStyle;
+ (void)showHUDLoading:(NSString *)message;
+ (void)showHUDSuccess:(NSString *)message;
+ (void)showHUDError:(NSString *)message;
+ (void)showHUDMessage:(NSString *)message;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
