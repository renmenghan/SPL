//
//  NewsViewPagerController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsViewPagerController.h"
#import "NewsRequest.h"
#import "NewsViewController.h"
#import "VersionRequest.h"
#import "RMHAlertView.h"
@interface NewsViewPagerController ()

@end

@implementation NewsViewPagerController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"" titleColor:[UIColor grayColor] selectedTitleColor:[UIColor redColor] icon:[UIImage imageNamed:@"dock_home"] selectedIcon:[UIImage imageNamed:@"dock_home_active"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.isNav = YES;
    
    self.view.backgroundColor = Color_Gray245;
   
    NSString *fontName = @"Noteworthy";
    CGFloat fontSize = 20;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1];
    
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"SPL见闻" attributes:@{
                                                                                            NSForegroundColorAttributeName    :[UIColor whiteColor],
                                                                                                        NSShadowAttributeName:
                                                                                                            shadow,
                                                                                                        NSFontAttributeName:
                                                                                                            [UIFont fontWithName:fontName size:fontSize]
                                                                                                        }];
    
    [self.navigationBar.titleLabel setAttributedText:att];

    
//      self.title = @"SPL见闻";

    [self loadData];
    
    //[self setUpViewPage];
    [self checkVersion];
}

- (void)checkVersion
{
    [VersionRequest getVersionWithParams:nil success:^(VersionResultModel *model) {
       
        RMHAlertView *alert = [[RMHAlertView alloc] initWithTitle:@"提示" andImage:[UIImage imageNamed:@"dock_camera_down"] content:model.upgrade_point cancleButton:@"取消" otherButtons:@"过会提示",@"更新", nil];
        
        [alert show];
        
    } failure:^(StatusModel *status) {
        
    }];
}

-(void)loadData
{
    [NewsRequest getCatsWithParams:nil success:^(NewsCatsModel *list) {
        
        [self setUpViewPage:list.cats];
        
    } failure:^(StatusModel *status) {

        [self showNotice:status.msg];
    }];
}
- (void)setUpViewPage:(NSArray *)catList
{
    NSMutableArray *catNameArr = [NSMutableArray array];
    NSMutableArray *catVCArr = [NSMutableArray array];

    for (int i = 0; i<catList.count; i++) {
        NewsCatModel *catModel = [catList safeObjectAtIndex:i];
        [catNameArr addSafeObject:catModel.catname];
        
        NewsViewController *vc = [[NewsViewController alloc] init];
        vc.newsId = catModel.catid;
        [catVCArr addSafeObject:vc];
    }
    UIViewController *uv = [[UIViewController alloc] init];
    uv.view.backgroundColor = [UIColor redColor];
    UIViewController *uv1 = [[UIViewController alloc] init];
    uv1.view.backgroundColor = [UIColor blueColor];
    [self setUpWithItems:catNameArr childVCs:catVCArr];
    
    [self.viewPagerBar updateWithConfig:^(TTViewPagerConfig *config) {
        
        config.p_indicatorC(Color_Gray(0)).p_itemSelectC(Color_Gray(0));
        
    }];
}





@end
