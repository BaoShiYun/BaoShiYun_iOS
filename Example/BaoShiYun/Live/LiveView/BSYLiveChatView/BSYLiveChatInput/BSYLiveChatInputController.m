//
//  BSYLiveChatInputController.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveChatInputController.h"
#import "BSYLiveIMInputBar.h"
#import "BSYLiveIMFaceView.h"
#import "BSYLiveIMFaceCache.h"
#import "BSYLiveIMResponderTextView.h"
#import "BSYLiveIMFaceCell.h"
#import "BSYLiveChatViewTheme.h"

#define BSYLiveIMInputController_FaceViewHeight (180+(IPHONE_MARGIN_BOTTOM/3.0))
#define BSYLiveIMInputController_TextViewHeight  49
#define BSYLiveIMInputController_FaceViewPadding 20

@interface BSYLiveChatInputController ()<BSYLiveIMTextViewDelegate,BSYLiveIMFaceViewDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, assign) CGFloat faceViewPagePadding;
@property (nonatomic, assign) BOOL isPortrait;

@end

@implementation BSYLiveChatInputController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self setupViews];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.status==BSYLiveIMInputStatus_InputFace) {
        [self showFaceView];
    } else if(self.status==BSYLiveIMInputStatus_InputKeyboard) {
        [self showKeyboard];
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     self.status = BSYLiveIMInputStatus_InputNone;
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tapView];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.tapRecognizer.numberOfTouchesRequired = 1;
    self.tapRecognizer.numberOfTapsRequired = 1;
    //self.tapRecognizer.delegate = self;
    [self.tapView addGestureRecognizer:self.tapRecognizer];
    
    [self.view addSubview:self.container];
    self.status = BSYLiveIMInputStatus_InputNone;
    self.inputBar.delegate = self;
    [self.container addSubview:self.inputBar];
    self.container.backgroundColor = BSYLiveIMInputController_BgColor;
    if (@available(iOS 11.0, *)) {} else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



#pragma mark --
#pragma mark 懒加载

- (BSYLiveIMFaceView *)faceView {
    if(!_faceView) {
        _faceView = [[BSYLiveIMFaceView alloc] initWithFrame:CGRectMake(0, self.inputBar.frame.size.height, self.view.frame.size.width, BSYLiveIMInputController_FaceViewHeight) facePagePadding:self.faceViewPagePadding];
        _faceView.delegate = self;
        [_faceView setData:[[BSYLiveIMFaceCache sharedInstance] getDefaultFaceGroups]];
    }
    return _faceView;
}

- (UIView *)container {
    if(!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    }
    return _container;
}


- (BSYLiveIMInputBar *)inputBar {
    if(!_inputBar) {
        _inputBar = [[BSYLiveIMInputBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BSYLiveIMInputController_TextViewHeight)];
    }
    return _inputBar;
}

- (UIView *)tapView {
    if(!_tapView) {
        _tapView = [[UIView alloc] init];
    }
    return _tapView;
}

#pragma mark --
#pragma mark InputBar

- (void)moveInputContainerOriginY:(CGFloat)originY animate:(BOOL)animated complete:(void (^)(void))completionBlock {
    if(animated) {
        @weakify(self);
        self.tapView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), originY);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            @strongify(self);
            CGRect containerFrame = self.container.frame;
            containerFrame.origin.y = originY;
            self.container.frame = containerFrame;
           } completion:^(BOOL finished) {
               if(completionBlock) {
                    completionBlock();
               }
           }];
    } else {
        CGRect containerFrame = self.container.frame;
        containerFrame.origin.y = originY;
        self.container.frame = containerFrame;
        if(completionBlock) {
             completionBlock();
        }
    }
}


#pragma mark  键盘
- (void)keyboardWillHide:(NSNotification *)notification {
    if(self.status==BSYLiveIMInputStatus_InputKeyboard) {
        [self resetInput];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if(self.status == BSYLiveIMInputStatus_InputFace){
        [self hideFaceAnimation];
    } else {
        //[self hideFaceAnimation:NO];
        //[self hideMoreAnimation:NO];
    }
    self.status = BSYLiveIMInputStatus_InputKeyboard;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if(self.status==KKBIMInput_Status_Input_Keyboard)
//    {
        [self moveInputContainerOriginY:CGRectGetHeight(self.view.frame)-keyboardFrame.size.height- self.inputBar.frame.size.height animate:YES complete:nil];
    //}
}


- (void)inputBarDidTouchKeyboard:(BSYLiveIMInputBar *)textView {
    if (_status == BSYLiveIMInputStatus_InputFace) {
        [self hideFaceAnimation];
    }
    _status = BSYLiveIMInputStatus_InputKeyboard;
    [_inputBar.inputTextView becomeFirstResponder];
    [_inputBar updateFaceButtonStatus:YES];
    [self keyboardOrFaceViewIsShow:YES];
}

- (void)keyboardOrFaceViewIsShow:(BOOL)isShow {
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.isPortrait? UIInterfaceOrientationPortrait:UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.isPortrait? UIInterfaceOrientationMaskPortrait:UIInterfaceOrientationMaskLandscapeRight;
}


#pragma mark ---
#pragma mark 表情

- (void)hideFaceAnimation {
    self.faceView.alpha = 1.0;
    @weakify(self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        @strongify(self);
        self.faceView.alpha = 0.0;
    } completion:^(BOOL finished) {
        @strongify(self);
        [self.faceView removeFromSuperview];
        self.faceView = nil;
    }];
}

