//
//  TBAddressCell.m
//  SIMDemo
//
//  on 2021/1/22.
//

#import "TBAddressCell.h"

@interface TBAddressCell()

@property(nonatomic, strong)UIImageView *avatarImage;
@property(nonatomic, strong)UILabel *userNameLab;
@property(nonatomic, strong)UIImageView *checkImage;
@end

@implementation TBAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _avatarImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avatarImage.clipsToBounds = YES;
        _avatarImage.layer.cornerRadius = 20;
        [self.contentView addSubview:_avatarImage];
        [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(16);
            make.width.height.equalTo(@40);
        }];
        
        _userNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _userNameLab.textColor = [UIColor TB_colorForHex:0x1D2221];
        _userNameLab.font = Regular(16);
        [self.contentView addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_avatarImage.mas_right).offset(20);
            make.height.equalTo(@20);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-50);
        }];
        
        _checkImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_checkImage];
        [_checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@16);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
        lineView.backgroundColor = [UIColor TB_colorForHex:0xE6E6E6];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

- (void)configWithUser:(TBUserModel *)model{
    if (!model){
        return;
    }
    _userNameLab.text = model.userNickname;
    [_avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"Friend_DefaultAvatar"]];
    
}
- (void)configCheckWithUser:(TBUserModel *)model{
    if (!model){
        return;
    }
    [self configWithUser:model];
    if (model.isChecked){
        _checkImage.image = [UIImage imageNamed:@"selected"];
    }
    else {
        _checkImage.image = [UIImage imageNamed:@"unselected"];
    }
}
@end
