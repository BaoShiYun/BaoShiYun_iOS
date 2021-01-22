//
//  BSYLibMacro.h
//  BSYLib
//
//  Created by Duane on 2020/11/4.
//

#ifndef BSYLibMacro_h
#define BSYLibMacro_h

#define INT_RANDOM(from,to) ( from + ( arc4random() % ( to - from + 1 ) ) )

#define StandardUserDefaults [NSUserDefaults standardUserDefaults]

#define NSLogFunction() NSLog(@"Method called: %s", __func__)
#define NSLogCGRect(r) NSLog(@"CGRect x:%f y:%f w:%f h:%f", r.origin.x, r.origin.y, r.size.width, r.size.height)

#define MINUTE (60)
#define HOUR (60*MINUTE)
#define DAY (24*HOUR)

//正则表达式
#define sEmailRegexString           (@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?[\\.[a-zA-Z]{2,6}]+)\\b")
#define sPhoneNumberRegexString     (@"^1\\d{10}$")
#define sVerifyCodeRegexString4     (@"[0-9]{4}")
#define sVerifyCodeRegexString6     (@"[0-9]{6}")

#define sCommonDateFormatString     (@"yyyy-MM-dd HH:mm:ss")

// 资源文件
#define Framework_Bundle [NSBundle bundleForClass:self.class]

#define AssetsImage(name) [UIImage imageNamed:name inBundle:Framework_Bundle compatibleWithTraitCollection:nil]
#define AssetsOriginalImage(name) [AssetsImage(name) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define Framework_Bundle_Path [Framework_Bundle bundlePath]
#define Framework_Bundle_ResourcePath [Framework_Bundle resourcePath]
#define Framework_Bundle_Path_WithName(bundle) [Framework_Bundle_ResourcePath stringByAppendingPathComponent:bundle]
#define Framework_Bundle_WithName(bundle) [NSBundle bundleWithPath:Framework_Bundle_Path_WithName(bundle)]

#define ImageFromBundle(bundle, name) [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil]


#define IgnoredPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define BSYDeprecated(DESCRIPTION) __attribute__((deprecated(DESCRIPTION)))

#define weakObject(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define strongObject(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;

#if (DEBUG)
#define BSYLog(...) NSLog(@"BSYLog==>:%s\n %@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define BSYLog(...) {}
#endif

#endif /* BSYLibMacro_h */
