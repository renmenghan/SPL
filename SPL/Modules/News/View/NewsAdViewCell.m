//
//  NewsAdViewCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsAdViewCell.h"
#import "TTSliderView.h"
#import "NewsIndexHeadModel.h"
@interface NewsAdViewCell()<TTSliderViewDelegate>

@property (nonatomic,strong) TTSliderView *sliderView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation NewsAdViewCell

- (void)drawCell
{
}

- (void)reloadData
{
    if (self.cellData) {
        self.dataSource = self.cellData;
        [self cellAddSubView:self.self.sliderView];

    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 200;
    }
    return height;
}

#pragma mark -
- (TTSliderView *)sliderView
{
    if (!_sliderView) {
        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) withDelete:self];
        
    }
    
    return _sliderView;
}
#pragma mark -delegate
- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView
{
    return self.dataSource.count;
}
- (void)sliderImageView:(UIImageView *)image viewForItemAtIndex:(NSInteger)index
{
    NewsIndexHeadModel *model = [self.dataSource safeObjectAtIndex:index];
    [image setOnlineImage:model.image];
}
- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index
{
    NewsIndexHeadModel *model = [self.dataSource safeObjectAtIndex:index];
    [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"newsDetail?newsId=%@",model.id)];
}
@end
