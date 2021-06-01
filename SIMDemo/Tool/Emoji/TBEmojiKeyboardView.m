//
//  TBEmojiKeyboardView.m
//  SIMDemo
//
//  on 2020/11/4.
//

#import "TBEmojiKeyboardView.h"
#import "TBEmojiHelp.h"

@implementation TBEmojiKeyboardConfig


@end

/// emoji表情列表cell
@interface YelloManCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIImageView *emojiImgView;
@property(nonatomic, copy) void (^longPressBlock)(UILongPressGestureRecognizer *gesture);
@end

@implementation YelloManCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.emojiImgView];
        [self.emojiImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(0.65);
            make.height.equalTo(self.contentView).multipliedBy(0.65);
        }];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBtn:)];
        longPress.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longPress];
    }
    return self;
}
- (UIImageView *)emojiImgView {
    if (!_emojiImgView) {
        _emojiImgView = [UIImageView new];
        _emojiImgView.userInteractionEnabled = NO;
        _emojiImgView.contentMode = UIViewContentModeScaleAspectFill; //原图较小，需要不失真缩放
        _emojiImgView.clipsToBounds = YES;
    }
    return _emojiImgView;
}
- (void)longPressBtn:(UILongPressGestureRecognizer *)gesture {
    self.longPressBlock ? self.longPressBlock(gesture) : nil;
}
@end

@interface TBEmojiKeyboardView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UIButton *deleteBtn;
@property(nonatomic, strong)UIButton *sendBtn;
@property(nonatomic, strong) NSMutableArray<TBEmojiKeyboardConfig *> *emojiDataSource; // emoji数据源

@end

@implementation TBEmojiKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self reloadData];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.deleteBtn];
    [self addSubview:self.sendBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.right.equalTo(self).offset(-60);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
    }];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.left.mas_equalTo(_deleteBtn.mas_right);
        make.bottom.equalTo(self.deleteBtn);
    }];
}
- (void)reloadData{
    self.emojiDataSource = [NSMutableArray new];

    // 小黄人emoji
    TBEmojiKeyboardConfig *yelloManEmoji = [TBEmojiKeyboardConfig new];
    yelloManEmoji.type = TBEmojiHelpTypeWithYelloMan;
    yelloManEmoji.width = 50.0;
    yelloManEmoji.height = 50.0;
    if (UIScreenWidth < 375) {
        yelloManEmoji.VMax = 6;
    } else if (UIScreenWidth < 414) {
        yelloManEmoji.VMax = 7;
    } else {
        yelloManEmoji.VMax = 8;
    }
    yelloManEmoji.canDelete = YES;
    yelloManEmoji.marginLeft = (UIScreenWidth - yelloManEmoji.width * yelloManEmoji.VMax) / 2.0;
    yelloManEmoji.marginHSpace = 0;
    yelloManEmoji.marginVSpace = 0;
    yelloManEmoji.scaleForBtn = 0.7;

    // 自定义表情
    TBEmojiKeyboardConfig *customEmoji = [TBEmojiKeyboardConfig new];
    customEmoji.type = TBEmojiHelpTypeWithCustomGif;
    customEmoji.width = 60.5;
    customEmoji.height = 60.5;
    customEmoji.VMax = 5;
    customEmoji.canDelete = NO;
    customEmoji.marginLeft = (UIScreenWidth - customEmoji.width * customEmoji.VMax) / (customEmoji.VMax + 1);
    customEmoji.marginHSpace = customEmoji.marginLeft;
    customEmoji.marginVSpace = 10;
    customEmoji.scaleForBtn = 0.9;
    customEmoji.marginTop = 12;

    [self.emojiDataSource removeAllObjects];
    [self.emojiDataSource addObject:yelloManEmoji];

    //计算数量
    for (TBEmojiKeyboardConfig *config in self.emojiDataSource) {
        config.count = [TBEmojiHelp pullEmojiCountWithType:config.type];
    }
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TBEmojiKeyboardConfig *config = self.emojiDataSource.firstObject;
    return config.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    TBEmojiKeyboardConfig *config = self.emojiDataSource[0];
    UIImage *image = [TBEmojiHelp pullImgWithIndex:index type:config.type];
    //NSString *name = [TBEmojiHelp pullChineseNameWithIndex:index type:config.type];

    YelloManCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YelloManCell" forIndexPath:indexPath];
    cell.emojiImgView.image = image;
    @weakify(self);
    cell.longPressBlock = ^(UILongPressGestureRecognizer *gesture) {
        @strongify(self);
        if (!self) {
            return;
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    NSString *emojiTag = [NSString stringWithFormat:@"[%@]",[TBEmojiHelp pullChineseNameWithIndex:index type:TBEmojiHelpTypeWithYelloMan]];
    self.insertEmojiBlock ? self.insertEmojiBlock(emojiTag) : nil;
}

// 删除回调
- (void)deleteAction:(UIButton *)sender {
    self.deleteBackwardBlock ? self.deleteBackwardBlock() : nil;
}

// 发送
- (void)sendAction:(UIButton *)sender {
    self.sendBlock ? self.sendBlock() : nil;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"IMChat_DeleteEmoji_UnSelected"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"IMChat_DeleteEmoji"] forState:UIControlStateSelected];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitleColor:[UIColor TB_colorForHex:0x1D2221] forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[UIColor TB_colorForHex:0x7BF8D8]];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:Regular(16)];
        [_sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.headerReferenceSize = CGSizeMake(UIScreenWidth, 12);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(8, 0, UIScreenWidth-16, 216) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YelloManCell class] forCellWithReuseIdentifier:@"YelloManCell"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
@end
