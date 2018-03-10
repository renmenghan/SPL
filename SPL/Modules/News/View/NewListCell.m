//
//  NewListCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewListCell.h"
#import "NewListModel.h"

@interface NewListCell()

@property (nonatomic,strong) UIImageView *picImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *readCountLabel;

@property (nonatomic,strong) UILabel *createTimeLabel;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation NewListCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.picImageView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.readCountLabel];
    [self cellAddSubView:self.createTimeLabel];
    [self cellAddSubView:self.lineView];
    
}

- (void)reloadData
{
    if (self.cellData) {
        
        NewListModel *model = self.cellData;
        
        [self.picImageView setOnlineImage:model.image];
        
       
        self.titleLabel.text = model.title;
        self.titleLabel.width = SCREEN_WIDTH - 20 - 130 -10;
        [self.titleLabel sizeToFit];
        
        self.readCountLabel.text =[NSString stringWithFormat:@"%@人阅读",model.read_count] ;
        [self.readCountLabel sizeToFit];
        self.readCountLabel.bottom = 110;
        
        self.createTimeLabel.text = [model.create_time substringToIndex:10];
        [self.createTimeLabel sizeToFit];
        self.createTimeLabel.bottom = 110;
        self.createTimeLabel.right  =self.picImageView.left - 10;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 120;
    }
    return 0;
}

#pragma mark - subviews
- (UIImageView *)picImageView
{
    if (!_picImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 130, 100)];
        imageView.right = SCREEN_WIDTH-10;
        
        _picImageView = imageView;
    }
    
    return _picImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        
        label.textColor = Color_Gray(42);
        label.font = FONT(18);
        label.numberOfLines = 3;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)readCountLabel
{
    if (!_readCountLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.textColor = Color_Gray(60);
        label.font = FONT(13);
        _readCountLabel = label;
    }
    return _readCountLabel;
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
        view.bottom = [NewListCell heightForCell:@""];
        _lineView = view;
    }
    return _lineView;
}

@end
