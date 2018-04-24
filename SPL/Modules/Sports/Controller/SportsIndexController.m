//
//  SportsIndexController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "SportsIndexController.h"
#import "SportsTotalInfoView.h"
#import "StartView.h"
#import "SportsRequest.h"

@interface SportsIndexController ()<UIScrollViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIPageControl *pageCon;
@property (nonatomic,strong) SportsTotalInfoView *totalInfoView;
@property (nonatomic,strong) UIButton *rightButton;

@end

@implementation SportsIndexController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"" titleColor:[UIColor grayColor] selectedTitleColor:[UIColor redColor] icon:[UIImage imageNamed:@"dock_explore"] selectedIcon:[UIImage imageNamed:@"dock_explore_active"]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}
- (void)viewDidLoad {
    [self addNavigationBar];
    
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = Color_White;
    
    NSString *fontName = @"Noteworthy";
    CGFloat fontSize = 20;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"sports" attributes:@{
                                                                                                               NSForegroundColorAttributeName    :[UIColor blackColor],
                                                                                                               NSShadowAttributeName:
                                                                                                                   shadow,
                                                                                                               NSFontAttributeName:
                                                                                                                   [UIFont fontWithName:fontName size:fontSize]
                                                                                                               }];
    [self.navigationBar.titleLabel setAttributedText:att];
    
    self.navigationBar.rightBarButton = self.rightButton;
    
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self render];
    
//    [self initData];
    
}

//- (void)initData
//{
//    [self loadData];
//}

- (void)loadData
{
    [SportsRequest getSportsTotalDataWithParams:nil success:^(SportsTotaModel *totalModel) {
        self.totalInfoView.model = totalModel;
        
        [self.totalInfoView reloadData];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
    }];
}

- (void)render
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, self.view.height * 0.5);
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.width * 2, 0);
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScroll)]];
    self.scrollView.delegate = self;
    _totalInfoView= [[SportsTotalInfoView alloc] init];
    _totalInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollView.height);
    [self.scrollView addSubview:_totalInfoView];
    
    UIPageControl *pageCon = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    pageCon.numberOfPages = 2;
    pageCon.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.6];
    pageCon.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageCon.bottom = scrollView.bottom;
    self.pageCon = pageCon;
    [self.view addSubview:pageCon];
    // 目标公里部分页面布局
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 100, SCREEN_WIDTH, 30)];
    lb.text = @"目标公里";
    lb.textColor = Color_White;
    lb.backgroundColor = [UIColor clearColor];
    lb.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:lb];
    
    UITextField *targetDistance = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb.frame)+10, 150, 40)];
    targetDistance.layer.cornerRadius = 10;
    targetDistance.layer.masksToBounds = YES;
    targetDistance.keyboardType = UIKeyboardTypeNumberPad;
    targetDistance.textAlignment = NSTextAlignmentCenter;
    targetDistance.backgroundColor = Color_White;
    targetDistance.center = CGPointMake(SCREEN_WIDTH/2+SCREEN_WIDTH, targetDistance.center.y);
    [scrollView addSubview:targetDistance];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(targetDistance.frame)+5, targetDistance.top, 50, 40)];
    [scrollView addSubview:unit];
    unit.textAlignment = NSTextAlignmentLeft;
    unit.textColor = Color_White;
    unit.text = @"米";
    
    
#pragma mark - startUI
    StartView *startView = [[StartView alloc] init];
    startView.backgroundColor = [UIColor whiteColor];
    startView.contentMode = UIViewContentModeRedraw;
    startView.frame = CGRectMake(0, self.scrollView.bottom, self.view.width, self.view.height * 0.5);
    [self.view addSubview:startView];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(0, 0, 110, 110);
    startBtn.center = CGPointMake(self.view.width/2,KIsiPhoneX ?  self.view.height * 0.5 + 174 +15: self.view.height * 0.5 + 150 +15);
    startBtn.layer.cornerRadius = 55;
    startBtn.layer.masksToBounds = YES;
    //    [startBtn setTitle: GBLocalizedString(@"Start") forState:UIControlStateNormal];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Start" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Noteworthy" size:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [startBtn setAttributedTitle:str forState:UIControlStateNormal];
    startBtn.backgroundColor = [UIColor blackColor];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.startBtn = startBtn;
    
}





-(void)touchScroll
{
    [self.view endEditing:YES];
}

#pragma mark - action
- (void)startBtnClick
{
    [[TTNavigationService sharedService]openUrl:LOCALSCHEME(@"running")];
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageCon.currentPage = scrollView.contentOffset.x /  SCREEN_WIDTH;
}
#pragma mark -subview
- (UIButton *)rightButton
{
    if (!_rightButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        [button setTitle:@"统计" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton = button;
    }
    
    return _rightButton;
}

- (void)rightBtnClick
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"statistics")];
}

@end
