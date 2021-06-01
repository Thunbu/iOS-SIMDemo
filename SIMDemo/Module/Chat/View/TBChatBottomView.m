//
//  TBChatBottomView.m
//  SIMDemo
//
//  on 2020/11/2.
//

#import "TBChatBottomView.h"
#import "TBSendMessageModel.h"
#import "TBEmojiKeyboardView.h"
#import "TBEmojiHelp.h"
#import <Photos/Photos.h>
#import "TBUploadManager.h"
#import "TBFileManager.h"
#import "TBChatFuncsView.h"
#import "TBCheckDocument.h"

@interface TBChatBottomView()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, strong)UITextView *messageTxt;
@property(nonatomic, strong)UILabel *placeholderLab;
@property(nonatomic, strong)UIButton *currentActiveBtn;
@property(nonatomic, assign)CGFloat bottomHeight; // 除去固定内容高度后 剩余的高度
@property(nonatomic, strong)TBEmojiKeyboardView *emojiView;
@property(nonatomic, strong)UIView *botContentView; // 承载 emojiView 等
@property(nonatomic, strong)TBChatFuncsView *chatFuncsView; // 多功能区
@property(nonatomic, assign)BOOL keyboardIsShow;
@end

@implementation TBChatBottomView

#pragma Public
- (id)initWithFrame:(CGRect)frame defaultTxt:(NSString *)dTxt{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.messageTxt];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}
- (void)inactiveBottomView{
    if (self.bottomHeight != 0){
        [self.messageTxt resignFirstResponder];
        [self changeBotContentStatus:0];
    }
}
- (void)clearMessageTxt{
    self.messageTxt.text = @"";
    self.placeholderLab.hidden = NO;
}
- (void)configBottomActions:(NSArray *)normalImgArr highImgs:(NSArray *)hImgArr{
    if (normalImgArr.count != hImgArr.count){
        return;
    }
    CGFloat distance = (UIScreenWidth-normalImgArr.count*40)/(normalImgArr.count+1);
    for (int i = 0; i < normalImgArr.count;i ++){
        NSString *nImg = normalImgArr[i];
        NSString *hImg = hImgArr[i];
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(distance*(i+1)+i*40, 40, 40, 40);
        [actionBtn setImage:[UIImage imageNamed:nImg] forState:UIControlStateNormal];
        [actionBtn setImage:[UIImage imageNamed:hImg] forState:UIControlStateSelected];
        [actionBtn addTarget:self action:@selector(bottomActionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        actionBtn.tag = 10000 + i;
        [self addSubview:actionBtn];
    }
}
#pragma Public
- (void)keyboardWillShow:(NSNotification *)noti{
    _keyboardIsShow = YES;
    CGRect keyboardFrame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self changeBotContentStatus:keyboardFrame.size.height];
    [self clearCurrentActionBtn];
}
- (void)keyboardWillHidden:(NSNotification *)noti{
    _keyboardIsShow = NO;
    [self changeBotContentStatus:0];
}
#pragma mark 底部按钮操作事件
- (void)bottomActionBtnClick:(UIButton *)sender{
    [self endEditing:YES];
    if (sender == _currentActiveBtn){
        [self clearCurrentActionBtn];
        [self changeBotContentStatus:0];
        return;
    }
    sender.selected = YES;
    _currentActiveBtn.selected = !sender.selected;
    _currentActiveBtn = sender;
    
    if (sender.tag == 10000){// 表情
        [self changeBotContentStatus:256];
        _botContentView = [[UIView alloc]init];
        [self addSubview:_botContentView];
        [_botContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).offset(80);
        }];
        _emojiView = [[TBEmojiKeyboardView alloc]init];
        [_botContentView addSubview:_emojiView];
        [_emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_botContentView);
        }];
        @weakify(self);
        _emojiView.insertEmojiBlock = ^(NSString * _Nonnull emojiTag) {
            @strongify(self);
            [self.messageTxt insertText:emojiTag];
        };
        _emojiView.deleteBackwardBlock = ^{
            @strongify(self);
            NSString *text = [TBEmojiHelp removeLastEmoji:self.messageTxt.text];
            self.messageTxt.text = text;
        };
        _emojiView.sendBlock = ^{
            @strongify(self);
            [self sendTextMessage];
        };
    }
    else if (sender.tag == 10001){// 图片
        [self changeBotContentStatus:0];
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){
                [self openAlubm];
            }
            else if (@available(iOS 14, *)) {
                if (status == PHAuthorizationStatusLimited){
                    [self openAlubm];
                }
            }
        }];
    }
    else if (sender.tag == 10002){// 加号
        [self changeBotContentStatus:256];
        
        _botContentView = [[UIView alloc]init];
        [self addSubview:_botContentView];
        [_botContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).offset(80);
        }];
        
        _chatFuncsView = [[TBChatFuncsView alloc]init];
        [_botContentView addSubview:_chatFuncsView];
        [_chatFuncsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_botContentView);
        }];
        
        [_chatFuncsView configFuncs:@[@"文件"] images:@[@"im_chat_input_file"]];
        @weakify(self);
        _chatFuncsView.funcBtnClick = ^(NSInteger index, NSString * _Nonnull title) {
            @strongify(self);
            if ([title isEqualToString:@"文件"]){
                [self openDocuments];
            }
        };
        
    }
}
#pragma mark 打开文件选择器
- (void)openDocuments{
    UIWindow *keyWin = [[UIApplication sharedApplication] keyWindow];
    [[TBCheckDocument shareCheck] showDocumentMenu:keyWin.rootViewController checkBlock:^(NSString * _Nonnull localPath) {
        [[TBUploadManager sharedInstance] uploadWithFilePath:localPath progress:^(NSString *key, float percent) {
            
        } complete:^(BOOL isOk, NSDictionary *dic) {
            if (isOk){
                NSString *remoteUrl = dic[@"url"];
                [self sendFileMessage:remoteUrl localPath:localPath];
            }
        }];
    }];
}
#pragma mark 打开相册
- (void)openAlubm{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = NO;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.image", @"public.movie",nil];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        UIWindow *keyWin = [[UIApplication sharedApplication] keyWindow];
        [keyWin.rootViewController presentViewController:imagePicker animated:YES completion:^{
            
        }];
    });
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]){
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        NSString *copiedFile = [[TBFileManager sharedInstance] getCopyFilePath:[NSString stringWithFormat:@"%@.jpg",[[TBFileManager sharedInstance] getDateStr]]];
        NSString *filePath = [[TBFileManager sharedInstance] copyToLocalWithData:data toPath:copiedFile];
        [[TBUploadManager sharedInstance] uploadWithFilePath:filePath progress:^(NSString *key, float percent) {

        } complete:^(BOOL isOk, NSDictionary *dic) {
            if (isOk){
                [self sendImageMessage:dic[@"url"] image:image data:data];
            }
            [[TBFileManager sharedInstance] deleteFileWithPath:filePath];
        }];
    }
    else if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.movie"]){
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *copiedFile = [[TBFileManager sharedInstance] getCopyFilePath:[NSString stringWithFormat:@"%@.mp4",[[TBFileManager sharedInstance] getDateStr]]];
        NSString *filePath = [[TBFileManager sharedInstance] copyToLocalWithData:data toPath:copiedFile];
        [[TBUploadManager sharedInstance] uploadWithFilePath:filePath progress:^(NSString *key, float percent) {
            
        } complete:^(BOOL isOk, NSDictionary *dic) {
            if (isOk){
                [self sendVideoMessage:dic[@"url"]];
            }
            [[TBFileManager sharedInstance] deleteFileWithPath:filePath];
        }];
        
    }
    [self clearCurrentActionBtn];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self clearCurrentActionBtn];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)clearCurrentActionBtn{
    _currentActiveBtn.selected = NO;
    _currentActiveBtn = nil;
}
/// 改变整个底部操作栏的方法 只需要传入高度就可以同时改变 UITableview 和 底部栏的显示
/// @param botH <#botH description#>
- (void)changeBotContentStatus:(CGFloat)botH{
    self.bottomHeight = botH;
    [self frameChanged];
    [_botContentView removeFromSuperview];
}
- (void)frameChanged{
    if (self.keyboardIsShow){
        self.frame = CGRectMake(0, UIScreenHeight-self.bottomHeight-80, UIScreenWidth, self.bottomHeight + 80);
    }
    else {
        self.frame = CGRectMake(0, UIScreenHeight-self.bottomHeight-80-BottomSafeHeight, UIScreenWidth, self.bottomHeight + 80 + BottomSafeHeight);
    }
    if (self.frameChange){
        self.frameChange(self.bottomHeight);
    }
}
#pragma mark 发送文本消息
- (void)sendTextMessage{
    if (self.sendMessage){
        TBSendMessageModel *model = [[TBSendMessageModel alloc]init];
        model.messageType = SIMMsgType_TXT;
        model.message = self.messageTxt.text;
        self.sendMessage(model);
    }
}
#pragma mark 发送图片消息
- (void)sendImageMessage:(NSString *)remoteUrl image:(UIImage *)img data:(NSData *)imgData{
    if (self.sendMessage){
        TBSendMessageModel *model = [[TBSendMessageModel alloc]init];
        model.messageType = SIMMsgType_IMAGE;
        model.urlPath = remoteUrl;
        model.imageData = imgData;
        model.upImage = img;
        self.sendMessage(model);
    }
}
#pragma mark 发送视频消息
- (void)sendVideoMessage:(NSString *)remoteUrl{
    if (self.sendMessage){
        TBSendMessageModel *model = [[TBSendMessageModel alloc]init];
        model.messageType = SIMMsgType_VIDEO;
        model.videPath = remoteUrl;
        model.coverPath = [NSString stringWithFormat:@"%@?vframe/jpg/offset/1",remoteUrl];
        self.sendMessage(model);
    }
}

