//
//  TBSessionController.m
//  SIMDemo
//
//  on 2020/10/27.
//

#import "TBSessionController.h"
#import "TBSessionCell.h"
#import "TBSessionManager.h"
#import "TBGroupManager.h"
#import "TBChatVC.h"
#import "TBPreLoginVC.h"
#import "TBUploadManager.h"
#import "TBAddressBookVC.h"


@interface TBSessionController ()<MGSwipeTableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<SIMSession *> *sessionArray;     //会话列表数据源

@end


@implementation TBSessionController


#pragma mark - UITableViewDataSource和UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sessionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBSessionCell"];
    if (!cell) {
        cell = [[TBSessionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TBSessionCell"];
        cell.delegate = self;
        cell.touchOnDismissSwipe = YES;
    }
    if (self.sessionArray.count > indexPath.row) { //修复数组越界奔溃
        SIMSession *session = self.sessionArray[indexPath.row];
        [cell setSession:session];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row > self.sessionArray.count - 1) {
        return;
    }
    SIMSession *session = self.sessionArray[indexPath.row];
    [self jumpChatVC:session];
}

- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell canSwipe:(MGSwipeDirection)direction {
    if (direction == MGSwipeDirectionRightToLeft) {
        return YES;
    }
    return NO;
}

- (BOOL)swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion {
    return YES;
}

- (NSArray*)swipeTableCell:(MGSwipeTableCell*)cell swipeButtonsForDirection:(MGSwipeDirection)direction swipeSettings:(MGSwipeSettings*)swipeSettings expansionSettings:(MGSwipeExpansionSettings*)expansionSettings {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SIMSession * session = self.sessionArray[indexPath.row];
    cell.rightSwipeSettings.hideAnimation.duration = 0.4f;
    
    NSString *isDisturbStr = session.isNoDisturb ? @"打扰" : @"免打扰";
    MGSwipeButton * isDisturbBtn = [MGSwipeButton buttonWithTitle:isDisturbStr icon:nil backgroundColor:[UIColor TB_colorForHex:0xFACE3E] padding:0 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        [[TBSessionManager sharedInstanced] noDisturbSessionWithSessionid:session.sessionId isMute:!session.isNoDisturb succ:^{
            session.isNoDisturb = !session.isNoDisturb;
            [self reloadTableView];
        } fail:^(SIMError * _Nonnull error) {
            
        }];
        return YES;
    }];
    isDisturbBtn.buttonWidth = 75;
    isDisturbBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    NSString *isTopStr = session.isTop ? @"取消置顶" : @"置顶";
    MGSwipeButton *isTopBtn = [MGSwipeButton buttonWithTitle:isTopStr icon:nil backgroundColor:[UIColor TB_colorForHex:0xB6B6B6] padding:0 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        [[TBSessionManager sharedInstanced] topSessionWithSessionid:session.sessionId isTop:!session.isTop succ:^{
            session.isTop = !session.isTop;
            [self reloadTableView];
        } fail:^(SIMError * _Nonnull error) {
            
        }];
        return YES;
    }];
    isTopBtn.buttonWidth = 75;
    isTopBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    NSString *deleteStr = @"删除";
    MGSwipeButton *deleteBtn = [MGSwipeButton buttonWithTitle:deleteStr icon:nil backgroundColor:[UIColor TB_colorForHex:0xFF6D5E] padding:0 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        [self deleteSession:session];
        return YES;
    }];
    deleteBtn.buttonWidth = 75;
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    return @[deleteBtn,isDisturbBtn,isTopBtn];
}

// 删除会话
- (void)deleteSession:(SIMSession *)session{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[TBSessionManager sharedInstanced] delSession:session succ:^{
            [self.sessionArray removeObject:session];
            [self.tableView reloadData];
        } fail:^(SIMError * _Nullable error) {
            
        }];
    }];
    [alertVC addAction:cancleAction];
    [alertVC addAction:sureAction];
    [self.navigationController presentViewController:alertVC animated:YES completion:^{
        
    }];
}
#pragma mark - Action

- (void)jumpChatVC:(SIMSession *)session{
    TBChatVC *chatVC = [[TBChatVC alloc]initWithSession:session];
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)creatGroup {
    TBAddressBookVC *addressVC = [[TBAddressBookVC alloc]initWithType:TBAddressBookTypeCheck];
    addressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressVC animated:YES];
    
    addressVC.sureBtnClick = ^(NSMutableArray * _Nonnull checkArr) {
        [self createGroupWithUsers:checkArr];
    };
    
}

- (void)createSingleChat:(TBUserModel *)model{
    
    SIMSession *jumpSession = nil;
    for (SIMSession *session in self.sessionArray){
        if ([session.sessionId isEqualToString:model.account]){
            jumpSession = session;
        }
    }
    
    if (jumpSession){
        [self jumpChatVC:jumpSession];
        return;
    }
    
    SIMSessionRequest *request = [[SIMSessionRequest alloc]init];
    request.sessionId = model.account;
    request.sessionType = SIMSessionType_P2P;
    request.secType = SIMSecType_NORMAL;
    [[SIMSessionManager sharedInstance] getSessionInfo:request succ:^(SIMSession * _Nonnull session) {
        [self jumpChatVC:session];
        session.avatar = model.avatar;
        if (self.sessionArray.count == 0){
            [self.sessionArray addObject:session];
        }
        else {
            [self.sessionArray insertObject:session atIndex:0];
        }
        [self.tableView reloadData];
    } fail:^(SIMError * _Nullable error) {
        NSLog(@"---createSingleChat----%@",error);
    }];
}

