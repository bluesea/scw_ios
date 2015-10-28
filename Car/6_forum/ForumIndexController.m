//
//  ForumIndexController.m
//  Car
//
//  Created by Leon on 9/1/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumIndexController.h"
#import "ForumRegistController.h"
#import "ForumController.h"
#import "ForumLoginController.h"
#import "AdView.h"
#import "Advert.h"
#import "WebViewController.h"


@interface ForumIndexController () <AdViewDelegate>


- (IBAction)forumAction:(UIButton *)sender;

//@property (weak, nonatomic) IBOutlet AdView *adView;
//@property (nonatomic, strong) NSMutableArray *adverts;

@end

@implementation ForumIndexController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"论坛主页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)forumRegistAction:(UIButton *)sender {
    ForumLoginController *registView = [[ForumLoginController alloc]init];
    [self.navigationController pushViewController:registView animated:YES];
}

- (IBAction)forumAction:(UIButton *)sender {
    ForumController *forum = [[ForumController alloc]init];
    forum.type = sender.tag;
    forum.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:forum animated:YES];
}


@end
