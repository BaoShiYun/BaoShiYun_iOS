//
//  BSYLiveIMEventNotifyMsgCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMEventNotifyMsgCell.h"
#import "BSYLiveIMEventNotifyMsgCellData.h"

@interface BSYLiveIMEventNotifyMsgCell()

@property (nonatomic, strong)BSYLiveIMEventNotifyMsgCellData *textData;


@end

@implementation BSYLiveIMEventNotifyMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.roleLabel.hidden = YES;
        [self.bubbleView addSubview:self.textContent];
    }
    return self;
}



- (UILabel *)textContent
{
    if(!_textContent)
    {
        _textContent = [[UILabel alloc] init];
        _textContent.numberOfLines = 0;
    }
    return _textContent;
}

- (BSYLiveIMEventNotifyMsgCellData *)textData
{
    if(!_textData)
    {
        _textData = [[BSYLiveIMEventNotifyMsgCellData alloc] init];
    }
    return _textData;
}



- (void)fillWithData:(BSYLiveIMEventNotifyMsgCellData *)data;
{
    //set data
    [super fillWithData:data];
    self.textData = data;
    self.textContent.attributedText = data.attributedString;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textContent.frame = CGRectMake(self.textData.textOrigin.x, self.textData.textOrigin.y, self.textData.textSize.width, self.textData.textSize.height);
}

@end
