//
//  TTSliderView.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/14.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSliderView;


@protocol TTSliderViewDelegate <NSObject>

@required
- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView;

- (void)sliderImageView:(UIImageView *)image viewForItemAtIndex:(NSInteger)index;

@optional
- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index;

@end


@interface TTSliderView : UIView


- (instancetype)initWithFrame:(CGRect)frame withDelete:(id)delegate;

@property (nonatomic,weak) id <TTSliderViewDelegate>delegate;


@end
