//
//  TBChatMsgPopMenu.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/5.
//

#import "TBChatMsgPopMenu.h"

@interface TBChatMsgPopMenu()

@property(nonatomic, copy)void(^actionClick)(TBChatPopMenuType);
@end

@implementation TBChatMsgPopMenu

+ (instancetype)sharedMenu{
    static TBChatMsgPopMenu *popMenu;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popMenu = [[TBChatMsgPopMenu alloc]init];
    });
    return popMenu;
}
- (void)tb_showWithTitles:(NSArray <NSString *>*)menus inView:(UIView *)view actionClick:(void(^)(TBChatPopMenuType))action{
    self.actionClick = action;
    [self tb_showMenu:view titles:menus];
}
- (void)tb_showMenu:(UIView *)inView titles:(NSArray *)menus{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    NSMutableArray *menusArr = [[NSMutableArray alloc]initWithCapacity:menus.count];
    [menus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:obj action:@selector(tb_deleteMenuBtnClick:)];
        [menusArr addObject:deleteItem];
    }];
    
    menuController.menuItems = menusArr;
    [menuController setTargetRect:inView.frame inView:inView.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    [UIMenuController sharedMenuController].menuItems=nil;
}
- (void)tb_deleteMenuBtnClick:(id)sender{
    if(self.actionClick){
        self.actionClick(TBChatPopMenuTypeDelete);
    }
}
@end
