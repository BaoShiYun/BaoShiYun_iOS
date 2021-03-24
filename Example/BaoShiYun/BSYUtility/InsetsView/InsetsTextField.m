//
//  InsetsTextField.m
//  EagleApp
//
//  Created by duane on 2017/8/26.
//  Copyright © 2017年 duane. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

- (CGRect)rightViewRect {
    return self.rightView.bounds;
}

- (CGRect)leftViewRect {
    return self.leftView.bounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += self.insets.left;
    bounds.origin.y += self.insets.top;
    bounds.size.width -= self.insets.left+self.insets.right;
    bounds.size.height -= self.insets.top+self.insets.bottom;

    CGRect rect = bounds;
    rect.origin.x += self.leftViewRect.size.width;
    rect.size.width -= self.leftViewRect.size.width;
    rect.size.width -= self.rightViewRect.size.width;
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += self.insets.left;
    bounds.origin.y += self.insets.top;
    bounds.size.width -= self.insets.left+self.insets.right;
    bounds.size.height -= self.insets.top+self.insets.bottom;
    
    CGRect rect = bounds;
    rect.origin.x += self.leftViewRect.size.width;
    rect.size.width -= self.leftViewRect.size.width;
    rect.size.width -= self.rightViewRect.size.width;
    return rect;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += self.insets.left;
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x -= self.insets.right;
    return rect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect.origin.x -= self.insets.right;
    return rect;
}

@end
