//
//  TBChatVC.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import "TBChatVC.h"
#import "TBChatBottomView.h"
#import "TBSendMessageModel.h"
#import "TBChatTextCell.h"
#import "TBChatMsgManager.h"
#import "TBSingleTxtCell.h"
#import "TBChatIMageCell.h"
#import "TBChatMsgPopMenu.h"
#import "TBChatVideoCell.h"
#import "TBChatMsgPreview.h"
#import <AVKit/AVKit.h>
#import <MJRefresh/MJRefresh.h>

@interface TBChatVC ()<UITableViewDelegate,UITableViewDataSource,TBIMChatMessageDelegate>

@property(nonatomic, strong)TBChatBottomView *bottomView;
@property(nonatomic, strong)UITableView *chatTable;
@property(nonatomic, strong)TBChatMsgManager *chatManager;
@property(nonatomic, strong)NSMutableArray <SIMMessage *>*dataSource;
@end

@implementation TBChatVC

- (id)initWithSession:(SIMSession *)session{
    self = [super init];
    if (self){
        if (!session){
            NSLog(@"session 不能为空");
            return nil;
        }
        self.currentSeeion = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerMessageObserver];
    [self initUI];
    [self reloadData:nil];
}
// 注册消息监听 注意注意⚠️⚠️⚠️只有这里监听注册过消息接收才能响应⚠️⚠️⚠️
- (void)registerMessageObserver{
    [[TBChatManager sharedInstanced] registerDelegate:self];
}
// 收到消息响应事件
- (void)messageDidReceived:(SIMMessage *)message{
    if (!message){
        return;
    }
    [self.dataSource addObject:message];
    [self.chatTable reloadData];
    [self scrollToBottom];
}
// 删除消息响应事件
- (void)messageDidDeleted:(SIMMessage *)message{
    
}
- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"聊天";
    self.chatTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        SIMMessage *message = self.dataSource.firstObject;
        [self reloadData:message.packetId];
    }];
    
    self.bottomView = [[TBChatBottomView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-80-BottomSafeHeight, UIScreenWidth, 80+BottomSafeHeight) defaultTxt:@"请输入内容"];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView configBottomActions:@[@"im_input_view_emoji",@"im_input_view_img",@"im_input_view_more"] highImgs:@[@"im_input_view_emoji_selected",@"im_input_view_img_selected",@"im_input_view_more_selected"]];
    
    @weakify(self);
    self.bottomView.sendMessage = ^(TBSendMessageModel * _Nonnull model) {
        @strongify(self);
        if (model.messageType == SIMMsgType_TXT){
            [self sendTxtMessage:model];
        }
        else if (model.messageType == SIMMsgType_IMAGE){
            [self sendImageMessage:model];
        }
        else if (model.messageType == SIMMsgType_VIDEO){
            [self sendVideoMessage:model];
        }
    };
    self.bottomView.frameChange = ^(CGFloat bh) {
        @strongify(self);
        self.chatTable.contentInset = UIEdgeInsetsMake(0, 0, bh, 0);
        if (self.dataSource.count > 0){
            [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    };
}
- (void)reloadData:(NSString *)fromMsgId{
    [[TBChatManager sharedInstanced] pullHistoryMsgsOfSession:self.currentSeeion.sessionId fromMsgId:fromMsgId completion:^(NSArray<SIMMessage *> * _Nonnull msgs, SIMError * _Nonnull error) {
        [self.chatTable.mj_header endRefreshing];
        if (error || !msgs){
            [MFToast showToast:@"消息拉取失败"];
            return;
        }
        if (self.dataSource.count == 0){
            [self.dataSource addObjectsFromArray:msgs];
        }
        else {
            NSMutableArray *tempArr = [[NSMutableArray alloc]initWithCapacity:0];
            [tempArr addObjectsFromArray:msgs];
            [tempArr addObjectsFromArray:self.dataSource];
            self.dataSource = tempArr;
        }
        if (self.dataSource.count == 0){
            return;
        }
        [self.chatTable reloadData];
        if (fromMsgId == nil){
            [self scrollToBottom];
        }
    }];
}
// 发送文本消息
- (void)sendTxtMessage:(TBSendMessageModel *)model{
    if ([model.message isEqualToString:@""]){
        return;
    }
    [[TBChatManager sharedInstanced] sendTextMessageTo:self.currentSeeion.sessionId text:model.message atArray:@[] completion:^(SIMMessage * _Nonnull msg, SIMError * _Nonnull error) {
        if (error){
            [MFToast showToast:@"消息发送失败"];
            return;
        }
        [self.dataSource addObject:msg];
        [self.chatTable reloadData];
        [self.bottomView clearMessageTxt];
        [self scrollToBottom];
    }];
}
// 发送图片消息 这里只是为了演示 链接固定 但是 真实使用需要 换成真正上传的图片的url
- (void)sendImageMessage:(TBSendMessageModel *)model{
    [[TBChatManager sharedInstanced] sendImageMessageTo:self.currentSeeion.sessionId url:@"https://bossfs.sammbo.com/0/1/head/yellowcat.png" isHD:YES completion:^(SIMMessage * _Nonnull msg, SIMError * _Nonnull error) {
        if (error){
            [MFToast showToast:@"消息发送失败"];
            return;
        }
        [self.dataSource addObject:msg];
        [self.chatTable reloadData];
        [self scrollToBottom];
    }];
}
// 发送视频消息
- (void)sendVideoMessage:(TBSendMessageModel *)model{
    NSString *videoPath = @"https://bossfs.sammbo.com/2/1/260392/2020/11/1604556149616.MOV";
    NSString *coverPath = @"https://bossfs.sammbo.com/2/1/260392/2020/11/1604556149509.jpg";
    [[TBChatManager sharedInstanced] sendVideoMessageTo:self.currentSeeion.sessionId url:videoPath coverUrl:coverPath completion:^(SIMMessage * _Nonnull msg, SIMError * _Nonnull error) {
        if (error){
            [MFToast showToast:@"消息发送失败"];
            return;
        }
        [self.dataSource addObject:msg];
        [self.chatTable reloadData];
        [self scrollToBottom];
    }];
}
// 删除消息
- (void)deleteMessage:(SIMMessage *)message{
    [[TBChatManager sharedInstanced] deleteMessage:message completion:^(SIMMessage * _Nonnull msg, SIMError * _Nonnull error) {
        if (error){
            [MFToast showToast:@"消息删除失败"];
            return;
        }
        [self.dataSource removeObject:message];
        [self.chatTable reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource.count){
        SIMMessage *message = self.dataSource[indexPath.row];
        TBChatBaseCell *cell;
        if (message.msgType == 0){
            NSString *iden = @"text_cell";
            cell = [tableView dequeueReusableCellWithIdentifier:iden];
            if (!cell){
                cell = [[TBChatTextCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
            }
            
            [(TBChatTextCell *)cell configChatTextMessage:self.currentSeeion chatMessage:message chatManager:self.chatManager];
        }
        else if (message.msgType == SIMMsgType_GROUP_CREATE){
            NSString *iden = @"single_text_cell";
            TBSingleTxtCell *singleCell = [tableView dequeueReusableCellWithIdentifier:iden];
            if (!singleCell){
                singleCell = [[TBSingleTxtCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
            }
            singleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [singleCell configTextMessage:self.currentSeeion chatMessage:message];
            return singleCell;
        }
        else if (message.msgType == SIMMsgType_IMAGE){
            NSString *iden = @"image_cell";
            cell = [tableView dequeueReusableCellWithIdentifier:iden];
            if (!cell){
                cell = [[TBChatIMageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
            }
            [(TBChatIMageCell *)cell configChatImageMessage:self.currentSeeion chatMessage:message chatManager:self.chatManager];
        }
        else if (message.msgType == SIMMsgType_VIDEO){
            NSString *iden = @"video_cell";
            cell = [tableView dequeueReusableCellWithIdentifier:iden];
            if (!cell){
                cell = [[TBChatVideoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
            }
            [(TBChatVideoCell *)cell configChatVideoMessage:self.currentSeeion chatMessage:message chatManager:self.chatManager];
        }
        else {
            cell = [[TBChatBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        @weakify(self);
        cell.cellGesture = ^(UIGestureRecognizer * _Nonnull ges, TBChatGestureType type) {
            @strongify(self);
            if(type == TBChatGestureLongPress){
                // 由于UIMenuControll的限制 注意 这里做了一层消息转发
                [[TBChatMsgPopMenu sharedMenu] tb_showWithTitles:@[@"删除"] inView:ges.view actionClick:^(TBChatPopMenuType type) {
                    @strongify(self);
                    if (type == TBChatPopMenuTypeDelete){
                        [self deleteMessage:message];
                    }
                }];
            }
            else if (type == TBChatGestureTap){
                if (message.msgType == SIMMsgType_IMAGE){
                    TBChatMsgPreview *preview = [[TBChatMsgPreview alloc]initWithFrame:CGRectZero];
                    [preview showImageWithMessages:@[message] inView:self.view];
                }
                else if(message.msgType == SIMMsgType_VIDEO){
                    SIMVideoElem *elem = (SIMVideoElem *)message.elem;
                    AVPlayerViewController *player = [[AVPlayerViewController alloc]init];
                    player.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:elem.videoUrl]];
                    [self.navigationController presentViewController:player animated:YES completion:^{

                    }];
                }
            }
            else if (type == TBChatGestureTwice){
                
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == NSSelectorFromString(@"tb_deleteMenuBtnClick:")){
        return YES;
    }
    return NO;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"tb_deleteMenuBtnClick:"]){
        return [TBChatMsgPopMenu sharedMenu];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource.count){
        SIMMessage *message = self.dataSource[indexPath.row];
        return [self.chatManager messageBodyHeight:message] + 22;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *fView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 1)];
    fView.backgroundColor = [UIColor whiteColor];
    return fView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *fView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 80)];
    fView.backgroundColor = [UIColor whiteColor];
    return fView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        return;
    }
    [self.bottomView inactiveBottomView];
}
- (void)scrollToBottom{
    if (self.dataSource.count == 0){
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    });
}
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataSource;
}
- (TBChatMsgManager *)chatManager{
    if (!_chatManager){
        _chatManager = [[TBChatMsgManager alloc]init];
    }
    return _chatManager;
}
- (UITableView *)chatTable{
    if (!_chatTable){
        _chatTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _chatTable.delegate = self;
        _chatTable.dataSource = self;
        _chatTable.backgroundColor = [UIColor whiteColor];
        _chatTable.showsVerticalScrollIndicator = NO;
        _chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_chatTable];
        [_chatTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _chatTable;
}
- (void)dealloc{
    NSLog(@"---TBChatVC dealloc");
    [[TBChatManager sharedInstanced] unRegisterDelegate:self];
}
@end
