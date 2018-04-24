//
//  MineViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineRequest.h"
#import "UserService.h"
#import "MineEditCell.h"
#import "LoginOutCell.h"
@interface MineViewController ()
@property (nonatomic,strong) MineHeaderView *headerView;
@property (nonatomic,strong) NSArray *menu;

@end

@implementation MineViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"" titleColor:[UIColor grayColor] selectedTitleColor:[UIColor redColor] icon:[UIImage imageNamed:@"dock_profile"] selectedIcon:[UIImage imageNamed:@"dock_profile_active"]];
    }
    return self;
}
- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = Color_Gray245;
//    self.tableView.top = STATUSBAR_HEIGHT;
//    self.tableView.height = SCREEN_HEIGHT - STATUSBAR_HEIGHT;
    
    [self render];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];

}

- (void)render
{

    [self.tableView setTableHeaderView:self.headerView];
 
}

- (void)initData
{
    [self loadData];
}

- (void)loadData
{
    [MineRequest getUserDataWithParams:nil success:^(UserInfoModel *user) {
        
        self.headerView.model = user;
        [self.headerView reloadData];
        
        [UserService sharedService].avatar = user.image;
        [UserService sharedService].name = user.username;
        [UserService sharedService].gender = user.sex;
        [UserService sharedService].signature = user.signature;
        [[UserService sharedService] saveLoginInfo];
        
        self.menu = @[
                      @{@"title":@"昵称",@"content":user.username,@"input":@""}
                      ,@{@"title":@"性别",@"content":@"sex",@"input":@""}
                      ,@{@"title":@"个性签名",@"content":user.signature,@"input":@""},
                      @{@"title":@"设置密码",@"content":@"",@"input":@""}];
        
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (MineHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    }
    return _headerView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    
    CGFloat imageHeight = self.headerView.frame.size.height;
    
    //图片宽度
    
    CGFloat imageWidth = SCREEN_WIDTH;
    
    //图片上下偏移量
    
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    
    //上移
    
    if (imageOffsetY < 0) {
        
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        
        CGFloat f = totalOffset / imageHeight;
        
        self.headerView.backImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menu.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section < self.menu.count) {
        if (row == 1) {
            NSDictionary *dic = [self.menu safeObjectAtIndex:section];
            MineEditCell *cell = [MineEditCell dequeueReusableCellForTableView:tableView];
            cell.cellData = dic;
            [cell reloadData];
            return cell;
        }
    }
    if (section == self.menu.count) {
        if (row == 1) {
            LoginOutCell *cell = [LoginOutCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
        }
    }
    
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if (section < self.menu.count) {
        if (row == 1) {
            height = [MineEditCell heightForCell:[self.menu safeObjectAtIndex:section]];
        }else if (row ==0){
            return 1;
        }
    }
    
    if (section == self.menu.count) {
        if (row == 0) {
            height = 40;
        }
        else {
            height = [LoginOutCell heightForCell:@" "];
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.menu.count) {
        
        [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"mineSetting")];
    }
}


@end
