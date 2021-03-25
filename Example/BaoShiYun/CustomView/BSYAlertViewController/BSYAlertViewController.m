//
//  BSYAlertViewController.m
//  BSYUILib
//
//  Created by Duane on 2020/12/8.
//

#import "BSYAlertViewController.h"
#import "TYAlertController.h"

@interface KKBTYAlertController : TYAlertController

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation KKBTYAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.backgroundColor = [UIColor clearColor];
}

#pragma mark 银幕旋转控制

-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end

@interface BSYAlertController ()

@property (nonatomic, strong)KKBTYAlertController *alertController;

@end

@implementation BSYAlertController

- (UIViewController *)viewController {
    return self.alertController;
}

- (UIView *)backgroundView {
    return self.alertController.backgroundView;
}

- (instancetype)initWithView:(UIView *)view style:(BSYAlertControllerStyle)style {
    if (self = [super init]) {
        TYAlertControllerStyle tyStyle = TYAlertControllerStyleAlert;
        switch (style) {
            case KKBAlertControllerStyle_Alert:
                tyStyle = TYAlertControllerStyleAlert;
                break;
            case KKBAlertControllerStyle_ActionSheet:
                tyStyle = TYAlertControllerStyleActionSheet;
                break;
            case KKBAlertControllerStyle_SlideTop:
                tyStyle = TYAlertControllerStyle_SlideTop;
                break;
            case KKBAlertControllerStyle_SlideLeft:
                tyStyle = TYAlertControllerStyle_SlideLeft;
                break;
            case KKBAlertControllerStyle_SlideRight:
                tyStyle = TYAlertControllerStyle_SlideRight;
                break;
            default:
                break;
        }
        self.alertController = [KKBTYAlertController alertControllerWithAlertView:view preferredStyle:tyStyle];
        @weakify(self);
        self.alertController.dismissComplete = ^{
            @strongify(self);
            if (self.dismissComplete) {
                self.dismissComplete();
            }
        };
    }
    return self;
}

@end

@interface BSYAlertViewController ()

@property (nonatomic, strong)KKBTYAlertController *alertController;

@property (nonatomic, assign) BSYAlertControllerStyle style;

@end

@implementation BSYAlertViewController

- (instancetype)init {
    if (self = [super init]) {
        self.style = KKBAlertControllerStyle_Alert;
    }
    return self;
}

- (instancetype)initWithStyle:(BSYAlertControllerStyle)style {
    if (self = [super init]) {
        self.style = style;
    }
    return self;
}

- (void)showInController:(UIViewController *)controller {
    TYAlertControllerStyle tyStyle = TYAlertControllerStyleAlert;
    switch (self.style) {
        case KKBAlertControllerStyle_Alert:
            tyStyle = TYAlertControllerStyleAlert;
            break;
        case KKBAlertControllerStyle_ActionSheet:
            tyStyle = TYAlertControllerStyleActionSheet;
            break;
        case KKBAlertControllerStyle_SlideTop:
            tyStyle = TYAlertControllerStyle_SlideTop;
            break;
        case KKBAlertControllerStyle_SlideLeft:
            tyStyle = TYAlertControllerStyle_SlideLeft;
            break;
        case KKBAlertControllerStyle_SlideRight:
            tyStyle = TYAlertControllerStyle_SlideRight;
            break;
        default:
            break;
    }
    self.alertController = [KKBTYAlertController alertControllerWithAlertView:self.view preferredStyle:tyStyle];
    self.alertController.controller = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:self.alertController animated:YES completion:^{
            
        }];
    });
    
}

- (void)dismiss {
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
           [self.alertController dismissViewControllerAnimated:animated completion:^{
               if (self.dismissComplete) {
                   self.dismissComplete();
               }
               self.alertController.controller = nil;
               self.alertController = nil;
           }];
       });
}

@end
