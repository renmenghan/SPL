//
//  NewsDetailCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsDetailCell.h"
#import "NewsDetailModel.h"
@interface NewsDetailCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitle;

@property (nonatomic,strong) UILabel *contentLabel;
@end
@implementation NewsDetailCell

- (void)drawCell
{
    
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.subTitle];
    [self cellAddSubView:self.contentLabel];
}

- (void)reloadData
{
    if (self.cellData) {
        NewsDetailModel *model = self.cellData;
        self.titleLabel.text = model.title;
        self.titleLabel.width = SCREEN_WIDTH -20;
        self.titleLabel.left=10;
        self.titleLabel.top = 10;
        [self.titleLabel sizeToFit];
        
        self.subTitle.text = [NSString stringWithFormat:@"%@ %@人看过",model.create_time,model.read_count];
        [self.subTitle sizeToFit];
        self.subTitle.top = self.titleLabel.bottom + 10;
        
        NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
        
        NSData *data = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSAttributedString *htmlStr =[[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
        CGFloat htmlH =   [htmlStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        self.contentLabel.top = self.subTitle.bottom+ 10;
        self.contentLabel.left = 10;
        self.contentLabel.width = SCREEN_WIDTH - 20;
        self.contentLabel.height = htmlH;
//        [self.contentLabel sizeToFit];
        self.contentLabel.attributedText = htmlStr;

    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        NewsDetailModel *model = cellData;
        NSString *subStr = [NSString stringWithFormat:@"%@ %@人看过",model.create_time,model.read_count];
        height = 10 + [model.title sizeWithUIFont:FONT(18) forWidth:SCREEN_WIDTH-20].height + 10  + [subStr sizeWithUIFont:FONT(13) forWidth:SCREEN_WIDTH-20].height +10;
        
        NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                                   
                                   NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
        
        NSData *data = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        
        NSAttributedString *htmlStr =[[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
        
        CGFloat htmlH =   [htmlStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
        height = height + htmlH;
        
    }
    return height;
}
#pragma mark -subviews
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        
        label.textColor = Color_Gray(42);
        label.font = FONT(18);
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)subTitle
{
    if (!_subTitle) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        
        label.textColor = Color_Gray(42);
        label.font = FONT(13);
        label.numberOfLines = 0;
        _subTitle = label;
    }
    return _subTitle;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;

        _contentLabel = label;
    }
    return _contentLabel;
}

@end