#pragma mark 发送文件消息
- (void)sendFileMessage:(NSString *)remoteUrl localPath:(NSString *)lPath{
    if (_sendMessage){
        TBSendMessageModel *model = [[TBSendMessageModel alloc]init];
        model.messageType = SIMMsgType_FILE;
        model.fileSize = [[TBFileManager sharedInstance] sizeWithPath:lPath];
        model.fileRemoteUrl = remoteUrl;
        model.displayName = [lPath lastPathComponent];
        self.sendMessage(model);
        
        [[TBFileManager sharedInstance] deleteFileWithPath:lPath];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeholderLab.hidden = ![textView.text isEqualToString:@""];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self sendTextMessage];
        return NO;
    }
    return YES;
}
- (UITextView *)messageTxt{
    if (!_messageTxt){
        _messageTxt = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, UIScreenWidth-40, 40)];
        _messageTxt.font = [UIFont systemFontOfSize:16];
        _messageTxt.layer.cornerRadius = 4;
        _messageTxt.clipsToBounds = YES;
        _messageTxt.backgroundColor = [UIColor TB_colorForHex:0x000000 Alpha:0.05];
        _messageTxt.textColor = [UIColor TB_colorForHex:0x1D2221];
        _messageTxt.tintColor = [UIColor TB_colorForHex:0x27DFB0];
        _messageTxt.delegate = self;
        _messageTxt.returnKeyType = UIReturnKeySend;
        [_messageTxt addSubview:self.placeholderLab];
        
        [self addSubview:_messageTxt];
    }
    return _messageTxt;
}
- (UILabel *)placeholderLab{
    if (!_placeholderLab){
        _placeholderLab = [[UILabel alloc]initWithFrame:CGRectMake(6, 2, UIScreenWidth-40, 30)];
        _placeholderLab.font = [UIFont systemFontOfSize:16];
        _placeholderLab.textColor = [UIColor TB_colorForHex:0x8D8D8D];
        _placeholderLab.text = @"请输入内容";
    }
    return _placeholderLab;
}
- (void)dealloc{
    NSLog(@"--TBChatBottomView-dealloc--");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