- (void)createGroupWithUsers:(NSMutableArray<TBUserModel *> *)users{
    if (users.count == 1){
        [self createSingleChat:users[0]];
    }
    else {
        NSMutableString *groupName = [[NSMutableString alloc]initWithString:@""];
        NSMutableArray *userIds = [[NSMutableArray alloc]initWithCapacity:0];
        for (TBUserModel *model in users){
            [userIds addObject:model.account];
            if ([groupName isEqualToString:@""]){
                [groupName appendString:model.userNickname];
            }
            else {
                [groupName appendString:[NSString stringWithFormat:@",%@",model.userNickname]];
            }
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[TBGroupManager sharedInstanced] createGroup:groupName sessionIds:userIds succ:^(NSString * _Nonnull groupId) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } fail:^(SIMError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
}
- (void)loginOutSdk{
    [[SIMManager sharedInstance] logout:^{
        UINavigationController *loginNav= [[UINavigationController alloc]initWithRootViewController:[TBPreLoginVC new]];
        [UIApplication sharedApplication].keyWindow.rootViewController = loginNav;
    } fail:^(SIMError * _Nullable error) {
        
    }];
    
}

#pragma mark - privite/public

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendNewMessage:) name:@"TBSendNewMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNewChat:) name:@"TBCreateNewChat" object:nil];
    
    [self bindViewModel];
    [self qiNiuPolicy];
    
}

- (void)sendNewMessage:(NSNotification *)noti{
    SIMMessage *message = (SIMMessage *)noti.object;
    if (message && [message isKindOfClass:[message class]]){
        for (SIMSession *session in self.sessionArray){
            if ([session.sessionId isEqualToString:message.getSessionId]){
                session.lastMessage = message;
                [self.tableView reloadData];
                break;
            }
        }
    }
}

- (void)createNewChat:(NSNotification *)noti{
    TBUserModel *userModel = noti.object;
    if (userModel && [userModel isKindOfClass:[TBUserModel class]]){
        [self createSingleChat:userModel];
    }
}

- (void)qiNiuPolicy{
    [[SIMManager sharedInstance] SIM_uploadPolocy:^(id  _Nonnull data) {
        NSDictionary *dic = (NSDictionary *)data;
        if (dic[@"SecurityToken"] && dic[@"SecurityDomain"]){
            [[TBUploadManager sharedInstance] configQiNiuUploadPolicy:dic[@"SecurityDomain"] token:dic[@"SecurityToken"]];
        }
    } fail:^(SIMError * _Nullable error) {
        
    }];
}

- (void)bindViewModel {
    [self initializationParameters];
    [self initializationUI];
    
    [self reloadData];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发起群聊" style:UIBarButtonItemStylePlain target:self action:@selector(creatGroup)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *loginOutItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginOutSdk)];
    self.navigationItem.leftBarButtonItem = loginOutItem;

}

- (void)reloadData{
    [[SIMSessionManager sharedInstance] getSessionList:0 succ:^(NSArray<SIMSession *> * _Nonnull sessions) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sessionArray = [NSMutableArray arrayWithArray:sessions];
            [self reloadTableView];
        });
    } fail:^(SIMError * _Nonnull error) {
        
    }];
}

- (void)initializationUI {
    self.navigationItem.title = @"消息";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发起群聊" style:UIBarButtonItemStylePlain target:self action:@selector(creatGroup)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
}

- (void)initializationParameters {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMessage:) name:@"onReceivedMessage" object:nil];
}

- (void)reloadTableView {
    NSMutableArray *temps = [self.sessionArray mutableCopy];
    __block NSMutableArray *topArray = [NSMutableArray new];
    [temps enumerateObjectsUsingBlock:^(SIMSession * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isTop) {
            [topArray addObject:obj];
        }
    }];
    [temps removeObjectsInArray:topArray];
    
    NSArray *tops = [topArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[NSNumber numberWithLong:((SIMSession *) obj2).updateTimeStamp] compare:[NSNumber numberWithLong:((SIMSession *) obj1).updateTimeStamp]];
    }];
    NSArray *noTops = [temps sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[NSNumber numberWithLong:((SIMSession *) obj2).updateTimeStamp] compare:[NSNumber numberWithLong:((SIMSession *) obj1).updateTimeStamp]];
    }];
    [self.sessionArray removeAllObjects];
    [self.sessionArray addObjectsFromArray:tops];
    [self.sessionArray addObjectsFromArray:noTops];
    
    [self.tableView reloadData];
}

- (void)receivedMessage:(NSNotification *)notification {
    SIMMessage *msg = (SIMMessage *)(notification.object);
    NSString *sessionId = [msg getSessionId];
    __block BOOL contains = NO;
    [self.sessionArray enumerateObjectsUsingBlock:^(SIMSession * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.sessionId isEqualToString:sessionId]) {
            obj.lastMessage = msg;
            obj.updateTimeStamp = msg.time;
            contains = YES;
            *stop = YES;
        }
    }];
    if (contains) {
        [self reloadTableView];
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - set/get -- 懒加载
- (NSMutableArray *)sessionArray{
    if (!_sessionArray) {
        _sessionArray = [[NSMutableArray alloc] init];
    }
    return _sessionArray;
}

@end
