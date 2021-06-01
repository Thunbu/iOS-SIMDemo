//
//  TBSingleTxtCell.m
//  SIMDemo
//
//  on 2020/11/3.
//

#import "TBSingleTxtCell.h"

@interface TBSingleTxtCell()


@property(nonatomic,strong)UILabel *singleTxtLab;
@end

@implementation TBSingleTxtCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.singleTxtLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 40)];
        self.singleTxtLab.textColor = [UIColor TB_colorForHex:0xB6B6B6];
        self.singleTxtLab.font = [UIFont systemFontOfSize:13];
        self.singleTxtLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.singleTxtLab];
    }
    return self;
}
- (void)configTextMessage:(SIMSession *)session chatMessage:(SIMMessage *)message{
    if (message.msgType == SIMMsgType_GROUP_CREATE){
        self.singleTxtLab.text = @"创建群聊";
    }
}

@end
