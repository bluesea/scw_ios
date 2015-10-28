//
//  NewsListViewController.m
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsListController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsDetailController.h"

@interface NewsListController ()

//@property (nonatomic, assign) int page;
//@property (nonatomic, assign) BOOL refreshFlag;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL fristShow;

@end

@implementation NewsListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidCurrentView
{
    LSLog(@"加载为当前视图 = %@",self.title);
    if(_fristShow ){
        [self startHeaderRefresh];
    }
    
    _fristShow = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    _fristShow = YES;
    self.tableView.rowHeight = 80;
    
//    [self setupRefresh];
    
}

//- (void)setupRefresh
//{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//}


//- (void)beginHeaderRefreshing{
//    [self.tableView headerBeginRefreshing];
//}


//#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    
//    LSLog(@"---下拉");
//    // 1.添加假数据
//    _page = 0;
//    _refreshFlag = YES;
//    [self loadData];
//}
//
//- (void)footerRereshing
//{
//    LSLog(@"---上拉");
//    _refreshFlag = NO;
//    _page++;
//    [self loadData];
//}

//读取数据
- (void)loadData{
    [[HttpRequest shareRequst] getNewsListWithTypeId:_type.id page:self.pageNum success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
            [self checkResponseArray:array];
            for(NSDictionary *dic in array){
                NewsModel *newsModel = [NewsModel newsModelWithDic:dic];
                
                [self.dataArray addObject:newsModel];
            }
            [self.tableView reloadData];
        }
        [self endRefresh];
    } fail:^(NSString *errorMsg) {
        LSLog(@"---------->fail");
        [self endRefresh];
    }];
}

//- (void)endFresh{
//    if(_refreshFlag){
//        [self.tableView headerEndRefreshing];
//    } else {
//        [self.tableView footerEndRefreshing];
//    }
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [_dataArray count];
//    //    return  10;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [NewsCell cellWithTableView:tableView];
    cell.newsModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSLog(@"-->chick");
    NewsDetailController *detail = [[NewsDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    if ([self.newsListDeleage respondsToSelector:@selector(showNewsDetail:index:)]){
        [self.newsListDeleage showNewsDetail:self index:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
