//
//  NewsDetailController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsRequest.h"
#import "NewsDetailCell.h"
#import "CommentView.h"
#import "CommentCell.h"
@interface NewsDetailController ()<CommentViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NewsDetailModel *detailModel;
@property (nonatomic,strong) CommentView *commentView;
@property (nonatomic,strong) CommentsResultModel *resultModel;
@property (nonatomic,copy) NSString *toUserId;
@property (nonatomic,assign) BOOL isUpvote;
@end

@implementation NewsDetailController
-(void)dealloc
{
    DBG(@"newsdetail -----dealloc");
}
- (void)viewDidLoad {
    [self addNavigationBar];
    
    [super viewDidLoad];
    
    self.tableView.height = self.tableView.height - 50;
    
    self.showsPullToRefresh = YES;
    
    self.showsInfiniteScrolling = NO;
    
    [self initData];
    
    [self.view addSubview:self.commentView];
}

- (void)initData
{
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.newsId forKey:@"newsId"];
    
    [NewsRequest getNewsDetailWithParams:params success:^(NewsDetailModel *model) {
        
        self.detailModel = model;
        
        [self loadComments];
//        [self reloadData];
//
//        [self finishRefresh];
        
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
    }];
    
    
    
}

- (void)loadComments
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.newsId forKey:@"newsId"];
    [NewsRequest getCommentsDataWithParams:params success:^(CommentsResultModel *resultModel) {
        
        self.resultModel = resultModel;
        
        [self loadUpvote];

    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
    }];
}

- (void)loadUpvote
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.newsId forKey:@"newsId"];
    [NewsRequest getUpvoteWithParams:params success:^(UpVoteResultModel *model) {
        
        self.isUpvote = model.is_upvote;
        self.commentView.isUpvote = self.isUpvote;
        [self.commentView reloadData];
        [self reloadData];
        [self finishRefresh];
        
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }else if (section == 1){
        return  self.resultModel.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        NewsDetailCell *cell = [NewsDetailCell dequeueReusableCellForTableView:tableView];
        
        cell.cellData = self.detailModel;
        [cell reloadData];
        return cell;
    }else if (section == 1){
        CommentCell *cell = [CommentCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.resultModel.list safeObjectAtIndex:row];
        [cell reloadData];
        return cell;
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
    
    if (section == 0) {
        height = [NewsDetailCell heightForCell:self.detailModel];
    }else if (section == 1){
        height = [CommentCell heightForCell:[self.resultModel.list safeObjectAtIndex:row]];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 1) {
        CommentModel *model = [self.resultModel.list safeObjectAtIndex:row];
        self.toUserId = model.user_id;
        self.commentView.commentTF.placeholder = [NSString stringWithFormat:@"回复：%@",model.username];
        [self.commentView.commentTF becomeFirstResponder];
    }
}

- (CommentView *)commentView
{
    if (!_commentView) {
        _commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, IS_IPHONEX?SCREEN_HEIGHT-50-SAFE_BOTTOM_HEIGHT: SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _commentView.delegate = self;
        _commentView.commentTF.delegate = self;
    }
    
    return _commentView;
}

- (void)sendMsgClick:(UITextField *)msgTF
{
    if (IsEmptyString(msgTF.text)) {
        [self showNotice:@"说点什么吧~"];
        return;
    }
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    [parmas setSafeObject:self.newsId forKey:@"news_id"];
    [parmas setSafeObject:msgTF.text forKey:@"content"];
    if (!IsEmptyString(self.toUserId)) {
         [parmas setSafeObject:self.toUserId forKey:@"to_user_id"];
    }
    [NewsRequest postCommentDataWithParams:parmas success:^{
        
        [self showNotice:@"评论成功"];
        [self loadComments];
        msgTF.text = @"";
        [msgTF endEditing:YES];
        
    } failure:^(StatusModel *status) {
       
        [self showNotice:status.msg];
    }];
}

- (void)likeClick
{
    NSDictionary *params = @{@"id":self.newsId};
    if (self.isUpvote) {
        [NewsRequest postUpvoteDeleteWithParams:params success:^{
            
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            
        }];
    }else{
        [NewsRequest postUpvoteWithParams:params success:^{
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (IsEmptyString(textField.text)) {
        self.toUserId = @"";
        textField.placeholder = @"请输入评论内容";
    }
}

@end
