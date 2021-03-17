//
//  TBSessionController.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/27.
//

#import "TBSessionController.h"
#import "TBSessionCell.h"
#import "TBSessionManager.h"
#import "TBGroupManager.h"
#import "TBChatVC.h"

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
    TBChatVC *chatVC = [[TBChatVC alloc]initWithSession:session];
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
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
    
    @weakify(self);
    MGSwipeButton * noDisturbBtn;
    if (session.isNoDisturb) {
        noDisturbBtn = [MGSwipeButton buttonWithTitle:@"打扰" icon:nil backgroundColor:[UIColor TB_colorForHex:0xFF6D5E] padding:25 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            // 取消免打扰
            [[TBSessionManager sharedInstanced] noDisturbSessionWithSessionid:session.sessionId isMute:NO succ:^{
                @strongify(self);
                session.isNoDisturb = NO;
                [self reloadTableView];
            } fail:^(SIMError * _Nonnull error) {
                    
            }];
            return YES;
        }];
    }
    else {
        noDisturbBtn = [MGSwipeButton buttonWithTitle:@"免打扰" icon:nil backgroundColor:[UIColor TB_colorForHex:0xFF6D5E] padding:25 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            // 免打扰
            [[TBSessionManager sharedInstanced] noDisturbSessionWithSessionid:session.sessionId isMute:YES succ:^{
                @strongify(self);
                session.isNoDisturb = YES;
                [self reloadTableView];
            } fail:^(SIMError * _Nonnull error) {
                    
            }];
            return YES;
        }];
    }
    
    if (session.isTop) {
        MGSwipeButton * cancelTopBtn = [MGSwipeButton buttonWithTitle:@"取消置顶" icon:nil backgroundColor:[UIColor TB_colorForHex:0xBBBEBE] padding:25 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            // 取消置顶
            [[TBSessionManager sharedInstanced] topSessionWithSessionid:session.sessionId isTop:NO succ:^{
                @strongify(self);
                session.isTop = NO;
                [self reloadTableView];
            } fail:^(SIMError * _Nonnull error) {
                
            }];
            return YES;
        }];
        return @[noDisturbBtn,cancelTopBtn];
    }
    else {
        MGSwipeButton * setTopBtn = [MGSwipeButton buttonWithTitle:@"置顶" icon:nil backgroundColor:[UIColor TB_colorForHex:0xBBBEBE] padding:25 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            // 置顶
            [[TBSessionManager sharedInstanced] topSessionWithSessionid:session.sessionId isTop:YES succ:^{
                @strongify(self);
                session.isTop = YES;
                [self reloadTableView];
            } fail:^(SIMError * _Nonnull error) {
                
            }];
            return YES;
        }];
        return @[noDisturbBtn,setTopBtn];
    }
}


#pragma mark - Action

- (void)creatGroup {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *groupName = [NSString stringWithFormat:@"群%.f", [[NSDate date] timeIntervalSince1970]*1000];
    [[TBGroupManager sharedInstanced] createGroup:groupName sessionIds:@[@"A_8589934611", @"A_8589934612", @"A_8589934613", @"A_8589934614", @"A_8589934616", @"A_8589934618"] succ:^(NSString * _Nonnull groupId) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SIMSession *session = [[SIMSession alloc] init];
        session.sessionType = SIMSessionType_GROUP;
        session.sessionId = groupId;
        session.sessionName = groupName;
        
        //服务器同步会话
        [[TBSessionManager sharedInstanced] getSessionInfo:groupId succ:^(SIMSession * _Nullable session) {
            
        } fail:^(SIMError * _Nullable error) {
            
        }];
    } fail:^(SIMError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"建群失败 %@", error);
    }];
}


#pragma mark - privite/public

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindViewModel];
}

- (void)bindViewModel {
    [self initializationParameters];
    [self initializationUI];
    
    [[SIMSessionManager sharedInstance] getSessionList:0 succ:^(NSArray<SIMSession *> * _Nonnull sessions) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sessionArray = [NSMutableArray arrayWithArray:sessions];
            [self reloadTableView];
        });
    } fail:^(SIMError * _Nonnull error) {
        
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发起群聊" style:UIBarButtonItemStylePlain target:self action:@selector(creatGroup)];
    self.navigationItem.rightBarButtonItem = item;

//    SIMSessionRequest * requset = [SIMSessionRequest new];
//    requset.sessionId = @"A_8589934618";
//    requset.sessionType = SIMSessionType_P2P;
//    requset.secType = SIMSecType_NORMAL;
//    [[SIMSessionManager sharedInstance] getSessionInfo:requset succ:^(SIMSession * _Nonnull session) {
//
//    } fail:^(SIMError * _Nonnull error) {
//
//    }];
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
        [[TBSessionManager sharedInstanced] getSessionInfo:sessionId succ:^(SIMSession * _Nonnull session) {
            [self.sessionArray insertObject:session atIndex:0];
            [self reloadTableView];
        } fail:^(SIMError * _Nonnull error) {
            
        }];
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
