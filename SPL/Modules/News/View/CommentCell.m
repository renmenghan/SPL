//
//  CommentCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"

@interface CommentCell()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *usernameLabel;
@property (nonatomic,strong) UILabel *createTimeLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation CommentCell

- (void)drawCell
{
    
    [self cellAddSubView:self.lineView];
    [self cellAddSubView:self.logoImageView];
    [self cellAddSubView:self.usernameLabel];
    [self cellAddSubView:self.createTimeLabel];
    [self cellAddSubView:self.contentLabel];

}

- (void)reloadData
{
    if (self.cellData) {
        
        CommentModel *model = self.cellData;
        
        [self.logoImageView setOnlineImage:model.image];
        
        if (!IsEmptyString(model.tousername)) {
            NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%@ 回复 %@",model.username,model.tousername]];
            NSRange range1=[[hintString string]rangeOfString:@"回复"];
            [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
            self.usernameLabel.attributedText = hintString;
        }else {
            self.usernameLabel.text = model.username;
        }
        [self.usernameLabel sizeToFit];
        self.usernameLabel.left = self.logoImageView.right + 10;
        self.usernameLabel.centerY = self.logoImageView.centerY;
        
        self.createTimeLabel.text = model.create_time;
        [self.createTimeLabel sizeToFit];
        self.createTimeLabel.centerY = self.logoImageView.centerY;
        self.createTimeLabel.right = SCREEN_WIDTH-10;
        
        self.contentLabel.text = model.content;
        self.contentLabel.width = SCREEN_WIDTH-20;
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel sizeToFit];
        self.contentLabel.top = 60;
        self.contentLabel.left = 10;
        
        
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        CommentModel *model = cellData;
        
        CGFloat contentH = [model.content sizeWithUIFont:FONT(13) forWidth:SCREEN_WIDTH-20].height;
        height = 60 + contentH + 10;
        
    }
    return height;
}
#pragma mark - subviews
- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = Color_Gray(245);
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UILabel *)usernameLabel
{
    if (!_usernameLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = RGB(102, 204, 255);
        label.font = FONT(13);
        _usernameLabel = label;
    }
    return _usernameLabel;
}


- (UILabel *)createTimeLabel
{
    if (!_createTimeLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray(60);
        label.font = FONT(13);
        
        _createTimeLabel = label;
    }
    return _createTimeLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = Color_Gray230;
        view.bottom = [CommentCell heightForCell:self.cellData];
        _lineView = view;
    }
    return _lineView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = Color_Gray(60);
        label.font = FONT(13);
        
        _contentLabel = label;
    }
    return _contentLabel;
}

@end
