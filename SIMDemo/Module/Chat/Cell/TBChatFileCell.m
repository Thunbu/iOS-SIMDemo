//
//  TBChatFileCell.m
//  SIMDemo
//
//  on 2021/1/27.
//

#import "TBChatFileCell.h"

@interface TBChatFileCell()

@property(nonatomic, strong)UIImageView *fileImage;
@property(nonatomic, strong)UILabel *fileNameLab;
@property(nonatomic, strong)UILabel *fileSizeLab;
@end

@implementation TBChatFileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        // 60 高
    }
    return self;
}
- (void)configChatVideoMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager{
    SIMFileElem *fileElem = (SIMFileElem *)message.elem;
    if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
        self.messageView.frame = CGRectMake(UIScreenWidth - 200 - 18 - 40 - 10, 5, 200, [manager messageBodyHeight:message]);
    }
    else {
        self.messageView.frame = CGRectMake(18+40, 5, 200, [manager messageBodyHeight:message]);
    }
    self.fileImage.image = [UIImage imageNamed:@"diskDocument"];
    self.fileNameLab.text = fileElem.filename;
    //self.fileSizeLab.text = [NSString stringWithFormat:@"%d",fileElem.size];
    [self configHeaderImg:session chatMessage:message];
}
- (void)configBubble:(SIMSession *)session chatMessage:(SIMMessage *)message{
    UIImage *receiveImg = [[UIImage imageNamed:@"im_chat_qipao_receive_file"] stretchableImageWithLeftCapWidth:18 topCapHeight:21];
    UIImage *sendImg = [[UIImage imageNamed:@"im_chat_qipao_send_file"] stretchableImageWithLeftCapWidth:18 topCapHeight:21];
    if ([message.sender isEqualToString:[[TBChatManager sharedInstanced] currentUserId]]){
        self.bubbleImg.image = sendImg;
    }
    else {
        self.bubbleImg.image = receiveImg;
    }
    self.bubbleImg.frame = CGRectMake(0, 0, self.messageView.bounds.size.width, self.messageView.bounds.size.height);
}
- (UIImageView *)fileImage{
    if (!_fileImage){
        _fileImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"diskDocument"]];
        [self.messageView addSubview:_fileImage];
        [_fileImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.left.equalTo(@12);
            make.centerY.equalTo(self.messageView);
        }];
    }
    return _fileImage;
}

- (UILabel *)fileNameLab{
    if (!_fileNameLab){
        _fileNameLab = [[UILabel alloc]init];
        _fileNameLab.font = Regular(16);
        _fileNameLab.numberOfLines = 1;
        _fileNameLab.textColor = [UIColor TB_colorForHex:0x1D2221];
        [self.messageView addSubview:_fileNameLab];
        [_fileNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.fileImage.mas_right).offset(12);
            make.centerY.equalTo(self.messageView);
            make.right.equalTo(self.messageView).offset(-12);
            make.height.equalTo(@16);
        }];
    }
    return _fileNameLab;
}

- (UILabel *)fileSizeLab{
    if (!_fileSizeLab){
        _fileSizeLab = [[UILabel alloc] init];
        _fileSizeLab.font = Regular(12);
        _fileSizeLab.numberOfLines = 1;
        _fileSizeLab.textAlignment = NSTextAlignmentRight;
        _fileSizeLab.textColor = [UIColor TB_colorForHex:0x8D8D8D];
        [self.messageView addSubview:_fileSizeLab];
        
        [_fileSizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.messageView);
            make.right.equalTo(self.messageView).offset(-12);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
        }];
    }
    return _fileSizeLab;
}
@end
