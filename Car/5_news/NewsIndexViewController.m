//
//  NewsIndexViewController.m
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsIndexViewController.h"
#import "NewsListController.h"
#import "NewsDetailController.h"
#import "NewsType.h"

@interface NewsIndexViewController () <NewsListDelegate>

@end

@implementation NewsIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"新闻中心";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _newsArrays = [NSMutableArray array];
    
    [MBProgressHUD showMessage:@"正在加载...."];
    
    [[HttpRequest shareRequst] getNewsMenuWithBoard:self.board success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [[obj valueForKey:@"record"] valueForKey:@"menu"];
            for (NSDictionary *dic in array){
                NewsType *type = [NewsType newsTypeWithDic:dic];
                NewsListController *list = [[NewsListController alloc]init];
                list.newsListDeleage = self;
                list.title = type.name;
                list.type = type;
                [self.newsArrays addObject:list];
            }
            
            self.slideView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
            self.slideView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"0d68d9"];
            self.slideView.shadowImage = [[UIImage imageNamed:@"blue_line.png"]
                                          stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
            
            [self.slideView buildUI];

            [MBProgressHUD hideHUD];
        }
    } fail:^(NSString *errorMsg) {
        
    }];
}

#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return [_newsArrays count];
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [_newsArrays objectAtIndex:number];
}

//- (void)slideSwitchView:(QCSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
//{
//    QCViewController *drawerController = (QCViewController *)self.navigationController.mm_drawerController;
//    [drawerController panGestureCallback:panParam];
//}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    NewsListController *list = [_newsArrays objectAtIndex:number];
    [list viewDidCurrentView];
}

- (void)showNewsDetail:(NewsListController *)controller index:(NSInteger)index{
    NewsDetailController *detail = [[NewsDetailController alloc] init];
    NewsModel *model = [controller.dataArray objectAtIndex:index];
    detail.model = model;
    detail.detailType = 1;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
