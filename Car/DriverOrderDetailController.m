//
//  DriverOrderDetailController.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverOrderDetailController.h"
#import "BusinessView.h"
#import "BusinessDetail.h"
#import "OrderAbstract.h"
#import "OrderDetailView.h"


#define PADDING 8

@interface DriverOrderDetailController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (nonatomic, weak) BusinessView *bzView;
@property (nonatomic, weak) OrderDetailView *orderView;


@end

@implementation DriverOrderDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewWidth = mainWidth - 2 * PADDING;
    CGFloat height = 0;
    
    _bzView = [BusinessView businessViewStyle:BzViewStyleWithTime];
    _bzView.frame = CGRectMake(PADDING, PADDING, viewWidth , 120);
    
    [self.mainView addSubview:_bzView];
    _orderView = [OrderDetailView orderView];
    
    _orderView.frame = CGRectMake(PADDING, CGRectGetMaxY(_bzView.frame)+ PADDING , viewWidth, 809);
    
    [self.mainView addSubview:_orderView];
    
    height = CGRectGetMaxY(_orderView.frame) + 8;
    
    _mainView.contentSize = CGSizeMake(0, height + PADDING);

    [self loadData];
    
}

- (void)loadData{
    [[HttpRequest shareRequst]getOrderDetailById:[NSString stringWithFormat:@"%d",_orderId] success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            BusinessDetail *bz = [BusinessDetail businessDetailWithDic:[[obj valueForKey:@"record"]valueForKey:@"order" ] ];
            _orderView.bz  = bz;
            OrderAbstract *order = (OrderAbstract *)bz;
            _bzView.order = order;
        }
    } fail:^(NSString *errorMsg) {
        ;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
