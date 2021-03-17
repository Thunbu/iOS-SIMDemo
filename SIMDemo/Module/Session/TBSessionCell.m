//
//  TBSessionCell.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/27.
//

#import "TBSessionCell.h"

@interface TBSessionCell ()

@property (nonatomic, strong) UIImageView *portraitImg;       //头像
@property (nonatomic, strong) UILabel *nameLabel;             //名字label
@property (nonatomic, strong) UILabel *contentLabel;          //内容label
@property (nonatomic, strong) UILabel *timeLabel;             //时间
@property (nonatomic, strong) UIImageView *topImageView;      //置顶图标
@property (nonatomic, strong) UIImageView *pushImgV;          //消息免打扰的图标

@end


@implementation TBSessionCell

- (void)setSession:(SIMSession *)session {
    [self.portraitImg sd_setImageWithURL:[NSURL URLWithString:session.avatar] placeholderImage:[UIImage imageNamed:@"Friend_DefaultAvatar"]];
    self.nameLabel.text = session.sessionName;
    self.timeLabel.text = [NSDate timeStringWithTimeInterval_Session:[NSString stringWithFormat:@"%lld", session.updateTimeStamp]];
    self.topImageView.hidden = !session.isTop;
    self.pushImgV.hidden = !session.isNoDisturb;
    
    NSString *msgText = @"";
    SIMMessage *msg = session.lastMessage;
    SIMElem *elem = msg.elem;
    //文本消息
    if (msg.msgType == SIMMsgType_TXT) {
        SIMTextElem *textElem = (SIMTextElem *)elem;
        msgText = textElem.text;
    }
    else if (msg.msgType == SIMMsgType_IMAGE) {
        msgText = @"图片";
    }
    else if (msg.msgType == SIMMsgType_VIDEO) {
        msgText = @"视频";
    }
    
    if (session.sessionType == SIMSessionType_GROUP && ![msg.sender isEqualToString:[SIMManager sharedInstance].loginParam.identifier]) {
        //群聊显示发送者
        msgText = [NSString stringWithFormat:@"%@：%@", msg.sender, msgText];
    }
    self.contentLabel.text = msgText;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor TB_colorForHex:0x3F4342 Alpha:0.08];
        [self initializationUI];
    }
    return self;
}

/**
 初始化ui
 */
- (void)initializationUI {
    UIImageView *portraitImg = [[UIImageView alloc] init];
    [portraitImg setContentMode:UIViewContentModeScaleAspectFill];
    self.portraitImg = portraitImg;
    [self.contentView addSubview:self.portraitImg];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor TB_colorForHex:0x000000];
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:self.nameLabel];

    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor TB_colorForHex:0x9A9E9E];
    contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel = contentLabel;
    [self.contentView addSubview:self.contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor TB_colorForHex:0x9A9E9E];
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel = timeLabel;
    [self.contentView addSubview:self.timeLabel];
    
    UIImageView *topImageView = [UIImageView new];
    topImageView.image = [UIImage imageNamed:@"Session_Top_Image"];
    topImageView.hidden = YES;
    self.topImageView = topImageView;
    [self.contentView addSubview:self.topImageView];
    
    UIImageView *pushImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodisturb"]];
    pushImgV.hidden = YES;
    self.pushImgV = pushImgV;
    [self.contentView addSubview:self.pushImgV];
    
    [self updateLayout];
}

/**
 更新约束
 */
- (void)updateLayout {
    [self.portraitImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(52);
    }];
    self.portraitImg.layer.cornerRadius = 52/2;
    self.portraitImg.layer.masksToBounds = YES;
    
    [self.nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImg.mas_right).offset(11);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(24);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pushImgV.mas_left);
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(21);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.height.mas_equalTo(18);
        make.width.mas_greaterThanOrEqualTo(34);
    }];
    //设置timeLabel约束优先级为高，这样会优先完整显示timeLabel，不会被nameLabel影响
    [self.timeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(14);
        make.top.mas_equalTo(4);
        make.right.mas_equalTo(-4);
    }];
    
    [self.pushImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentLabel);
        make.width.height.offset(12);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
