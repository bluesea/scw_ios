//
//  NewsTrainController.m
//  Car
//
//  Created by Leon on 14-9-20.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "NewsTrainController.h"
#import "NewsIndexViewController.h"

@interface NewsTrainController ()

- (IBAction)newsAction:(UIButton *)sender;

- (IBAction)trainAction:(UIButton *)sender;

@end

@implementation NewsTrainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"新闻培训";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (IBAction)newsAction:(UIButton *)sender {
    NewsIndexViewController *newsIndex = [[NewsIndexViewController alloc]init];
    newsIndex.board = 1;
    [self.navigationController pushViewController:newsIndex animated:YES];
}

- (IBAction)trainAction:(UIButton *)sender {
    NewsIndexViewController *newsIndex = [[NewsIndexViewController alloc]init];
    newsIndex.board = 2;
    [self.navigationController pushViewController:newsIndex animated:YES];
}
@end
