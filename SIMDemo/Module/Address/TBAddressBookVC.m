//
//  TBAddressBookVC.m
//  SIMDemo
//
//  on 2021/1/22.
//

#import "TBAddressBookVC.h"
#import "TBAddressCell.h"

@interface TBAddressBookVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *addressTable;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, strong)NSMutableArray *addressBookArr;
@property(nonatomic, assign)TBAddressBookType showType; // 判断当前是不是选择模式
@end

@implementation TBAddressBookVC

- (id)initWithType:(TBAddressBookType)type{
    self = [super init];
    if (self){
        self.showType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self initUI];
    [self reloadData];
}
- (void)reloadData{
    NSDictionary *subDic = @{@"page":@(_currentPage),@"rows":@"20"};
    [[SIMAddressBookManager shareManager] TB_UserAddressBook:subDic complection:^(id resultObject, NSError *error) {
        if (!error){
            TBBaseModel *baseModel = [TBBaseModel yy_modelWithDictionary:resultObject];
            if (baseModel.data && baseModel.data[@"list"]){
                NSArray *tempArr = [NSArray yy_modelArrayWithClass:[TBUserModel class] json:baseModel.data[@"list"]];
                [self.addressBookArr addObjectsFromArray:tempArr];
            }
            self.currentPage += 1;
        }
        [self.addressTable reloadData];
        [self.addressTable.mj_footer endRefreshing];
    }];
}

- (void)navSureBtnClick{
    if (!_sureBtnClick){
        return;
    }
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (TBUserModel *model in self.addressBookArr){
        if (model.isChecked){
            [tempArr addObject:model];
        }
    }
    
    if (tempArr.count == 0){
        return;
    }
    
    _sureBtnClick(tempArr);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    self.title = @"通讯录";
    self.addressTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self reloadData];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(navSureBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressBookArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iden = @"cell";
    TBAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell){
        cell = [[TBAddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    if (indexPath.row < self.addressBookArr.count){
        TBUserModel *userModel = self.addressBookArr[indexPath.row];
        if (self.showType == TBAddressBookTypeNormal){
            [cell configWithUser:userModel];
        }
        else {
            [cell configCheckWithUser:userModel];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TBUserModel *userModel = self.addressBookArr[indexPath.row];
    if (self.showType == TBAddressBookTypeCheck){
        userModel.isChecked = !userModel.isChecked;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (self.showType == TBAddressBookTypeNormal){
        self.tabBarController.selectedIndex = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TBCreateNewChat" object:userModel];
    }
}

- (UITableView *)addressTable{
    if (!_addressTable){
        _addressTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addressTable.delegate = self;
        _addressTable.dataSource = self;
        _addressTable.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_addressTable];
        [_addressTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _addressTable;
}
- (NSMutableArray *)addressBookArr{
    if (!_addressBookArr){
        _addressBookArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _addressBookArr;
}
@end
