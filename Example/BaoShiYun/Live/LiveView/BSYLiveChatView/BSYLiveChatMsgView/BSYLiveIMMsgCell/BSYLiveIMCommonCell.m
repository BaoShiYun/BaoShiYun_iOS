//
//  BSYLiveIMCommonCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import "BSYLiveIMCommonCell.h"

@implementation BSYLiveIMCommonCellData

- (CGSize)contentSize
{
    return CGSizeMake(0, 0);
}

- (UIImage*)imageWithUIView:(UIView*)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

@end


@interface BSYLiveIMCommonCell()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)BSYLiveIMCommonCellData *data;
@property (nonatomic, strong)UITapGestureRecognizer *tapRecognizer;

@end



@implementation BSYLiveIMCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//        _tapRecognizer.delegate = self;
//        _tapRecognizer.cancelsTouchesInView = NO;
//        [self addGestureRecognizer:_tapRecognizer];
//        //_colorWhenTouched = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0  blue:219.0/255.0  alpha:1];
//        _changeColorWhenTouched = NO;
    }
    return self;
}

//
- (void)tapGesture:(UIGestureRecognizer *)gesture
{
//    if (self.data.cselector) {
//        UIViewController *vc = self.mm_viewController;
//        if ([vc respondsToSelector:self.data.cselector]) {
////            self.selected = YES;
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [vc performSelector:self.data.cselector withObject:self];
//#pragma clang diagnostic pop
//        }
//    }
}



- (void)fillWithData:(BSYLiveIMCommonCellData *)data
{
    self.data = data;
//    if (data.cselector) {
//        [self addGestureRecognizer:self.tapRecognizer];
//    } else {
//        [self removeGestureRecognizer:self.tapRecognizer];
//    }
}

//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if(self.changeColorWhenTouched){
//        self.backgroundColor = self.colorWhenTouched;
//    }
//}
//
//-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if(self.changeColorWhenTouched){
//       // self.backgroundColor = [UIColor whiteColor];
//    }
//}
//
//
//-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if(self.changeColorWhenTouched){
//        //self.backgroundColor = [UIColor whiteColor];
//    }
//}
//
//-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if(self.changeColorWhenTouched){
//       // self.backgroundColor = [UIColor whiteColor];
//    }
//}

@end
