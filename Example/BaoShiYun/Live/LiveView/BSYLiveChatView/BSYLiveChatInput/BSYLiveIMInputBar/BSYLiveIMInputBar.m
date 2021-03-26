//
//  BSYLiveIMInputBar.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMInputBar.h"
#import "BSYLiveIMResponderTextView.h"
#import "BSYLiveChatViewTheme.h"



#define BSYLiveIMInputBar_TextViewMaxLength       500
#define BSYLiveIMInputBar_TextViewHeightMax       49
#define BSYLiveIMInputBar_TextViewHeightMin       35
#define BSYLiveIMInputBar_TextViewMargin          7


@interface BSYLiveIMInputBar()<UITextViewDelegate>


@end


@implementation BSYLiveIMInputBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = BSYLiveIMInputBar_BgColor;
    [self addSubview:self.textViewContainer];
    [self.textViewContainer addSubview:self.faceButton];
    [self.faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.inputTextView.delegate = self;
    [self.textViewContainer addSubview:self.inputTextView];
    [self.inputTextView layoutSubviews];
    [self resizeSubviews:YES];
}

- (void)resizeSubviews:(BOOL)isPortrait {
    CGFloat margin = 0;
    if (!isPortrait) {
        margin = IPHONE_MARGIN_TOP;
    }
    self.textViewContainer.frame = CGRectMake(12+margin, 7, CGRectGetWidth([UIScreen mainScreen].bounds)-(12+margin)*2, CGRectGetHeight(self.frame)-14);
    self.faceButton.frame = CGRectMake(CGRectGetWidth(self.textViewContainer.frame)-35, CGRectGetHeight(self.textViewContainer.frame)-35, 35, 35);
    self.inputTextView.frame = CGRectMake(12, 0, CGRectGetWidth(self.textViewContainer.frame)-12-35, CGRectGetHeight(self.textViewContainer.frame));
}


- (void)layoutButton:(CGFloat)height {
    CGRect frame = self.frame;
    CGFloat offset = height - frame.size.height;
    frame.size.height = height;
    self.frame = frame;
    
    CGRect textContainerFrame = self.textViewContainer.frame;
    textContainerFrame.size.height = CGRectGetHeight(self.inputTextView.frame);
    self.textViewContainer.frame = textContainerFrame;
    
    self.faceButton.frame = CGRectMake(CGRectGetWidth(self.textViewContainer.frame)-35, (CGRectGetHeight(self.textViewContainer.frame)-35)/2.0, 35, 35);

    if(self.delegate && [self.delegate respondsToSelector:@selector(inputBar:didChangeInputHeight:)]) {
        [self.delegate inputBar:self didChangeInputHeight:offset];
    }
}


#pragma mark ----
#pragma mark 懒加载
- (UIButton *)faceButton {
    if(!_faceButton) {
        _faceButton = [[UIButton alloc] init];
        [_faceButton setImage:AssetsImage(@"live_im_face_btn_normal") forState:UIControlStateNormal];
        [_faceButton setImage:AssetsImage(@"live_im_face_btn_highlight") forState:UIControlStateHighlighted];
    }
    return _faceButton;
}

- (void)updateFaceButtonStatus:(BOOL)isFace {
    if(isFace) {
        [self.faceButton setImage:AssetsImage(@"live_im_face_btn_normal") forState:UIControlStateNormal];
        [self.faceButton setImage:AssetsImage(@"live_im_face_btn_highlight") forState:UIControlStateHighlighted];
    } else {
        [self.faceButton setImage:AssetsImage(@"live_im_keyboard_btn_normal") forState:UIControlStateNormal];
        [self.faceButton setImage:AssetsImage(@"live_im_keyboard_btn_normal") forState:UIControlStateHighlighted];
    }
}


