//
//  BzViewController.m
//  Car
//
//  Created by Leon on 10/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzViewController.h"
#import "BzSearchVC.h"
#import "UIImageView+WebCache.h"
#import "BusinessCell.h"
#import "BusinessTrace.h"
#import "SpeedLocation.h"
#import "BzDetailController.h"

#import "BzPointAnnotation.h"
#import "BzDetailAnnotation.h"
#import "BzAnnoView.h"

@interface BzViewController (){
    NSMutableArray *businessArray;
    //    BusinessMapViewController *bzMap;
    UIBarButtonItem *searchBtn;
    UIBarButtonItem *mapBtn;
    UIBarButtonItem *listBtn;
    BzDetailAnnotation *bzAnno;
    BOOL searchFlag;
    BOOL mapFlag;
    
    NSMutableArray *annoArray;
}

@end

@implementation BzViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"业务浏览";
        searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-search.png"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
        
        mapBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-navi.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toMap)];
        
        listBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bz-list.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toList)];
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
        self.navigationItem.leftBarButtonItem = backBtn;
        
        self.navigationItem.rightBarButtonItems = @[mapBtn,searchBtn];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
//#warning 判断是否从搜索页面回来
    if (searchFlag){
        LSLog(@"---from search");
        [self startHeaderRefresh];
        searchFlag = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MKMapView *mapView = [[MKMapView alloc] init];
    _mapView = mapView;
    _mapView.delegate = self;
    [_mapView setShowsUserLocation:YES];
    
    annoArray = [NSMutableArray array];
    [self.view addSubview:_mapView];
    
    [self startHeaderRefresh];
}

#pragma  mark - 数据加载
- (void)loadData{
    //    location = [_mapView userLocation];
    [[HttpRequest shareRequst] getSendCarLinkByPage:[NSNumber numberWithInt:self.pageNum]
                                          longitude:[NSNumber numberWithDouble:/*[SpeedLocation shareInstance].longitude*/0]
                                           latitude:[NSNumber numberWithDouble:/*[SpeedLocation shareInstance].latitude*/0]
                                            carType:[_searchDic objectForKey:@"carType"]
                                               ori1:[_searchDic objectForKey:@"ori1"]
                                               ori2:[_searchDic objectForKey:@"ori2"]
                                               ori3:[_searchDic objectForKey:@"ori3"]
                                               des1:[_searchDic objectForKey:@"des1"]
                                               des2:[_searchDic objectForKey:@"des2"]
                                               des3:[_searchDic objectForKey:@"des3"]
                                              stime:[_searchDic objectForKey:@"stime"]
                                            success:^(id obj) {
                                                NSNumber *code = [obj objectForKey:@"code"];
                                                if (code.intValue == 0){
                                                    NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
                                                    [self checkResponseArray:array];
                                                    for(NSDictionary *dic in array){
                                                        BusinessTrace *bzModel = [BusinessTrace businessTraceWithDic:dic];
                                                        [self.dataArray addObject:bzModel];
                                                    }
                                                    [self.tableView reloadData];
                                                    if (mapFlag){
                                                        [self addPoints];
                                                    }
                                                }
                                                [self endRefresh];
                                            }
                                               fail:^(NSString *errorMsg) {
                                                   [self endRefresh];
                                                   LSLog(@"----请求不成功");
                                               }];
}



