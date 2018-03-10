//
//  BaseTableViewController.h
//  BaseUtilityExample
//
//  Created by 任梦晗 on 17/3/10.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,LodingType) {
    kInit = 0,
    kRefresh,
    KLoadMore,
};

@interface BaseTableViewController :BaseViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL showsPullToRefresh;
@property (nonatomic, assign) BOOL showsInfiniteScrolling;
@property (nonatomic,assign) LodingType lodingType;
@property(nonatomic, assign) BOOL hideNavigationBar;

- (void)addTableView;

- (void)showNoMoreDataNotice:(NSString *)text;

- (void)hideNoMoreDataNotice;

- (void)reloadData;

- (void)doRefresh;

- (void)doReload;

- (void)doLoadMore;

- (void)startRefresh;

- (void)finishRefresh;

- (void)finishLoadMore;

- (void)initData;

- (void)loadData;

- (void)normalDat;


@end
