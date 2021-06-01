//
//  TBChatFuncsView.m
//  SIMDemo
//
//  on 2021/1/27.
//

#import "TBChatFuncsView.h"

@interface TBChatFuncsView()

@property(nonatomic, strong)NSArray *funcTitles;
@property(nonatomic, strong)NSArray *funcImgs;
@end

@implementation TBChatFuncsView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configFuncs:(NSArray *)titles images:(NSArray *)imgs{
    if (titles.count != imgs.count || titles.count == 0){
        return;
    }
    self.funcImgs = imgs;
    self.funcTitles = titles;
    for (int i = 0; i < titles.count; i ++){
        NSString *titleStr = titles[i];
        NSString *imgStr = imgs[i];
        
        UIButton *funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat funcHW = (UIScreenWidth-120)/4.0;
        funcBtn.frame = CGRectMake(30+funcHW*i, 20+funcHW*(i/4), funcHW, funcHW);
        funcBtn.backgroundColor = [UIColor TB_colorForHex:0xF4F6F7];
        funcBtn.layer.cornerRadius = 12;
        funcBtn.clipsToBounds = YES;
        funcBtn.tag = 100000 + i;
        [funcBtn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:funcBtn];
        
        UIImageView *iconImg = [[UIImageView alloc]init];
        iconImg.image = [UIImage imageNamed:imgStr];
        [funcBtn addSubview:iconImg];
        
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@24);
            make.centerX.equalTo(funcBtn);
            make.centerY.equalTo(funcBtn).offset(-10);
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = titleStr;
        titleLab.textColor = [UIColor TB_colorForHex:0x8D8D8D];
        titleLab.font = Regular(12);
        titleLab.textAlignment = NSTextAlignmentCenter;
        [funcBtn addSubview:titleLab];
    
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(funcBtn);
            make.height.equalTo(@14);
            make.centerY.equalTo(funcBtn).offset(10);
        }];
    }
}
- (void)funcBtnClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100000;
    if (index >= self.funcTitles.count){
        return;
    }
    
    if (self.funcBtnClick){
        self.funcBtnClick(index, self.funcTitles[index]);
    }
}
@end
