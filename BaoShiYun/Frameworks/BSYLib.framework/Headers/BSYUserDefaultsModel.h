//
//  BSYUserDefaultsModel.h
//  BSYLib
//
//  Created by Duane on 2020/11/9.
//

#import <Foundation/Foundation.h>
#import <BSYLib/BSYSingletonKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYUserDefaultsModel : NSObject

DEFINE_SINGLETON_FOR_H(BSYUserDefaultsModel)

@end

NS_ASSUME_NONNULL_END

#define BSYUD_Property_Object(className, propertyName)    \
@property (nonatomic, nullable, setter = set_##propertyName:, getter = propertyName ) className *propertyName;

#define BSYUD_Property_Number(valueType, propertyName)    \
@property (nonatomic, setter = set_##propertyName:, getter = propertyName ) valueType propertyName;

#define BSYUD_Property_String(propertyName) BSYUD_Property_Object(NSString, propertyName)
#define BSYUD_Property_Date(propertyName) BSYUD_Property_Object(NSDate, propertyName)

#define BSYUD_Property_Integer(propertyName) BSYUD_Property_Number(NSInteger, propertyName)
#define BSYUD_Property_Enum(enumType, propertyName) BSYUD_Property_Number(enumType, propertyName)
#define BSYUD_Property_Float(propertyName) BSYUD_Property_Number(float, propertyName)
#define BSYUD_Property_Double(propertyName) BSYUD_Property_Number(double, propertyName)
#define BSYUD_Property_Bool(propertyName) BSYUD_Property_Number(BOOL, propertyName)


#define BSYUD_Synthesize_Object(className, propertyName, defaultValue)    \
- (void)set_##propertyName:(className *)propertyName {  \
    if (propertyName) { \
        [StandardUserDefaults setObject:propertyName forKey:@#propertyName.md5];   \
    } else {    \
        [StandardUserDefaults removeObjectForKey:@#propertyName.md5];  \
    }   \
    [StandardUserDefaults synchronize]; \
}   \
    \
- (className *)propertyName {   \
    className *propertyName = [StandardUserDefaults objectForKey:@#propertyName.md5];  \
    if (propertyName) { \
        return propertyName;    \
    }   \
    return defaultValue; \
}

#define BSYUD_Synthesize_Number(valueType, valueFunction, propertyName, defaultValue)    \
- (void)set_##propertyName:(valueType)propertyName {  \
    [StandardUserDefaults setObject:@(propertyName) forKey:@#propertyName.md5];   \
    [StandardUserDefaults synchronize]; \
}   \
    \
- (valueType)propertyName {   \
    NSNumber *propertyName = [StandardUserDefaults objectForKey:@#propertyName.md5];  \
    if (propertyName) { \
        return propertyName.valueFunction;    \
    }   \
    return defaultValue; \
}

#define BSYUD_Synthesize_Date(propertyName, defaultValue)    \
- (void)set_##propertyName:(NSDate *)propertyName {  \
    [StandardUserDefaults setObject:@(propertyName.timeIntervalSince1970) forKey:@#propertyName.md5];   \
    [StandardUserDefaults synchronize]; \
}   \
    \
- (NSDate *)propertyName {   \
    NSNumber *propertyName = [StandardUserDefaults objectForKey:@#propertyName.md5];  \
    if (propertyName) { \
        return [NSDate dateWithTimeIntervalSince1970:propertyName.doubleValue];    \
    }   \
    return defaultValue; \
}

#define BSYUD_Synthesize_String(propertyName, defaultValue) BSYUD_Synthesize_Object(NSString, propertyName, defaultValue)
#define BSYUD_Synthesize_Integer(propertyName, defaultValue) BSYUD_Synthesize_Number(NSInteger, integerValue, propertyName, defaultValue)
#define BSYUD_Synthesize_Enum(enumType, propertyName, defaultValue) BSYUD_Synthesize_Number(enumType, integerValue, propertyName, defaultValue)
#define BSYUD_Synthesize_Float(propertyName, defaultValue) BSYUD_Synthesize_Number(float, floatValue, propertyName, defaultValue)
#define BSYUD_Synthesize_Double(propertyName, defaultValue) BSYUD_Synthesize_Number(double, doubleValue, propertyName, defaultValue)
#define BSYUD_Synthesize_Bool(propertyName, defaultValue) BSYUD_Synthesize_Number(BOOL, boolValue, propertyName, defaultValue)