- (void)showFaceAnimation {
    [self.container addSubview:self.faceView];
    [self.container bringSubviewToFront:self.faceView];
    @weakify(self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        @strongify(self);
        self.faceView.alpha = 1.0;
    } completion:nil];
}


- (void)inputBarDidTouchFace:(BSYLiveIMInputBar *)textView {
    if(self.status==BSYLiveIMInputStatus_InputFace) {
        [self showKeyboard];
    } else {
        [self showFaceView];
    }
}


#pragma mark show FaceView
- (void)showFaceView {
    self.status = BSYLiveIMInputStatus_InputFace;
    [self.inputBar.inputTextView resignFirstResponder];
    [self showFaceAnimation];
    [self.inputBar updateFaceButtonStatus:NO];
    [self keyboardOrFaceViewIsShow:YES];
    [self moveInputContainerOriginY:CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.faceView.frame)-CGRectGetHeight(self.inputBar.frame) animate:YES complete:^() {
           }];
}


#pragma mark show Keyboard
- (void)showKeyboard {
    [self inputBarDidTouchKeyboard:self.inputBar];
}



#pragma mark TTextViewDelegate

- (void)inputBar:(BSYLiveIMInputBar *)textView didChangeInputHeight:(CGFloat)offset {
    if(_status == BSYLiveIMInputStatus_InputFace) {
    }
    [self moveInputContainerOriginY:CGRectGetMinY(self.container.frame)-offset animate:YES complete:nil];
    
}

- (void)inputBar:(BSYLiveIMInputBar *)textView didSendText:(NSString *)text {
    if(self.inputBlock) {
        self.inputBlock(text);
    }
}


#pragma mark ---
#pragma mark KKBIMFaceViewDelegate

- (void)faceView:(BSYLiveIMFaceView *)faceView scrollToFaceGroupIndex:(NSInteger)index {
    
}

- (void)faceView:(BSYLiveIMFaceView *)faceView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray<BSYLiveIMFaceGroup *> *faceGroups = [[BSYLiveIMFaceCache sharedInstance] getDefaultFaceGroups];
    BSYLiveIMFaceGroup *group = faceGroups[indexPath.section];
    BSYLiveIMFaceCellData *face = group.faces[indexPath.row];
    if(indexPath.section == 0) {
        [self.inputBar addEmoji:face.name];
    }
}



- (void)faceViewDidBackDelete:(BSYLiveIMFaceView *)faceView {
    [self.inputBar backDelete];
}

- (void)resetInput {
    [self resetInputWithAnimated:YES];
}


- (void)resetInputWithAnimated:(BOOL)animated {
    if(_status == BSYLiveIMInputStatus_InputNone){
        return;
    } else if(_status == BSYLiveIMInputStatus_InputFace){
        [self hideFaceAnimation];
    } else {
         [_inputBar.inputTextView resignFirstResponder];
    }
    _status = BSYLiveIMInputStatus_InputNone;
    [self.inputBar updateFaceButtonStatus:YES];
    [self keyboardOrFaceViewIsShow:NO];
    if(animated) {
        @weakify(self);
        [self moveInputContainerOriginY:CGRectGetHeight(self.view.frame) animate:YES complete:^() {
            @strongify(self);
            [self forceRotation];
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    } else {
        [self moveInputContainerOriginY:CGRectGetHeight(self.view.frame) animate:YES complete:^() {
        }];
        [self forceRotation];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (void)forceRotation {
    UIInterfaceOrientation orientation = self.isPortrait? UIInterfaceOrientationPortrait:UIInterfaceOrientationLandscapeRight;
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
}




#pragma mark ----
#pragma mark 横竖屏变化 UI变化

- (void)changeViewPortraitScreen:(BOOL)isPortrait {
    self.isPortrait = isPortrait;
    self.container.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetHeight([UIScreen mainScreen].bounds));
    self.inputBar.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), BSYLiveIMInputController_TextViewHeight);
    [self.inputBar changeViewPortraitScreen:isPortrait];
    
    CGFloat padding = BSYLiveIMInputController_FaceViewPadding;
    if(!isPortrait) {
        padding += IPHONE_MARGIN_TOP;
    }
    self.faceViewPagePadding = padding;
}



#pragma mark --
#pragma mark UITapGestureRecognizer

-(void)tapGestureAction:(UITapGestureRecognizer *)tap {
    [self resetInput];
}

@end
