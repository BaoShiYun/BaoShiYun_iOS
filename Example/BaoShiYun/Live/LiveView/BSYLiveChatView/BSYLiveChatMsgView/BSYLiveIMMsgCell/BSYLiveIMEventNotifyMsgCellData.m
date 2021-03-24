//
//  BSYLiveIMEventNotifyMsgCellData.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMEventNotifyMsgCellData.h"
#import "BSYLiveIMTextMsgCellData.h"


#define BSYLiveIMEventNotifyMsg_ActionFont   [UIFont fontWithName:@"PingFangSC-Regular" size:14]

@interface BSYLiveIMEventNotifyMsgCellData()

@property (nonatomic, assign)CGSize textSize;
@property (nonatomic, assign)CGPoint textOrigin;


@end

@implementation BSYLiveIMEventNotifyMsgCellData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellTextLayout = [BSYLiveIMTextMsgCellLayout liveTextMessageCellLayout];
        self.actionFont = BSYLiveIMEventNotifyMsg_ActionFont;
        self.eventFont = BSYLiveIMEventNotifyMsg_ActionFont;
    }
    return self;
}




- (CGSize)contentSize
{
    CGSize sz = [super contentSize];
    
    CGFloat cellHeight = sz.height;
    CGFloat cellWidth = sz.width;
    
    CGFloat maxWidth = [BSYLiveIMMsgCellLayout getMaxCellWidth];
    maxWidth -= cellWidth;
    maxWidth -= self.cellTextLayout.messageInsets.left+self.cellTextLayout.messageInsets.right;
    if(maxWidth<0)
    {
        maxWidth=0;
    }
    CGRect textRect = [self.attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGSize textSz = CGSizeMake(ceil(textRect.size.width), ceil(textRect.size.height));
    
    if(textSz.height<15)
    {
        textSz.height = 15;
    }
    
    self.textOrigin = CGPointMake(self.cellTextLayout.messageInsets.left, self.cellTextLayout.messageInsets.top);
    self.textSize = CGSizeMake(textSz.width+10, textSz.height);
    
    cellWidth += self.cellTextLayout.messageInsets.left+textSz.width+self.cellTextLayout.messageInsets.right;
    cellHeight += self.cellTextLayout.messageInsets.top+textSz.height+self.cellTextLayout.messageInsets.bottom;
    return CGSizeMake(cellWidth, cellHeight);
}


- (NSAttributedString *)attributedString
{
    if (!_attributedString) {
        _attributedString = [self formatMessageActionName:self.actionName Action:self.action Event:self.event];
    }
    return _attributedString;
}


- (NSAttributedString *)formatMessageActionName:(NSString *)actionName Action:(NSString *)action Event:(NSString *)event
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    imageAttachment.image = AssetsImage(@"live_im_msg_notify_icon");
    //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
    imageAttachment.bounds = CGRectMake(0, -(self.nameFont.lineHeight-self.nameFont.pointSize)/2-2, 20, 20);
    NSAttributedString *imageAttributeString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [attributeString appendAttributedString:imageAttributeString];
    
    NSTextAttachment *blankAttach = [[NSTextAttachment alloc] init];
    blankAttach.bounds = CGRectMake(0, -(self.nameFont.lineHeight-self.nameFont.pointSize)/2-2, 8, 20); //是为了调整下标签跟文字的位置
    blankAttach.image = [UIImage new];
    NSAttributedString *blankAttributedString = [NSAttributedString attributedStringWithAttachment:blankAttach];
   [attributeString appendAttributedString:blankAttributedString];//加入文字前面
    
    if(self.isCustomizeStyle)
    {
        for (BSYLiveNotifyTextStyleModel *textStyleModel in self.customizeStyleDetail){
            
            if(textStyleModel.text && textStyleModel.text.length>0)
            {
                UIColor *textColor = nil;
                if(textStyleModel.color && textStyleModel.color.length>0)
                {
                    textColor = HexStringColor(textStyleModel.color);
                }
                if(textColor==nil)
                {
                    textColor = self.eventColor;
                }
                
                NSMutableAttributedString *nameAttributeString = [[NSMutableAttributedString alloc] initWithString:textStyleModel.text];
                [nameAttributeString addAttribute:NSFontAttributeName value:self.eventFont range:NSMakeRange(0, textStyleModel.text.length)];
                [nameAttributeString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, textStyleModel.text.length)];
                [attributeString appendAttributedString:nameAttributeString];
            }
        }
    }
    else
    {
        if(actionName && actionName.length>0)
        {
            
            NSMutableAttributedString *nameAttributeString = [[NSMutableAttributedString alloc] initWithString:actionName];
            [nameAttributeString addAttribute:NSFontAttributeName value:self.nameFont range:NSMakeRange(0, actionName.length)];
            [nameAttributeString addAttribute:NSForegroundColorAttributeName value:self.nameColor range:NSMakeRange(0, actionName.length)];
            [attributeString appendAttributedString:nameAttributeString];
        }
        
        if(action && action.length>0)
        {
            NSMutableAttributedString *actionAttributeString = [[NSMutableAttributedString alloc] initWithString:action];
            [actionAttributeString addAttribute:NSFontAttributeName value:self.actionFont range:NSMakeRange(0, action.length)];
            [actionAttributeString addAttribute:NSForegroundColorAttributeName value:self.actionColor range:NSMakeRange(0, action.length)];
            [attributeString appendAttributedString:actionAttributeString];
        }
        
        if(event && event.length>0)
        {
            NSMutableAttributedString *eventAttributeString = [[NSMutableAttributedString alloc] initWithString:event];
            [eventAttributeString addAttribute:NSFontAttributeName value:self.eventFont range:NSMakeRange(0, event.length)];
            [eventAttributeString addAttribute:NSForegroundColorAttributeName value:self.eventColor range:NSMakeRange(0, event.length)];
            [attributeString appendAttributedString:eventAttributeString];
        }
    }
    return attributeString;
}

@end
