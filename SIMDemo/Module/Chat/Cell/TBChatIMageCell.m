//
//  TBChatIMageCell.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/4.
//

#import "TBChatIMageCell.h"

@interface TBChatIMageCell()

@property(nonatomic, strong)UIImageView *messageImage;
@end

@implementation TBChatIMageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _messageImage = [[UIImageView alloc]init];
        _messageImage.clipsToBounds = YES;
        _messageImage.userInteractionEnabled = YES;
        _messageImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.messageView addSubview:_messageImage];
    }
    return self;
}
- (void)configChatImageMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager{
    SIMImageElem *imageElem = (SIMImageElem *)message.elem;
    SIMImage *image = imageElem.imageList.firstObject;
    [_messageImage sd_setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:[UIImage imageNamed:@"im_chat_img_default"]];
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
