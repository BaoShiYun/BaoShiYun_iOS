//
//  BSYLiveEntryPageController.m
//  BaoShiYun
//
//  Created by zddMac on 2021/3/26.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYLiveEntryPageController.h"
#import "BSYConfig.h"
#import "BSYLiveViewController.h"


//param.userId = @"5488885";
//param.tenantId = BSYConfig.tencentId;
//param.enterCode = @"05d6acd00b414a939b634eb001f298fa";
//param.liveId = @"live-847494715441152";
//param.nickName = @"浪里个浪";
//param.avatarUrl = @"";

@interface BSYLiveEntryPageController ()

@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UILabel *uidTitle;
@property (nonatomic, strong)UITextField *uidText;
@property (nonatomic, strong)UILabel *nickNameTitle;
@property (nonatomic, strong)UITextField *nickNameText;
@property (nonatomic, strong)UILabel *avatarTitle;
@property (nonatomic, strong)UITextField *avatarText;
@property (nonatomic, strong)UILabel *liveIdTitle;
@property (nonatomic, strong)UITextField *liveIdText;
@property (nonatomic, strong)UILabel *enterCodeTitle;
@property (nonatomic, strong)UITextField *enterCodeText;
@property (nonatomic, strong)UIButton *enterBtn;


@end

@implementation BSYLiveEntryPageController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexAlphaColor(0x2C2C2E, 1.0);
    [self.view addSubview:self.returnBtn];
    [self.returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uidTitle];
    [self.view addSubview:self.uidText];
    [self.view addSubview:self.nickNameTitle];
    [self.view addSubview:self.nickNameText];
    [self.view addSubview:self.avatarTitle];
    [self.view addSubview:self.avatarText];
    [self.view addSubview:self.liveIdTitle];
    [self.view addSubview:self.liveIdText];
    [self.view addSubview:self.enterCodeTitle];
    [self.view addSubview:self.enterCodeText];
    [self.view addSubview:self.enterBtn];
    [self.enterBtn addTarget:self action:@selector(enterBtnAcition) forControlEvents:UIControlEventTouchUpInside];
    [self.view setNeedsUpdateConstraints];
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self);
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(IPHONE_MARGIN_TOP);
    }];
    
    [self.uidTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.top.equalTo(self.returnBtn.mas_bottom).with.offset(30);
    }];
    [self.uidText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self.uidTitle);
        make.left.equalTo(self.uidTitle.mas_right).with.offset(10);
        make.right.mas_equalTo(-30);
    }];
    
    [self.nickNameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.height.width.equalTo(self.uidTitle);
        make.top.equalTo(self.uidTitle.mas_bottom).with.offset(10);
    }];
    [self.nickNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self.nickNameTitle);
        make.right.left.equalTo(self.uidText);
    }];
    
    [self.avatarTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.height.width.equalTo(self.uidTitle);
        make.top.equalTo(self.nickNameTitle.mas_bottom).with.offset(10);
    }];
    [self.avatarText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self.avatarTitle);
        make.right.left.equalTo(self.uidText);
    }];
    
    [self.liveIdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.height.width.equalTo(self.uidTitle);
        make.top.equalTo(self.avatarTitle.mas_bottom).with.offset(10);
    }];
    [self.liveIdText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self.liveIdTitle);
        make.right.left.equalTo(self.uidText);
    }];
    
    [self.enterCodeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(10);
        make.height.right.equalTo(self.uidTitle);
        make.top.equalTo(self.liveIdTitle.mas_bottom).with.offset(10);
    }];
    [self.enterCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self.enterCodeTitle);
        make.right.left.equalTo(self.uidText);
    }];
    
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.enterCodeTitle.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(110);
            
    }];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIButton *)returnBtn {
    if(!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:AssetsImage(@"live_return_light_btn") forState:UIControlStateNormal];
        [_returnBtn setImage:AssetsImage(@"live_return_light_btn") forState:UIControlStateHighlighted];
    }
    return _returnBtn;
}


