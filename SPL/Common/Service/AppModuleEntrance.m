//
//  AppModuleEntrance.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "AppModuleEntrance.h"
#import "TTNavigationController.h"
#import "ApplicationEntrance.h"
#import "NSURL+TT.h"
#import "TTNavigationService.h"
#import "LoginAnimationController.h"
#import "ChooseLoginController.h"
#import "LoginController.h"
#import "NewsDetailController.h"
#import "MineSettingViewController.h"
#import "RunningViewController.h"
#import "StatisticsViewController.h"

@implementation AppModuleEntrance
+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static AppModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[AppModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    [[TTNavigationService sharedService] registerModule:self withScheme:@"rmh" host:@"test"];
    [[TTNavigationService sharedService] registerModule:self withScheme:@"rmh" host:@"loginAnimation"];
     [[TTNavigationService sharedService] registerModule:self withScheme:@"rmh" host:@"chooseLogin"];
    [[TTNavigationService sharedService] registerModule:self withScheme:@"rmh" host:@"login"];
    [[TTNavigationService sharedService ]registerModule:self withScheme:@"rmh" host:@"newsDetail"];
    [[TTNavigationService sharedService ]registerModule:self withScheme:@"rmh" host:@"mineSetting"];
    [[TTNavigationService sharedService ]registerModule:self withScheme:@"rmh" host:@"running"];
     [[TTNavigationService sharedService ]registerModule:self withScheme:@"rmh" host:@"statistics"];

}

-(void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    
    if ([url.host isEqualToString:@"test"]) {
        
    }else if ([url.host isEqualToString:@"loginAnimation"]){
        LoginAnimationController *vc = [[LoginAnimationController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:@"chooseLogin"]){
        ChooseLoginController *vc = [[ChooseLoginController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:@"login"]){
        LoginController *vc = [[LoginController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"newsDetail"]){
        NewsDetailController *vc = [[NewsDetailController alloc] init];
        vc.newsId = urlParams[@"newsId"];
        [navigationController pushViewController:vc animated:YES];

    }else if ([url.host isEqualToString:@"mineSetting"]){
        
        MineSettingViewController *vc = [[MineSettingViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"running"]){
        RunningViewController *vc = [[RunningViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"statistics"]){
        StatisticsViewController *vc = [[StatisticsViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    
    
}
@end