#pragma mark - IBAction
#pragma mark 搜索
- (void)searchAction{
    //先回到列表页面再跳转
    //    [self toList];
    BzSearchVC *search = [[BzSearchVC alloc] init];
    search.block = ^(NSDictionary *dic){
        self.searchDic = dic;
        searchFlag = YES;
    };
    
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark 地图页面
- (void)toMap{
//    [UIView  transitionFromView:self.tableView toView:self.mapView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    CGRect frame = self.view.frame;
   _mapView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [self.view bringSubviewToFront:_mapView];
    
    MKCoordinateSpan span = {5 ,5};
    MKCoordinateRegion region = {[_mapView userLocation].coordinate, span};
    
    [_mapView setRegion:region animated:YES];
    
    [self addPoints];
    
    mapFlag = YES;
    
    self.navigationItem.rightBarButtonItems = @[listBtn,searchBtn];
}

- (void)addPoints{
    [_mapView removeAnnotations:annoArray];
    [_mapView removeAnnotation:bzAnno];
    [annoArray removeAllObjects];
    for (int  i = 0; i < self.dataArray.count ; i ++){
        BusinessTrace *bzModel = self.dataArray[i];
        BzPointAnnotation *point = [[BzPointAnnotation alloc] init];
        [point setBzModel:bzModel];
        [point setCoordinate:CLLocationCoordinate2DMake([bzModel.latitude doubleValue], [bzModel.longitude doubleValue])];
        
        [annoArray addObject:point ];
    }
    
    [_mapView addAnnotations:annoArray];
}


#pragma mark - Map Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *annotationIdentifier = @"bzPointAnnotation";
    if ([annotation isKindOfClass:[BzPointAnnotation class]]) {
        
        MKPinAnnotationView *annotationview = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        [annotationview setAnimatesDrop:YES];
        annotationview.canShowCallout = NO;
        
        return annotationview;
        
    } else if ([annotation isKindOfClass:[BzDetailAnnotation class]]) {
        BzDetailAnnotation *ann = (BzDetailAnnotation*)annotation;
        BzAnnoView *bzView = (BzAnnoView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"bzView"];
        
        //否则创建新的calloutView
        if (!bzView) {
            bzView = [[BzAnnoView alloc] initWithAnnotation:ann reuseIdentifier:@"bzView"];
            
            BusinessCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessCell" owner:self options:nil] objectAtIndex:0];
            
            cell.tag = 1000;
            
            [bzView.contentView addSubview:cell];
            
            bzView.cellView = cell;
        }
        
        BusinessCell *cell = (BusinessCell *)[bzView.contentView viewWithTag:1000];
        
        cell.ori1Label.text = ann.bzModel.ori1;
        cell.ori2Label.text = ann.bzModel.ori2;
        cell.des1Label.text = ann.bzModel.des1;
        cell.des2Label.text = ann.bzModel.des2;
        cell.timeLabel.text = [ann.bzModel.stime substringToIndex:10];
        cell.distanceLabel.text = ann.bzModel.distance;
        cell.carNumLabel.text = [NSString stringWithFormat:@"%d辆%@",ann.bzModel.carNum,ann.bzModel.carTypeName];
        cell.comNameLabel.text = ann.bzModel.comName;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.typeImage.image = [UIImage imageNamed:@"carType1.png"];
        [cell.typeImage sd_setImageWithURL:[NSURL URLWithString:ann.bzModel.carPic]];
        [bzView setCanShowCallout:YES];
        
        return bzView;
        
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    BzPointAnnotation *annn = (BzPointAnnotation*)view.annotation;
    
    
    if ([view.annotation isKindOfClass:[BzPointAnnotation class]]) {
        
        //如果点到了这个marker点，什么也不做
        if (bzAnno.coordinate.latitude == view.annotation.coordinate.latitude&&
            bzAnno.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (bzAnno) {
            [mapView removeAnnotation:bzAnno];
            
        }
        //创建搭载自定义calloutview的annotation
        bzAnno = [[BzDetailAnnotation alloc]initWithLatitude:annn.coordinate.latitude andLongitude:annn.coordinate.longitude andBzModel:annn.bzModel];
        
        [mapView addAnnotation:bzAnno];
        
        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
}



#pragma mark 列表页面
- (void)toList{
//    [UIView transitionFromView:self.mapView toView:self.tableView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    [self.view bringSubviewToFront:self.tableView];
    
    self.navigationItem.rightBarButtonItems = @[mapBtn,searchBtn];
    mapFlag = NO;
    [self.view insertSubview:_mapView atIndex:0];
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    static NSString *identifier = @"BusinessCell";
    //    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BusinessCell" owner:nil options:nil]objectAtIndex:0];
    }
    
    BusinessTrace *business = [self.dataArray objectAtIndex:[indexPath row]];
    
    if (indexPath.row%2 == 0){
        cell.backgroundColor = RGBColor(234, 234, 234);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.ori1Label.text = business.ori1;
    cell.ori2Label.text = business.ori2;
    cell.des1Label.text = business.des1;
    cell.des2Label.text = business.des2;
    cell.timeLabel.text = [business.stime substringToIndex:10];
    cell.distanceLabel.text = business.distance;
    cell.carNumLabel.text = [NSString stringWithFormat:@"%d辆%@",business.carNum,business.carTypeName];
    cell.comNameLabel.text = business.comName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.typeImage.image = [UIImage imageNamed:@"carType1.png"];
    [cell.typeImage sd_setImageWithURL:[NSURL URLWithString:business.carPic]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BzDetailController *detail = [[BzDetailController alloc]init];
    BusinessTrace *bm = [self.dataArray objectAtIndex:indexPath.row];
    detail.businessId = [NSString stringWithFormat:@"%d",bm.id];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)back{
    [self.mapView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