- (UILabel *)uidTitle {
    if(!_uidTitle) {
        _uidTitle = [[UILabel alloc] init];
        _uidTitle.textColor =  [UIColor whiteColor];
        _uidTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _uidTitle.textAlignment = NSTextAlignmentRight;
        _uidTitle.numberOfLines = 1;
        _uidTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _uidTitle.text = @"用户ID:";
    }
    return _uidTitle;
}
- (UITextField *)uidText {
    if(!_uidText) {
        _uidText = [[UITextField alloc] init];
        _uidText.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _uidText.textColor =  HexColor(0x000000);
        _uidText.keyboardType = UIKeyboardTypeASCIICapable;
        _uidText.returnKeyType = UIReturnKeyDone;
        _uidText.backgroundColor = [UIColor whiteColor];
        _uidText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _uidText.leftViewMode = UITextFieldViewModeAlways;
        _uidText.rightViewMode = UITextFieldViewModeAlways;
        _uidText.clearButtonMode = UITextFieldViewModeAlways;
        _uidText.layer.cornerRadius = 2;
        _uidText.layer.borderColor = [UIColor whiteColor].CGColor;
        _uidText.layer.borderWidth = 1.5;
        _uidText.placeholder = @"请填写用户UID(必填)";
        _uidText.text = @"5488885";
    }
    return _uidText;
}

- (UILabel *)nickNameTitle {
    if(!_nickNameTitle) {
        _nickNameTitle = [[UILabel alloc] init];
        _nickNameTitle.textColor =  [UIColor whiteColor];
        _nickNameTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _nickNameTitle.textAlignment = NSTextAlignmentRight;
        _nickNameTitle.numberOfLines = 1;
        _nickNameTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _nickNameTitle.text = @"用户昵称:";
    }
    return _nickNameTitle;
}
- (UITextField *)nickNameText {
    if(!_nickNameText) {
        _nickNameText = [[UITextField alloc] init];
        _nickNameText.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _nickNameText.textColor = HexColor(0x000000);
        _nickNameText.keyboardType = UIKeyboardTypeASCIICapable;
        _nickNameText.returnKeyType = UIReturnKeyDone;
        _nickNameText.backgroundColor = HexColor(0xFFFFFF);
        _nickNameText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _nickNameText.leftViewMode = UITextFieldViewModeAlways;
        _nickNameText.rightViewMode = UITextFieldViewModeAlways;
        _nickNameText.clearButtonMode = UITextFieldViewModeAlways;
        _nickNameText.layer.cornerRadius = 2;
        _nickNameText.layer.borderColor = HexColor(0xFFFFFF).CGColor;
        _nickNameText.layer.borderWidth = 1.5;
        _nickNameText.placeholder = @"请填写用户昵称(必填)";
        _nickNameText.text = @"浪里个浪";
    }
    return _nickNameText;
}

- (UILabel *)avatarTitle {
    if(!_avatarTitle) {
        _avatarTitle = [[UILabel alloc] init];
        _avatarTitle.textColor =  [UIColor whiteColor];
        _avatarTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _avatarTitle.textAlignment = NSTextAlignmentRight;
        _avatarTitle.numberOfLines = 1;
        _avatarTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _avatarTitle.text = @"用户头像:";
    }
    return _avatarTitle;
}
- (UITextField *)avatarText {
    if(!_avatarText) {
        _avatarText = [[UITextField alloc] init];
        _avatarText.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _avatarText.textColor = HexColor(0x000000);
        _avatarText.keyboardType = UIKeyboardTypeASCIICapable;
        _avatarText.returnKeyType = UIReturnKeyDone;
        _avatarText.backgroundColor = HexColor(0xFFFFFF);
        _avatarText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _avatarText.leftViewMode = UITextFieldViewModeAlways;
        _avatarText.rightViewMode = UITextFieldViewModeAlways;
        _avatarText.clearButtonMode = UITextFieldViewModeAlways;
        _avatarText.layer.cornerRadius = 2;
        _avatarText.layer.borderColor = HexColor(0xFFFFFF).CGColor;
        _avatarText.layer.borderWidth = 1.5;
        _avatarText.placeholder = @"请填写用户头像链接地址(选填)";
    }
    return _avatarText;
}