- (BSYLiveIMResponderTextView *)inputTextView {
    if(!_inputTextView) {
        _inputTextView = [[BSYLiveIMResponderTextView alloc] init];
        _inputTextView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _inputTextView.textColor = BSYLiveIMInputBar_inputTextColor;
        _inputTextView.backgroundColor = [UIColor clearColor];
        [_inputTextView setReturnKeyType:UIReturnKeySend];
    }
    return _inputTextView;
}


- (UIView *)textViewContainer {
    if(!_textViewContainer) {
        _textViewContainer = [[UIView alloc] init];
        _textViewContainer.layer.cornerRadius = 4;
        _textViewContainer.layer.masksToBounds = YES;
        _textViewContainer.backgroundColor = BSYLiveIMInputBar_TextViewContainerColor;
    }
    return _textViewContainer;
}



#pragma mark ---
#pragma mark Action

- (void)clickKeyboardBtn:(UIButton *)sender {
    self.inputTextView.hidden = NO;
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputBarDidTouchKeyboard:)]) {
        [self.delegate inputBarDidTouchKeyboard:self];
    }
}

- (void)clickFaceBtn:(UIButton *)sender {
    self.inputTextView.hidden = NO;
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputBarDidTouchFace:)]){
        [self.delegate inputBarDidTouchFace:self];
    }
}

- (void)addEmoji:(NSString *)emoji {
    [self.inputTextView setText:[self.inputTextView.text stringByAppendingString:emoji]];
    if(self.inputTextView.contentSize.height > BSYLiveIMInputBar_TextViewHeightMax) {
        float offset = self.inputTextView.contentSize.height - self.inputTextView.frame.size.height;
        [self.inputTextView scrollRectToVisible:CGRectMake(0, offset, self.inputTextView.frame.size.width, self.inputTextView.frame.size.height) animated:YES];
    }
    [self textViewDidChange:self.inputTextView];
}

- (void)backDelete {
    [self textView:self.inputTextView shouldChangeTextInRange:NSMakeRange(self.inputTextView.text.length - 1, 1) replacementText:@""];
    [self textViewDidChange:self.inputTextView];
}

- (void)clearInput {
    self.inputTextView.text = @"";
    [self textViewDidChange:self.inputTextView];
}


#pragma mark - TextView

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.keyboardButton.hidden = YES;
    self.faceButton.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > BSYLiveIMInputBar_TextViewMaxLength && textView.markedTextRange == nil) {
          textView.text = [textView.text substringWithRange: NSMakeRange(0, BSYLiveIMInputBar_TextViewMaxLength)];
      }
    CGSize size = [self.inputTextView sizeThatFits:CGSizeMake(self.inputTextView.frame.size.width, BSYLiveIMInputBar_TextViewHeightMax)];
    CGFloat oldHeight = self.inputTextView.frame.size.height;
    CGFloat newHeight = size.height;

    if(newHeight > BSYLiveIMInputBar_TextViewHeightMax) {
        newHeight = BSYLiveIMInputBar_TextViewHeightMax;
    }
    if(newHeight < BSYLiveIMInputBar_TextViewHeightMin) {
        newHeight = BSYLiveIMInputBar_TextViewHeightMin;
    }
    if(oldHeight == newHeight) {
        return;
    }

    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect textFrame = ws.inputTextView.frame;
        textFrame.size.height += newHeight - oldHeight;
        ws.inputTextView.frame = textFrame;
        [ws layoutButton:newHeight + 2 * BSYLiveIMInputBar_TextViewMargin];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(inputBar:didSendText:)]) {
            NSString *sp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (sp.length == 0) {
            } else {
                [self.delegate inputBar:self didSendText:textView.text];
                [self clearInput];
            }
        }
        return NO;
    } else if ([text isEqualToString:@""]) {
        if (textView.text.length > range.location && [textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    return NO;
                } else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    return YES;
}


- (NSString *)getInput {
    return self.inputTextView.text;
}


- (void)dealloc {
    
}

#pragma mark ----
#pragma mark 横竖屏变化 UI变化

- (void)changeViewPortraitScreen:(BOOL)isPortrait {
    [self resizeSubviews:isPortrait];
}

@end
