//
//  TBChatTextCell.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import "TBChatTextCell.h"
#import "NSString+Rich.h"

@interface TBChatTextCell()

@property(nonatomic, strong)UILabel *txtLabel;
@end

@implementation TBChatTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.txtLabel = [[UILabel alloc]init];
        self.txtLabel.font = Regular(14);
        self.txtLabel.numberOfLines = 0;
        self.txtLabel.textAlignment = NSTextAlignmentLeft;
        self.txtLabel.textColor = [UIColor TB_colorForHex:0x1D2221];
        self.txtLabel.backgroundColor = [UIColor clearColor];
        self.txtLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.messageView addSubview:self.txtLabel];
    }
    return self;
}
- (void)configChatTextMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager{
    if ([message.elem isKindOfClass:[SIMTextElem class]]){
        SIMTextElem *textElem = (SIMTextElem *)message.elem;
        NSMutableAttributedString *attributedText = [textElem.text TB_richTextForYYTextWithFont:Regular(14)];
        self.txtLabel.attributedText = attributedText;
        CGFloat messageW = [manager messageBodyWidth:message];
        if (messageW > UIScreenWidth-64*3){
            messageW = UIScreenWidth-64*3;
        }
        if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
            self.messageView.frame = CGRectMake(UIScreenWidth - messageW - 18 - 40 - 10, 5, messageW+10, [manager messageBodyHeight:message]+10);
            self.txtLabel.frame = CGRectMake(5, 5, messageW, [manager messageBodyHeight:message]);
        }
        else {
            self.txtLabel.frame = CGRectMake(5, 5, messageW, [manager messageBodyHeight:message]);
            self.messageView.frame = CGRectMake(18+40, 5, messageW+10, [manager messageBodyHeight:message]+10);
        }
        [self configHeaderImg:session chatMessage:message];
    }
}
@end
