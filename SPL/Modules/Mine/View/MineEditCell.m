//
//  MineEditCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "MineEditCell.h"
@interface MineEditCell()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UITextField *setInfoTf;
@end

@implementation MineEditCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
}

- (void)reloadData
{
    if (self.cellData) {
        
        NSDictionary *data = self.cellData;
        
        NSString *title = data[@"title"];
        if (!IsEmptyString(title)) {
            [self cellAddSubView:self.titleLabel];
            self.titleLabel.text = title;
            [self.titleLabel sizeToFit];
            self.titleLabel.left = 10;
            self.titleLabel.centerY = 22;
        }
        
        NSString *content = data[@"content"];
        if (  ![data[@"input"] boolValue]) {
            [self cellAddSubView:self.content];
            if ([title isEqualToString:@"性别"]) {
                self.content.text =  [[UserService sharedService].gender intValue] == 1?@"男":@"女";
            }else {
                self.content.text = content;
            }
            
            [self.content sizeToFit];
            self.content.left = self.titleLabel.right + 10;
            self.content.centerY = 22;
        }else if ( [data[@"input"] boolValue]){
            [self cellAddSubView:self.setInfoTf];
            
            self.setInfoTf.text = content;
            self.setInfoTf.top = 0;
            self.setInfoTf.left = self.titleLabel.right + 10;
            self.setInfoTf.width = SCREEN_WIDTH-80;
            self.setInfoTf.centerY = 22;
            if ([title isEqualToString:@"设置密码"]) {
                self.setInfoTf.placeholder = @"输入新密码";
            }
        }
        
        NSString *logo = data[@"logo"];
        if (!IsEmptyString(logo)) {
            [self cellAddSubView:self.logoImageView];
            self.logoImageView.right = SCREEN_WIDTH -10;
            self.logoImageView.centerY = 22;
            if (!IsEmptyString([UserService sharedService].avatar)) {
                [self.logoImageView setOnlineImage:[UserService sharedService].avatar];

            }
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 44;
    }
    return height;
}

#pragma mark -subviews

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_Gray(0);
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

-(UILabel *)content
{
    if (!_content) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_Gray(100);
        label.font = FONT(14);
        _content = label;
    }
    return _content;
}

-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.image = [UIImage imageNamed:@""];
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UITextField *)setInfoTf
{
    if (!_setInfoTf) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 0, 44)];
        tf.font = FONT(14);
//        tf.layer.borderWidth = 1;
//        tf.layer.borderColor = Color_Gray(0).CGColor;
        tf.textColor = Color_Gray(100);
//        [tf setSecureTextEntry:false];
//        tf.placeholder = @"昵称";
//        tf.leftViewMode=UITextFieldViewModeAlways;
//        tf.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lod_password"]];
        tf.delegate = self;
        _setInfoTf = tf;
    }
    return _setInfoTf;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDictionary *data = self.cellData;
    NSString *title = data[@"title"];
    if ([title isEqualToString:@"昵称"]) {
        [UserService sharedService].name = textField.text;
        [[UserService sharedService] saveLoginInfo];
    }
    
    if ([title isEqualToString:@"个性签名"]) {
        [UserService sharedService].signature =textField.text;
        [[UserService sharedService] saveLoginInfo];

    }
    
    if ([title isEqualToString:@"设置密码"] && !IsEmptyString(textField.text)) {
        NSDictionary *pa = @{@"password":textField.text};
        [UserService sharedService].extraParams = pa;;
        [[UserService sharedService] saveLoginInfo];
    }
}
@end
