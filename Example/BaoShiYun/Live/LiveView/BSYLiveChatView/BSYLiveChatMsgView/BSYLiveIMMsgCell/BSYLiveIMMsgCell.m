//
//  BSYLiveIMMsgCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCell.h"
#import "BSYLiveIMMsgCellData.h"


@interface BSYLiveIMMsgCell()

@property (nonatomic, strong)BSYLiveIMMsgCellData *messageData;
@property (nonatomic, strong)UITapGestureRecognizer *tapRecognizer;

@end


@implementation BSYLiveIMMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.container];
        //[self.container addSubview:self.roleLabel];
        [self.container addSubview:self.bubbleView];
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        self.tapRecognizer.delegate = self;
        self.tapRecognizer.cancelsTouchesInView = NO;
        [self.bubbleView addGestureRecognizer:self.tapRecognizer];
    }
    return self;
}

- (UIView *)container
{
    if(!_container)
    {
        _container  = [[UIView alloc] init];
    }
    return _container;
}

- (UILabel *)roleLabel
{
    if(!_roleLabel)
    {
        _roleLabel = [[UILabel alloc] init];
        _roleLabel.numberOfLines = 1;
        _roleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _roleLabel;
}

- (UIView *)bubbleView
{
    if(!_bubbleView)
    {
        _bubbleView = [[UIView alloc] init];
    }
    return _bubbleView;
}


- (BSYLiveIMMsgCellData *)messageData
{
    if(!_messageData)
    {
        _messageData = [[BSYLiveIMMsgCellData alloc] init];
    }
    return _messageData;
}

- (void)fillWithData:(BSYLiveIMMsgCellData *)data;
{
    //set data
    [super fillWithData:data];
    self.tapHandle = nil;
    self.messageData = data;
//    self.roleLabel.text =  data.role;
//    self.roleLabel.font = data.roleFont;
//    self.roleLabel.backgroundColor = data.roleBgColor;
//    self.roleLabel.textColor = data.roleColor;
//    self.roleLabel.layer.cornerRadius = 9.5;
//    self.roleLabel.layer.masksToBounds = YES;
    self.bubbleView.backgroundColor = data.bubbleColor;
    self.bubbleView.layer.cornerRadius = data.bubbleCorner;
    self.bubbleView.layer.masksToBounds = YES;
    self.bubbleView.clipsToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize csize = self.messageData.contentSize;
    self.container.frame = CGRectMake(0, 0, csize.width, csize.height);
    BSYLiveIMMsgCellLayout *cellLayout = self.messageData.cellLayout;
    self.bubbleView.frame = CGRectMake(cellLayout.bubbleInsets.left, cellLayout.bubbleInsets.top, csize.width-cellLayout.bubbleInsets.left, csize.height-cellLayout.bubbleInsets.top-cellLayout.bubbleInsets.bottom);
}

- (void)tapGesture:(UIGestureRecognizer *)gesture
{
    if(self.tapHandle)
    {
        self.tapHandle();
    }
}


@end
