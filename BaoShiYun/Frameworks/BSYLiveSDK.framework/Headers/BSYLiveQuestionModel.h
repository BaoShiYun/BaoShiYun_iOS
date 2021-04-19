//
//  BSYLiveQuestionModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

typedef NS_ENUM(NSInteger, BSYLiveQuestionType) {
    BSYLiveQuestionType_Single = 1, // 单选
    BSYLiveQuestionType_Multiple = 2, // 多选题
    BSYLiveQuestionType_Unsteady = 3, // 不定选
    BSYLiveQuestionType_Judgement = 4, // 判断题
};

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveQuestionModel : NSObject

@property (nonatomic, strong) NSString *questionId; // 0,
@property (nonatomic, strong) NSString *title; // "图片选择混排",
@property (nonatomic, strong) NSString *desc; // "<p>图片选择混排<img src=\"/q_img/4390/e4b78d48f80e44ea8951b1c0f2e41504.png\"><img src=\"/q_img/4390/276c9cfac7b844bea79362a2cacbc686.png\"></p>",
@property (nonatomic, assign) BSYLiveQuestionType type; // 2,
@property (nonatomic, strong) NSString *mobileLiveQuestionUrl;
@property (nonatomic, assign) BOOL answerQuestion; // false,
@property (nonatomic, strong) NSString *pcliveQuestionUrl;

@end

NS_ASSUME_NONNULL_END
