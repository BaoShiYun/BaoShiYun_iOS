//
//  BSYUCUserInfoModel.h
//  BSYUC
//
//  Created by Duane on 2020/12/8.
//

#import <BSYUC/BSYUCModel.h>
#import <BSYLib/BSYLibMacro.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYGender) {
    BSYGenderNone = 0, // 未设置
    BSYGenderMale = 1, // 男
    BSYGenderFemale = 2, // 女
};

@interface BSYIndustryModel : BSYUCModel <NSCoding, NSCopying>

@property(nonatomic, assign) uintID ID;
@property(nonatomic, strong) NSString *industry;

@end

@interface BSYUCUserInfoModel : BSYUCModel <NSCoding, NSCopying>

@property(nonatomic, assign) uintID uid;
@property(nonatomic, strong) NSString *mobile;
@property(nonatomic, strong) NSString *areaCode;
@property(nonatomic, strong) NSString *nickName;
@property(nonatomic, assign) BSYGender gender;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, assign) BOOL wechatIsBind;
@property(nonatomic, strong) NSString *wechatNickName;
@property(nonatomic, strong) NSString *wechatAvatar;

@property(nonatomic, copy, nullable) NSDate *updateDate;
@property(nonatomic, copy) NSString *uniqueId;


@property(nonatomic, strong) NSString *realname BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *birthday BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *province BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *city BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *area BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *email BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *company BSYDeprecated("未启用");
@property(nonatomic, assign) uintID industryId BSYDeprecated("未启用");
@property(nonatomic, strong) NSString *industry BSYDeprecated("未启用");

@end

NS_ASSUME_NONNULL_END
