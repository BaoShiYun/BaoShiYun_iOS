//
//  BSYLiveIMMsgCellData.m
//  BaoShiYun
//
//  Created by zddMac on 2020/12/15.
//

#import "BSYLiveIMMsgCellData.h"
#import "BSYLiveChatViewTheme.h"


#define BSYLiveIMMsgCellDefaultNameFont ([UIFont fontWithName:@"PingFangSC-Regular" size:14])
#define BSYLiveIMMsgCellDefaultRoleFont ([UIFont fontWithName:@"PingFangSC-Medium" size:13])
#define BSYLiveIMMsgCellDefaultAvatarImage ([UIImage imageNamed:@""])


static BSYLiveIMMsgCellLayout *sIMLiveMessageCellLayout;
static CGFloat sMaxCellWidth;

@implementation BSYLiveIMMsgCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.avatarSize = CGSizeMake(19, 19);
//        self.avatarInsets = (UIEdgeInsets){
//            .left = 0,
//            .top = 8,
//            .bottom = 8,
//        };
        self.bubbleInsets = (UIEdgeInsets){
                   .top = 4,
                   .bottom = 4,
                   .left = 0,
                   .right = 0,
          };
       
    }
    return self;
}


+ (BSYLiveIMMsgCellLayout *)liveMessageCellLayout
{
    if (!sIMLiveMessageCellLayout) {
        sIMLiveMessageCellLayout = [BSYLiveIMMsgCellLayout new];
    }
    return sIMLiveMessageCellLayout;
}

+ (void)setMaxCellWidth:(CGFloat)width
{
    sMaxCellWidth = width;
}

+ (CGFloat)getMaxCellWidth
{
    return sMaxCellWidth;
}

@end



@implementation BSYLiveIMMsgCellData


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellLayout = [BSYLiveIMMsgCellLayout liveMessageCellLayout];
        self.bubbleColor = BSYLiveIMMessageCellDefaultBubbleColor;
        self.bubbleCorner = 4;
        self.nameFont = BSYLiveIMMsgCellDefaultNameFont;
        self.nameColor = BSYLiveIMMessageCellNameColor;
        self.roleFont = BSYLiveIMMsgCellDefaultRoleFont;
        self.roleBgColor = BSYLiveIMRoleBgColor_Student;
        self.roleColor = BSYLiveIMRoleNameColor_Student;
        self.roleType = BSYLiveIMRoleType_Student;
    }
    return self;
}

- (void)setRoleType:(BSYLiveIMRoleType)roleType
{
    _roleType = roleType;
    switch (roleType) {
        case BSYLiveIMRoleType_Student:
            self.roleBgColor = BSYLiveIMRoleBgColor_Student;
            self.roleColor = BSYLiveIMRoleNameColor_Student;
            self.role = @"";
            break;
        case BSYLiveIMRoleType_Teacher:
            self.roleBgColor = BSYLiveIMRoleBgColor_Teacher;
            self.roleColor = BSYLiveIMRoleNameColor_Teacher;
            self.role = @"讲师";
            break;
        case BSYLiveIMRoleType_ClassTeacher:
            self.roleBgColor = BSYLiveIMRoleBgColor_HeadTeacher;
            self.roleColor = BSYLiveIMRoleNameColor_HeadTeacher;
            self.role = @"班班";
            break;
        case BSYLiveIMRoleType_Assistant:
            self.roleBgColor = BSYLiveIMRoleBgColor_TeachingAssistant;
            self.roleColor = BSYLiveIMRoleNameColor_TeachingAssistant;
            self.role = @"助教";
            break;
        case BSYLiveIMRoleType_Self:
            self.roleBgColor = BSYLiveIMRoleBgColor_Me;
            self.roleColor = BSYLiveIMRoleNameColor_Me;
            self.role = @"自己";
            break;
        default:
            break;
    }
}


- (CGSize)contentSize
{
    return CGSizeMake(self.cellLayout.bubbleInsets.left+self.cellLayout.bubbleInsets.right, self.cellLayout.bubbleInsets.top+self.cellLayout.bubbleInsets.bottom);
}

@end
