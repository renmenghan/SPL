//
//  NewsViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsRequest.h"
#import "NewListCell.h"
#import "NewsIndexHeadModel.h"
#import "NewsAdViewCell.h"
@interface NewsViewController ()

@property (nonatomic,assign) int totalPage;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSArray *headerArray;
@end

@implementation NewsViewController

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)viewDidLoad {
    self.hideNavigationBar = YES;

    [super viewDidLoad];
    
    self.tableView.top = 0;
    
    self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT -TABBAR_HEIGHT;
    
    self.showsPullToRefresh = YES;
    
    self.showsInfiniteScrolling = YES;
    
    [self initData];
    
}

- (void)initData
{
    self.lodingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.newsId forKey:@"catid"];
    if (self.lodingType == KLoadMore) {
        
        self.page = self.page + 1;
        [params setSafeObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
        [NewsRequest getNewsListWithParams:params success:^(NewListResultModel *resultModel) {
            self.totalPage = resultModel.page_num;
            [self.listArray addObjectsFromSafeArray:resultModel.list];
            [self finishLoadMore];
            [self reloadData];
            if (self.page == self.totalPage) {
                [self showNoMoreDataNotice:@"没有更多数据了"];
            }else{
                [self hideNoMoreDataNotice];
            }
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            [self finishLoadMore];

        }];
        
    }else{
        self.page = 1;
        [params setSafeObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
        [NewsRequest getNewsListWithParams:params success:^(NewListResultModel *resultModel) {
            
            self.totalPage = resultModel.page_num;
            self.headerArray = resultModel.heads;
            self.listArray = (NSMutableArray *)resultModel.list;
            [self finishRefresh];
            [self reloadData];
            if (self.page == self.totalPage) {
                [self showNoMoreDataNotice:@"没有更多数据了"];
            }else{
                [self hideNoMoreDataNotice];
            }
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];

        }];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return  self.listArray.count;
    }
    else if (section == 0){
        return 1;
    }
    return  0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 1) {
        NewListCell *cell = [NewListCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.listArray safeObjectAtIndex:row];
        [cell reloadData];
        return cell;
    }else if (section == 0){
        NewsAdViewCell *cell = [NewsAdViewCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.headerArray;
        [cell reloadData];
        return cell;
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
    
    if (section == 1) {
        height = [NewListCell heightForCell:[self.listArray safeObjectAtIndex:row]];
    }else if (section == 0){
        height = [NewsAdViewCell heightForCell:self.headerArray];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NewListModel *model = [self.listArray safeObjectAtIndex:indexPath.row];
        [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"newsDetail?newsId=%@",model.id)];
    }
}


@end
