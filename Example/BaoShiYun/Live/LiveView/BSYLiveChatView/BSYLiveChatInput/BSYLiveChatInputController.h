//
//  BSYLiveChatInputController.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveIMInputStatus) {
    BSYLiveIMInputStatus_InputNone,
    BSYLiveIMInputStatus_InputFace,
    BSYLiveIMInputStatus_InputKeyboard,
};

@class BSYLiveIMFaceView;
@class BSYLiveIMInputBar;
@class BSYLiveIMMenuView;


typedef void (^BSYLiveChatInputControllerBlock)(NSString *string);

@interface BSYLiveChatInputController : UIViewController


/**
 *  输入条
 *  输入条中包含文本输入框、语音按钮、“更多”按钮、表情按钮等一系列交互组件，并提供了这些组件的对应回调委托。
 */
@property (nonatomic, strong) BSYLiveIMInputBar *inputBar;

/**
 *  表情视图
 *  表情视图一般在点击“笑脸”按钮后浮现。负责显示各个表情分组，与分组内表情的具体信息。
 */
@property (nonatomic, strong) BSYLiveIMFaceView * __nullable faceView;


/**
*  菜单视图
*  菜单视图位于表情视图下方，负责提供表情分组单元以及发送按钮。
*/
@property (nonatomic, strong) BSYLiveIMMenuView *menuView;


/**
 *  重置当前输入控制器。
 *  如果当前有表情视图或者“更多“视图正在显示，则收起相应视图，并将当前状态设置为 Input_Status_Input。
 *  即无论当前 InputController 处于何种状态，都将其重置为初始化后的状态。
 */


@property (nonatomic, assign) BSYLiveIMInputStatus status;

@property (nonatomic, copy) BSYLiveChatInputControllerBlock inputBlock;


- (void)changeViewPortraitScreen:(BOOL)isPortrait;
- (void)showFaceView;
- (void)showKeyboard;
- (void)resetInput;
- (void)resetInputWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
