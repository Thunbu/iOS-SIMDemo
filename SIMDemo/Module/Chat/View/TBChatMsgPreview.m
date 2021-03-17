//
//  TBChatMsgPreview.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/5.
//

#import "TBChatMsgPreview.h"

@interface TBChatMsgPreview()

@property(nonatomic, strong)UIImageView *preImage;
@end

@implementation TBChatMsgPreview

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor blackColor];
        self.preImage = [[UIImageView alloc]init];
        self.preImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.preImage];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}
- (void)showImageWithMessages:(NSArray<SIMMessage *> *)msgs inView:(nonnull UIView *)view{
    if (msgs.count == 0 || !msgs){
        return;
    }
    SIMMessage *message = msgs.firstObject;
    if (!message){
        return;
    }
    SIMImageElem *imageElem = (SIMImageElem *)message.elem;
    SIMImage *image = imageElem.imageList.firstObject;
    if (!image || !image.url){
        return;
    }
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    double proportion = image.width/UIScreenWidth;
    if (proportion < 1 || proportion == 0){
        proportion = 1;
    }
    CGFloat height = image.height/proportion;
    [self.preImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(UIScreenWidth));
        make.height.equalTo(@(height));
    }];
    [self.preImage sd_setImageWithURL:[NSURL URLWithString:image.url]];
}
- (void)tapGesture:(UIGestureRecognizer *)ges{
    [self removeFromSuperview];
}
@end
