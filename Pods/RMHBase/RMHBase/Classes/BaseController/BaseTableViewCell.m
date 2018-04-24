//
//  BaseTableViewCell.m
//  BaseUtilityExample
//
//  Created by 任梦晗 on 17/3/10.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
            break;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self drawCell];
    
    return self;
}

- (void)drawCell{
    
}

- (void)cellAddSubView:(UIView*)view
{
    [self.contentView addSubview:view];
}

- (void)reloadData{
    
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifier]];
    }
    return cell;
}

+ (CGFloat)heightForCell:(id)cellData
{
    return 0;
}



@end
