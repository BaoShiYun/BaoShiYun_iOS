//
//  BSYLiveQuestionModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

/**
  题型
 */
typedef NS_ENUM(NSInteger, BSYLiveQuestionType) {
    
    /**
     * 单选
     */
    BSYLiveQuestionType_Single = 1,
    
    /**
     * 多选题
     */
    BSYLiveQuestionType_Multiple = 2,
    
    /**
     * 不定选
     */
    BSYLiveQuestionType_Unsteady = 3,
    
    /**
     * 判断题
     */
    BSYLiveQuestionType_Judgement = 4,
};

NS_ASSUME_NONNULL_BEGIN


/**
 直播间测验
 */
@interface BSYLiveQuestionModel : NSObject

/**
 *   @brief  问题id
 */
@property (nonatomic, strong) NSString *questionId;

/**
 *   @brief  问题名称
 */
@property (nonatomic, strong) NSString *title; // "图片选择混排",

/**
 *   @brief  问题描述
 */
@property (nonatomic, strong) NSString *desc; // "<p>图片选择混排<img src=\"/q_img/4390/e4b78d48f80e44ea8951b1c0f2e41504.png\"><img src=\"/q_img/4390/276c9cfac7b844bea79362a2cacbc686.png\"></p>",

/**
 *   @brief  问题类型
 *   @see BSYLiveQuestionType
 */
@property (nonatomic, assign) BSYLiveQuestionType type; // 2,

/**
 *   @brief  移动端答题及完成后结果页面地址
 */
@property (nonatomic, strong) NSString *mobileLiveQuestionUrl;

/**
 *   @brief  问题是否已经完成
 *   @discussion true-已完成  false-未完成
 */
@property (nonatomic, assign) BOOL answerQuestion;

/**
 *   @brief   PC端答题及完成后结果页面地址
 */
@property (nonatomic, strong) NSString *pcliveQuestionUrl;

@end

NS_ASSUME_NONNULL_END
