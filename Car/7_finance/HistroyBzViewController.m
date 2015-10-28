//
//  HistroyBzViewController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "HistroyBzViewController.h"
#import "HistoryBzCell.h"

@interface HistroyBzViewController ()

@end

@implementation HistroyBzViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"历史发布情况";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryBzCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryBzCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HistoryBzCell" owner:nil options:nil] objectAtIndex:0 ];
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
