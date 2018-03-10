//
//  StartView.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "StartView.h"

@implementation StartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = Color_White;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    CGFloat x1 = self.width/2-50-10;
    CGFloat x2 = self.width/2+50+10;
    
    [path addLineToPoint:CGPointMake(x1, 100)];
    
    [path addLineToPoint:CGPointMake(x2, 100)];
    
    [path addLineToPoint:CGPointMake(self.width, 0)];
    
    [path addLineToPoint:CGPointMake(0, 0)];
    
    [[UIColor whiteColor]set];
    
    [[UIColor blackColor]setFill];
    [path stroke];
    [path fill];
    
    CGPoint center = CGPointMake(self.width/2, 100);
    UIBezierPath *path2= [UIBezierPath bezierPathWithArcCenter:center radius:60 startAngle:0 endAngle:M_PI clockwise:NO];
    [[UIColor whiteColor]set];
    
    [path2 stroke];
    [path2 fill];
    
    
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(0, 0)];
    [path3 addLineToPoint:CGPointMake(self.width, 0)];
    [[UIColor blackColor]set];
    [path3 stroke];
    [path3 fill];
    //
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [[UIColor whiteColor]set];
    [path4 moveToPoint:CGPointMake(x1, 100)];
    [path4 addLineToPoint:CGPointMake(x2, 100)];
    [path4 stroke];
}

@end
