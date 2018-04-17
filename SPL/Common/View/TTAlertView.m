//
//  RMHAlertView.m
//  SprotsLife
//
//  Created by liangqi on 16/11/23.
//  Copyright © 2016年 任梦晗. All rights reserved.
//

#import "TTAlertView.h"

@interface TTAlertView()
@property (nonatomic,copy) NSString *alertTitle;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) UIImage *promptImage;
@property (nonatomic,copy) NSString *cancleButtonTitle;
@property (nonatomic,strong) NSMutableArray *otherBtnsArr;
@property (nonatomic,strong) NSMutableArray *otherBtns;
@property (nonatomic,strong) UIView *backView;
@end
@implementation TTAlertView
{
    UIImageView *_titleImage;
    UILabel *_alertTitleLb;
    UILabel *_contentLb;
    UIButton *_cancleBtn;
    UILabel *_line;
}

- (instancetype)initWithTitle:(NSString *)titles andImage:(UIImage *)promptImage content:(NSString *)content cancleButton:(NSString *)cancleButton otherButtons:(NSString *)otherButtons, ...
{
    if (self = [super init]) {
        self.content = content;
        self.alertTitle = titles;
        self.promptImage = promptImage;
        self.cancleButtonTitle = cancleButton;
        self.otherBtnsArr = [NSMutableArray array];
        id eachObject;
        va_list argumentList;
        if (otherButtons) // The first argument isn't part of the varargs list,
        {                                   // so we'll handle it separately.
            [self.otherBtnsArr addObject: otherButtons];
            va_start(argumentList, otherButtons); // Start scanning for arguments after otherButtons.
            while ((eachObject = va_arg(argumentList, id))) // As many times as we can get an argument of type "id"
                [self.otherBtnsArr addObject: eachObject]; // that isn't nil, add it to self's contents.
            va_end(argumentList);
        }
       
        [self setup];
        
       
    }
    return self;
}
- (void)layoutSubviews
{
    CGFloat margin = 10;
    UIImage *img =_titleImage.image;
    _titleImage.frame = CGRectMake(0, margin, img.size.width, img.size.height);
    _titleImage.center = CGPointMake(self.width/2, _titleImage.center.y);
    
    if (_alertTitleLb!=nil) {
        _alertTitleLb.frame = CGRectMake(0, CGRectGetMaxY(_titleImage.frame)+margin, self.width, 30);
    }
    
    if (_contentLb != nil) {
        NSString *s = _content;
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize size = CGSizeMake(self.width-20,MAXFLOAT);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        [_contentLb setFrame:CGRectMake(10 ,_alertTitle.length>0?CGRectGetMaxY(_alertTitleLb.frame)+margin:CGRectGetMaxY(_titleImage.frame)+margin, self.width-20, labelsize.height)];
    }
    
    CGFloat width = (SCREEN_WIDTH-60)/_otherBtns.count;
    CGFloat heitht = 40;
    for (int i=0; i<_otherBtns.count; i++) {
        UIButton *btn = _otherBtns[i];
        btn.frame = CGRectMake(i*width, CGRectGetMaxY(_contentLb.frame)+3*margin, width, heitht);
    }
    _line.frame = CGRectMake(0, CGRectGetMaxY(_contentLb.frame)+3*margin, self.width, 1);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-60,_cancleBtn.frame.origin.y+40);
    self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 2.0;
   
}
- (void)show {
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_backView];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
//    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
//    [UIView animateWithDuration:0.3 animations:^{
//        self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
//    }];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//
//            self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//
//                self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
//            } completion:^(BOOL finished) {
//                [self layoutSubviews];
//            }];
//        }];
//    }];
    
    [UIView beginAnimations:@"" context:nil];   //开始动画
    [UIView setAnimationDelegate:self];
    CGAffineTransform curent =  self.transform;
    CGAffineTransform scale = CGAffineTransformScale(curent, 0.8,0.8);
    [UIView setAnimationDuration:0.3];
    [self setTransform:scale];
    [UIView commitAnimations];  //结束动画
    
    [UIView beginAnimations:@"" context:nil];   //开始动画
    [UIView setAnimationDelegate:self];
    CGAffineTransform curent1 =  self.transform;
    CGAffineTransform scale1 = CGAffineTransformScale(curent1, 1.1,1.1);
    [UIView setAnimationDuration:0.3];
    [self setTransform:scale1];
    [UIView commitAnimations];
    
    
//    [UIView beginAnimations:@"" context:nil];   //开始动画
//    [UIView setAnimationDelegate:self];
//    CGAffineTransform curent2 =  self.transform;
//    CGAffineTransform scale2 = CGAffineTransformScale(curent2, 1,1);
//    [UIView setAnimationDuration:0.3];
//    [self setTransform:scale2];
//    [UIView commitAnimations];  //结束动画
    
    self.transform = CGAffineTransformIdentity;
}
- (void)setup
{
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-60,_cancleBtn.frame.origin.y+40);

    self.otherBtns = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    _titleImage = [[UIImageView alloc] init];
    if (_promptImage == nil) {
        _titleImage.image = [UIImage imageNamed:@"dock_camera_down"];
    }else {
        _titleImage.image = _promptImage;
    }
    _cancleBtn = [[UIButton alloc] init];
    [_cancleBtn setBackgroundColor:[UIColor blackColor]];
    [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancleBtn.tag =0;
    [_cancleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherBtns addObject:_cancleBtn];
    
    if (_alertTitle!=nil|| ![_alertTitle isEqualToString:@""] ||_alertTitle!=NULL) {
        _alertTitleLb = [[UILabel alloc] init];
        _alertTitleLb.text = _alertTitle;
        _alertTitleLb.numberOfLines = 1;
        _alertTitleLb.font = [UIFont systemFontOfSize:20];
        _alertTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    if (_content != nil || ![_content isEqualToString:@""] ||_content!=NULL) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.text = _content;
        _contentLb.numberOfLines = 0;
         _contentLb.font = [UIFont systemFontOfSize:16];
        _contentLb.textAlignment = NSTextAlignmentCenter;
    }
    if (_cancleButtonTitle == nil) {
        _cancleButtonTitle = @"取消";
    }else {
        [_cancleBtn setTitle:self.cancleButtonTitle forState:UIControlStateNormal];
    }
    
    if (_otherBtnsArr.count>1) {
        for (int i = 0; i<_otherBtnsArr.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:_otherBtnsArr[i] forState:UIControlStateNormal];
            [self.otherBtns addObject:btn];
            btn.tag = i+1;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    _line = [[UILabel alloc] init];
    _line.backgroundColor = [UIColor blackColor];
    [self addSubview:_line];
    [self addSubview:_titleImage];
    [self addSubview:_alertTitleLb];
    [self addSubview:_contentLb];
    [self addSubview:_cancleBtn];
    
    CGFloat margin = 10;
    NSString *s = _content;
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = CGSizeMake(self.width-20,MAXFLOAT);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-60,margin + _titleImage.image.size.height +margin +30+margin + labelsize.height +3*margin +40 +20);
    self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    
    
}
- (void)buttonClick:(UIButton *)button
{

    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
        
      
    }
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}
@end
