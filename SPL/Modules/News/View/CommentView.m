//
//  CommentView.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "CommentView.h"

@interface CommentView()

@property (nonatomic,strong) UIButton *likeButton;

@property (nonatomic,strong) UIButton *sendButton;
@end
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.commentTF];
        [self addSubview:self.likeButton];
        [self addSubview:self.sendButton];
        
    }
    
    return self;
}

- (void)reloadData
{
    if (self.isUpvote) {
        self.likeButton.selected = YES;
    }else{
        self.likeButton.selected = NO;
    }
}
#pragma mark - subviews
- (UITextField *)commentTF
{
    if (!_commentTF) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH- 40 - 80, 40)];
        tf.font = FONT(14);
        tf.textColor = Color_Gray(100);
        tf.layer.borderColor = Color_Gray(205).CGColor;
        tf.layer.borderWidth = 1;
        tf.placeholder = @"请输入评论内容";
        _commentTF = tf;
    }
    return _commentTF;
}

- (UIButton *)likeButton
{
    if (!_likeButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
//        button.layer.cornerRadius = 10;
//        button.layer.masksToBounds = YES;
//        [button setBackgroundColor:Color_Gray(0)];
        [button setImage:[UIImage imageNamed:@"like_down"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"all_like"] forState:UIControlStateSelected];
        
        button.left = self.sendButton.right + 10;
        button.contentMode = UIViewContentModeScaleAspectFill;

        [button addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _likeButton = button;
    }
    
    return _likeButton;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        //        button.layer.cornerRadius = 10;
        //        button.layer.masksToBounds = YES;
        //        [button setBackgroundColor:Color_Gray(0)];
        [button setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFill;
    
        button.left = self.commentTF.right + 10;
        
        [button addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _sendButton = button;
    }
    
    return _sendButton;
}

-(void)likeButtonClick
{
    if ([self.delegate respondsToSelector:@selector(likeClick)]) {
        [self.delegate likeClick];
    }
    self.likeButton.selected = !self.likeButton.selected;
}

-(void)sendButtonClick
{
    if ([self.delegate respondsToSelector:@selector(sendMsgClick:)]) {
        [self.delegate sendMsgClick:self.commentTF];
    }
}
@end
