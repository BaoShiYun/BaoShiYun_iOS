//
//  BSYUCUserInfoModel.h
//  BSYUC
//
//  Created by Duane on 2020/12/8.
//

#import <BSYUC/BSYUCModel.h>

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
@property(nonatomic, strong) NSString *nickName;
@property(nonatomic, strong) NSString *realname;
@property(nonatomic, strong) NSString *birthday;
@property(nonatomic, strong) NSString *province;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *area;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, assign) BSYGender gender;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *company;
@property(nonatomic, assign) uintID industryId;
@property(nonatomic, strong) NSString *industry;
@property(nonatomic, assign) BOOL wechatIsBind;
@property(nonatomic, strong) NSString *wechatNickName;
@property(nonatomic, strong) NSString *wechatAvatar;

@property(nonatomic, copy, nullable) NSDate *updateDate;
@property(nonatomic, copy) NSString *uniqueId;

@end

NS_ASSUME_NONNULL_END
