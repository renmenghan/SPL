//
//  MineSettingViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.


#import "MineSettingViewController.h"
#import "MineEditCell.h"
#import "MineRequest.h"
#import "UserInfoModel.h"
#import "LoginOutCell.h"

@interface MineSettingViewController ()
@property (nonatomic,strong) NSArray *menu;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UserInfoModel *userModel;

@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [self addNavigationBar];
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = Color_Gray(240);

    NSString *fontName = @"Noteworthy";
    CGFloat fontSize = 25;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"i n f o" attributes:@{
                                                                                                             NSForegroundColorAttributeName    :[UIColor whiteColor],
                                                                                                             NSShadowAttributeName:
                                                                                                                 shadow,
                                                                                                             NSFontAttributeName:
                                                                                                                 [UIFont fontWithName:fontName size:fontSize]
                                                                                                             }];
    [self.navigationBar.titleLabel setAttributedText:att];
    
    self.navigationBar.rightBarButton = self.rightButton;
    
    [self initData];

}

- (void)initData
{
    [self loadData];
}

- (void)loadData
{
    
    [MineRequest getUserDataWithParams:nil success:^(UserInfoModel *user) {
        self.userModel = user;
        self.menu = @[@{@"logo":@"logo",@"title"
                        :@"头像",@"content":@"",@"input":@""}
                      ,@{@"title":@"昵称",@"content":user.username,@"input":@YES}
                      ,@{@"title":@"性别",@"content":@"sex",@"input":@""}
                      ,@{@"title":@"个性签名",@"content":user.signature,@"input":@YES},
                       @{@"title":@"设置密码",@"content":@"",@"input":@YES}];
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
    
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menu.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    if (section < self.menu.count) {
        if (row == 1) {
            NSDictionary *dic = [self.menu safeObjectAtIndex:section];
            MineEditCell *cell = [MineEditCell dequeueReusableCellForTableView:tableView];
            cell.cellData = dic;
            [cell reloadData];
            return cell;
        }
    }
    if (section == self.menu.count) {
        if (row == 1) {
            LoginOutCell *cell = [LoginOutCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
        }
    }
    
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if (section < self.menu.count) {
        if (row == 1) {
            height = [MineEditCell heightForCell:[self.menu safeObjectAtIndex:section]];
        }else if (row ==0){
            return 1;
        }
    }
    
    if (section == self.menu.count) {
        if (row == 0) {
            height = 40;
        }
        else {
            height = [LoginOutCell heightForCell:@" "];
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
        actionSheet.tag = 1;
        [actionSheet showInView:self.view];
    }
    if (section == 2) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:self.view];
    }
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // 拍照
        {
            if (actionSheet.tag == 2) {
                [self genderAction:@"1"];
            }else{
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeCamera];
            }
        }
            break;
        case 1: // 从手机相册选取
        {
            if (actionSheet.tag == 2) {
                [self genderAction:@"2"];
            }else{
                [self avatarFromSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }
        }
            break;
        default:
            break;
    }
}

- (void)avatarFromSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        
        UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [MineRequest postImageWithParams:nil image:avatarImage success:^(MineChangeAvatarResultModel *avatar) {
            
            [UserService sharedService].avatar = avatar.image ;
//            [UserService sharedService].gender = @"1";
            [[UserService sharedService] saveLoginInfo];
            [self reloadData];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    
//        weakify(self);
//        [MineRequest changeAvatarWithParams:nil image:avatarImage success:^(MIChangeAvatarResultModel *resultModel){
//
//            [[UserService sharedService] updateInfo:resultModel.avatar for:@"avatar"];
//
//            strongify(self);
//            [self reloadData];
//
//        } failure:^(StatusModel *status) {
//
//            [self showNotice:status.msg];
//
//        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) genderAction:(NSString*)gender
{
    //    NSString *gender = @"1";//男
    //    gender = @"2";//女
    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setSafeObject:gender forKey:@"gender"];
    
    [UserService sharedService].gender = gender;
    [[UserService sharedService] saveLoginInfo];
    [self reloadData];
//
//    weakify(self);
//
//    [MineRequest changeGenderWithParams:params success:^{
//
//        [[UserService sharedService] updateInfo:gender for:@"gender"];
//
//        strongify(self);
//
//        [self reloadData];
//
//    } failure:^(StatusModel *status) {
//
//        strongify(self);
//        [self showNotice:status.msg];
//
//    }];
    
}

#pragma mark -subview
- (UIButton *)rightButton
{
    if (!_rightButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        [button setTitle:@"保存" forState:UIControlStateNormal];
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton = button;
    }
    
    return _rightButton;
}


-(void)rightBtnClick
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:[UserService sharedService].avatar forKey:@"image"];
    [params setSafeObject:[UserService sharedService].gender forKey:@"sex"];
    [params setSafeObject:[UserService sharedService].name forKey:@"username"];
    [params setSafeObject:[UserService sharedService].avatar forKey:@"image"];
    [params setSafeObject:[UserService sharedService].signature forKey:@"signature"];
    NSString *password =[UserService sharedService].extraParams[@"password"];
    if (!IsEmptyString(password)) {
         [params setSafeObject:[password md5] forKey:@"password"];
    }
    [MineRequest updateUserInfoWithParams:params success:^{
       
        [self showNotice:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
    }];
    

}
@end
