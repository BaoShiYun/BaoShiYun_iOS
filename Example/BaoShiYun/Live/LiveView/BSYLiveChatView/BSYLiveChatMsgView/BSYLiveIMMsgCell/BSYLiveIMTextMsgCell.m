//
//  BSYLiveIMTextMsgCell.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMTextMsgCell.h"
#import "BSYLiveIMTextMsgCellData.h"

@interface BSYLiveIMTextMsgCell()
@property (nonatomic, strong)BSYLiveIMTextMsgCellData *textData;

@end


@implementation BSYLiveIMTextMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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





- (void)fillWithData:(BSYLiveIMTextMsgCellData *)data;
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
