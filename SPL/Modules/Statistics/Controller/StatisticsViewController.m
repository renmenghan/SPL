//
//  StatisticsViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "StatisticsViewController.h"
#import "PNChart.h"
#import "StatisticsRequest.h"

@interface StatisticsViewController ()
@property (nonatomic,strong) PNLineChart *lineChart;
@property (nonatomic,strong) PNBarChart *barChart;
@end

@implementation StatisticsViewController
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"" titleColor:[UIColor grayColor] selectedTitleColor:[UIColor redColor] icon:[UIImage imageNamed:@"dock_news"] selectedIcon:[UIImage imageNamed:@"dock_news_active"]];
//    }
//    return self;
//}
- (void)viewDidLoad {
    [self addNavigationBar];
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray(245);
    
    self.title = @"统计";
    
    [self initData];
    
}

- (void)render
{
    [self.view addSubview:self.lineChart];
    [self.view addSubview:self.barChart];
    [self.lineChart setAxisColor:Color_Gray(0)];
    [self.lineChart setShowCoordinateAxis:YES];
    self.lineChart.backgroundColor = Color_Gray(245);
    [self.lineChart setXUnit:@"day"];
    [self.lineChart setYUnit:@"km"];
}

- (void)initData
{
    [self loadData];
    
   
}

- (void)loadData
{
    
    
//    [self.lineChart.alpha];
    
    
    [StatisticsRequest getEveryDayDataWithParams:nil success:^(EveryDayResultModel *result) {
        
        if (result.everyData.count == 0) {
            [self showNotice:@"还没有数据哦"];
            return ;
        }

        [self render];
        
        NSMutableArray *xLabels = [NSMutableArray array];
        NSMutableArray *yValue = [NSMutableArray array];
        NSMutableArray *timeValue = [NSMutableArray array];

        for (EveryDayModel *model in result.everyData) {
            [xLabels addSafeObject:[model.time_date substringFromIndex:5]];
            [yValue addSafeObject:[NSString stringWithFormat:@"%.2f",[model.distance floatValue] / 1000]];
            [timeValue addSafeObject:[NSString stringWithFormat:@"%.2f",[model.time floatValue] / 60.0/60.00]];
            
        }
        [self.lineChart setXLabels:xLabels];
        NSArray * data01Array =yValue;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.itemCount = self.lineChart.xLabels.count;
        data01.getData = ^(NSUInteger index) {
            
            CGFloat yValue = [[data01Array safeObjectAtIndex:index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        self.lineChart.chartData = @[data01];
        [self.lineChart strokeChart];
        self.lineChart.showSmoothLines = YES;
        
        self.barChart.backgroundColor = Color_Gray(245);
        [self.barChart setXLabels:xLabels];
        [self.barChart setYLabelSuffix:@"h"];
        self.barChart.showChartBorder = YES;
        self.barChart.chartBorderColor = Color_Gray(0);
        self.barChart.labelTextColor = Color_Gray(0);
        [self.barChart setYValues:timeValue];
        self.barChart.isShowNumbers= NO;
        self.barChart.chartMarginBottom = 50;
        [self.barChart strokeChart];
        
        
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
    }];
    
}

- (PNLineChart *)lineChart
{
    if (!_lineChart) {
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, 200)];
        _lineChart.left = 25;
        _lineChart.top =  NAVBAR_HEIGHT + 50;
    }
    return _lineChart;
}

- (PNBarChart *)barChart
{
    if (!_barChart) {
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, 200)];
        _barChart.left = 25;
        _barChart.top = self.lineChart.bottom + 50;
    }
    return _barChart;
}
@end
