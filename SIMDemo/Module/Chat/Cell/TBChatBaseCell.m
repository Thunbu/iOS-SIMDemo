//
//  TBChatBaseCell.m
//  SIMDemo
//
//  on 2020/11/2.
//

#import "TBChatBaseCell.h"
#import "UIImageView+TBWebImage.h"

@interface TBChatBaseCell()

@property(nonatomic, strong)UIImageView *headerImg;

@end

@implementation TBChatBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 40, 40)];
        self.headerImg.layer.cornerRadius = 20;
        self.headerImg.clipsToBounds = YES;
        self.headerImg.image = [UIImage imageNamed:@"Friend_DefaultAvatar"];
        [self.contentView addSubview:self.headerImg];
        
        self.messageView = [[UIView alloc]init];
        self.messageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.messageView];
        
        self.bubbleImg = [[UIImageView alloc]init];
        self.bubbleImg.userInteractionEnabled = YES;
        [self.messageView addSubview:self.bubbleImg];
        
        [self addGesture];
        
    }
    return self;
}
- (void)configHeaderImg:(SIMSession *)session chatMessage:(SIMMessage *)message{
    if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
        self.headerImg.frame = CGRectMake(UIScreenWidth-40-12, 5, 40, 40);
        [self.headerImg tb_setImageWithUserId:[[TBChatManager sharedInstanced] currentUserId] placeholder:[UIImage imageNamed:@"Friend_DefaultAvatar"]];
    }
    else {
        self.headerImg.frame = CGRectMake(12, 5, 40, 40);
        [self.headerImg tb_setImageWithUserId:message.sender placeholder:[UIImage imageNamed:@"Friend_DefaultAvatar"]];
    }
    
    [self configBubble:session chatMessage:message];
}
// 如果不需要气泡 子类只需要重写这个方法
- (void)configBubble:(SIMSession *)session chatMessage:(SIMMessage *)message{
    UIImage *receiveImg = [[UIImage imageNamed:@"im_chat_qipao_receive_file"] stretchableImageWithLeftCapWidth:18 topCapHeight:21];
    UIImage *sendImg = [[UIImage imageNamed:@"im_chat_qipao_send"] stretchableImageWithLeftCapWidth:18 topCapHeight:21];
    if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
        self.bubbleImg.image = sendImg;
    }
    else {
        self.bubbleImg.image = receiveImg;
    }
    self.bubbleImg.frame = CGRectMake(0, 0, self.messageView.bounds.size.width, self.messageView.bounds.size.height);
}
// 如果不需要手势事件 只需要重写这个事件
- (void)addGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.messageView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *twiceGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twiceGesture:)];
    twiceGesture.numberOfTapsRequired = 2;
    [self.messageView addGestureRecognizer:twiceGesture];
    
    [tapGesture requireGestureRecognizerToFail:twiceGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [self.messageView addGestureRecognizer:longPressGesture];
}

- (void)tapGesture:(UITapGestureRecognizer *)ges{
    if (_cellGesture){
        _cellGesture(ges,TBChatGestureTap);
    }
}
- (void)twiceGesture:(UITapGestureRecognizer *)ges{
    if (_cellGesture){
        _cellGesture(ges,TBChatGestureTwice);
    }
}
- (void)longPressGesture:(UILongPressGestureRecognizer *)ges{
    if (_cellGesture){
        if (ges.state == UIGestureRecognizerStateBegan){
            _cellGesture(ges,TBChatGestureLongPress);
        }
    }
}
@end
