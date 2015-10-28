//
//  AdViewController.m
//  Car
//
//  Created by Leon on 11/19/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BaseAdViewController.h"
#import "AdView.h"
#import "Advert.h"
#import "WebViewController.h"

@interface BaseAdViewController () <AdViewDelegate>
@property (nonatomic, strong) NSMutableArray *adverts;


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initAdverts];
}

- (void) initAdverts{
    AdView *adView = [[AdView alloc] initWithFrame:CGRectMake(0, 0, 320, 132)];
    _adView = adView;
    adView.adViewDelegate = self;
    [self.view addSubview:adView];
    
    if (_adverts == nil) {
        // 1.从文件中读取联系人数据
        _adverts = [NSKeyedUnarchiver unarchiveObjectWithFile:SCAdvertData];
        // 2.如果数组为nil
        if (_adverts == nil) { // 文件不存在
            _adverts = [NSMutableArray array];
            [self loadAdverts];
        } else {
//            _adView.imageArray = [_adverts valueForKeyPath:@"picUrl"];
            [self loadAdverts];
        }
    }
    
}

//加载广告
- (void)loadAdverts{
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 1; i <= 5; i ++) {
        [imgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"adverts%d.jpg", i]]];
    }
    _adView.imageArray = imgArray;
    
//    [[HttpRequest shareRequst]getAdvListWithType:@"3" success:^(id obj) {
//        NSNumber *code  = [obj valueForKeyPath:@"code"];
//        if (code.integerValue == 0){
//            _adverts = [NSMutableArray array];
//            NSArray *advs = [[obj valueForKeyPath:@"record"] valueForKey:@"advs"];
//            for (NSDictionary *dic in advs) {
//                Advert *adv = [Advert advWithDic:dic];
//                [_adverts addObject:adv];
//            }
//
//            _adView.imageArray = [_adverts valueForKeyPath:@"picUrl"];
//            
//            [NSKeyedArchiver archiveRootObject:_adverts toFile:SCAdvertData];
//        }
////        [MBProgressHUD hideHUD];
//    } fail:^(NSString *errorMsg) {
////        [MBProgressHUD hideHUD];
//    }];
}

#pragma mark - 广告点击
- (void)imageClick:(UIButton *)btn inAdView:(AdView *)adView{
    NSInteger index = btn.tag;
    WebViewController *advc = [[WebViewController alloc] init];
    Advert *adv = [self.adverts objectAtIndex:index];
    advc.link = adv.url;
    advc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:advc animated:YES];
}


@end