- (UILabel *)liveIdTitle {
    if(!_liveIdTitle) {
        _liveIdTitle = [[UILabel alloc] init];
        _liveIdTitle.textColor =  [UIColor whiteColor];
        _liveIdTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _liveIdTitle.textAlignment = NSTextAlignmentRight;
        _liveIdTitle.numberOfLines = 1;
        _liveIdTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _liveIdTitle.text = @"直播ID:";
    }
    return _liveIdTitle;
}
- (UITextField *)liveIdText {
    if(!_liveIdText) {
        _liveIdText = [[UITextField alloc] init];
        _liveIdText.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _liveIdText.textColor = HexColor(0x000000);
        _liveIdText.keyboardType = UIKeyboardTypeASCIICapable;
        _liveIdText.returnKeyType = UIReturnKeyDone;
        _liveIdText.backgroundColor = HexColor(0xFFFFFF);
        _liveIdText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _liveIdText.leftViewMode = UITextFieldViewModeAlways;
        _liveIdText.rightViewMode = UITextFieldViewModeAlways;
        _liveIdText.clearButtonMode = UITextFieldViewModeAlways;
        _liveIdText.layer.cornerRadius = 2;
        _liveIdText.layer.borderColor = HexColor(0xFFFFFF).CGColor;
        _liveIdText.layer.borderWidth = 1.5;
        _liveIdText.placeholder = @"请填写直播ID(必填)";
        _liveIdText.text = @"live-847494726975488";
    }
    return _liveIdText;
}


- (UILabel *)enterCodeTitle {
    if(!_enterCodeTitle) {
        _enterCodeTitle = [[UILabel alloc] init];
        _enterCodeTitle.textColor =  [UIColor whiteColor];
        _enterCodeTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _enterCodeTitle.textAlignment = NSTextAlignmentRight;
        _enterCodeTitle.numberOfLines = 1;
        _enterCodeTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _enterCodeTitle.text = @"EnterCode:";
    }
    return _enterCodeTitle;
}
- (UITextField *)enterCodeText {
    if(!_enterCodeText) {
        _enterCodeText = [[UITextField alloc] init];
        _enterCodeText.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _enterCodeText.textColor = HexColor(0x000000);
        _enterCodeText.keyboardType = UIKeyboardTypeASCIICapable;
        _enterCodeText.returnKeyType = UIReturnKeyDone;
        _enterCodeText.backgroundColor = HexColor(0xFFFFFF);
        _enterCodeText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _enterCodeText.leftViewMode = UITextFieldViewModeAlways;
        _enterCodeText.rightViewMode = UITextFieldViewModeAlways;
        _enterCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _enterCodeText.layer.cornerRadius = 2;
        _enterCodeText.layer.borderColor = HexColor(0xFFFFFF).CGColor;
        _enterCodeText.layer.borderWidth = 1.5;
        _enterCodeText.placeholder = @"请填写直播EnterCode(必填)";
        _enterCodeText.text = @"dae73c91c58f4bdd9279453e86b8512e";
    }
    return _enterCodeText;
}

- (UIButton *)enterBtn {
    if(!_enterBtn) {
        _enterBtn = [[UIButton alloc] init];
        _enterBtn.layer.cornerRadius = 20;
        _enterBtn.layer.masksToBounds = YES;
        _enterBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _enterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_enterBtn setTitle:@"进入直播间" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:HexAlphaColor(0xFFFFFF, 0.8) forState:UIControlStateNormal];
        _enterBtn.backgroundColor = HexAlphaColor(0x202020,1.0);
    }
    return _enterBtn;
}





- (void)enterBtnAcition {
    BSYLiveParam *param = [[BSYLiveParam alloc] init];
    param.userId = self.uidText.text;
    param.tenantId = BSYConfig.tencentId;
    param.enterCode = self.enterCodeText.text;
    param.liveId = self.liveIdText.text;
    param.nickName = self.nickNameText.text;
    param.avatarUrl = self.avatarText.text;
    BSYLiveViewController *live = [[BSYLiveViewController alloc] initWithLiveParam:param];
    [self.navigationController pushViewController:live animated:YES];
}

- (void)returnBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
