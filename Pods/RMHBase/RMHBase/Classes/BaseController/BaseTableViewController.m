//
//  BaseTableViewController.m
//  BaseUtilityExample
//
//  Created by 任梦晗 on 17/3/10.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"
#import "BaseTableViewCell.h"
#import "Macros.h"
#import "UIView+TT.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTableView];
    
    if (IS_IOS11) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)addTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.hideNavigationBar?0:NAVBAR_HEIGHT, self.view.frame.size.width, self.hideNavigationBar?[UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.height - NAVBAR_HEIGHT) style:UITableViewStylePlain];
    NSLog(@"------%f",self.tableView.top);
    // 下拉
    self.tableView.delegate = self;
    // 上拉
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)setShowsPullToRefresh:(BOOL)showsPullToRefresh
{
    _showsPullToRefresh = showsPullToRefresh;
    if (showsPullToRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doRefresh)];
    }
    
}

- (void)setShowsInfiniteScrolling:(BOOL)showsInfiniteScrolling
{
    _showsInfiniteScrolling = showsInfiniteScrolling;
    if (showsInfiniteScrolling) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doLoadMore)];
    }else {
        [self.tableView.mj_footer removeFromSuperview];
    }
}

- (void)showNoMoreDataNotice:(NSString *)text
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)hideNoMoreDataNotice
{
    [self.tableView.mj_footer resetNoMoreData];
}
- (void)doRefresh
{
//    [super doRefresh];
    self.lodingType = kRefresh;
    [self loadData];
    
}

- (void)doLoadMore
{
//    [super doLoadMore];
    self.lodingType = KLoadMore;
    [self loadData];
}

- (void)startRefresh
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)finishRefresh
{
    [self.tableView.mj_header endRefreshing];
}

- (void)finishLoadMore
{
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

- (void)doReload
{
    
}

- (void)initData
{
    
}
-(void)loadData
{
    
}
@end
