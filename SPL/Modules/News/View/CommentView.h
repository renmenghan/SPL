//
//  CommentView.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentViewDelegate<NSObject>

- (void)sendMsgClick:(UITextField *)msgTF;
- (void)likeClick;

@end
@interface CommentView : UIView

@property (nonatomic,weak) id <CommentViewDelegate>delegate;

@property (nonatomic,strong) UITextField *commentTF;
@property (nonatomic,assign) BOOL isUpvote;

- (void)reloadData;
@end
