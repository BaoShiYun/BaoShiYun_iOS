//
//  BSYLiveMenuOptionCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/11.
//

#import "BSYLiveMenuOptionCell.h"

@interface BSYLiveMenuOptionCell()

@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation BSYLiveMenuOptionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self createSubView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)createSubView {
    [self.contentView addSubview:self.titleLabel];
}

- (void)updateConstraints {
    [super updateConstraints];
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.contentView);
    }];
}


- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = HexAlphaColor(0xFFFFFF,1.0);
    }
    return _titleLabel;
}



- (void)setTitleText:(NSString *)titleText withHighlight:(BOOL)highlight {
    self.titleLabel.text = titleText;
    if(highlight) {
        self.titleLabel.textColor = HexAlphaColor(0x00CAFF, 1.0);
    } else {
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    
}

+ (CGFloat)cellHeight {
    return 40.0;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
