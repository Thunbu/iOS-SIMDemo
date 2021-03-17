//
//  TBChatVideoCell.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/5.
//

#import "TBChatVideoCell.h"

@interface TBChatVideoCell()

@property(nonatomic, strong)UIImageView *messageImage;
@end

@implementation TBChatVideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _messageImage = [[UIImageView alloc]init];
        _messageImage.clipsToBounds = YES;
        _messageImage.userInteractionEnabled = YES;
        _messageImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.messageView addSubview:_messageImage];
        
        UIImageView *videoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ImagePicker_Video_Play"]];
        [self.messageView addSubview:videoImage];
        [videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.messageView);
            make.width.height.equalTo(@40);
        }];
    }
    return self;
}
- (void)configChatVideoMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager{
    SIMVideoElem *imageElem = (SIMVideoElem *)message.elem;
    [self.messageImage sd_setImageWithURL:[NSURL URLWithString:imageElem.coverUrl] placeholderImage:[UIImage imageNamed:@"im_chat_img_default"]];
    if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
        self.messageView.frame = CGRectMake(UIScreenWidth - 100 - 18 - 40 - 10, 5, 100+10, [manager messageBodyHeight:message]+10);
    }
    else {
        self.messageView.frame = CGRectMake(18+40, 5, 100+10, [manager messageBodyHeight:message]+10);
    }
    [_messageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageView);
    }];
    [self configHeaderImg:session chatMessage:message];
}
@end
