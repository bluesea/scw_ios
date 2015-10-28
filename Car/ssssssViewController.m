//
//  ssssssViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ssssssViewController.h"

-(void)initTabbarControllers
{
    
    RootViewController *root = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    SearchViewController *search = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    BuyCarViewController *buycar=[[BuyCarViewController alloc]initWithNibName:@"BuyCarViewController" bundle:nil];
    UserCenterViewController *myvc=[[UserCenterViewController alloc]initWithNibName:@"UserCenterViewController" bundle:nil];
    MoreViewController *more = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:root];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:search];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:buycar];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:myvc];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:more];
    
    NSArray *controllers=@[nav1,nav2,nav3,nav4,nav5];
    
    _tab=[[UITabBarController alloc]init];
    _tab.viewControllers=controllers;
    _tab.tabBar.backgroundImage=[UIImage imageNamed:@"tab_bg"];
    _tab.tabBar.selectionIndicatorImage=[[UIImage alloc]init];
    _tab.tabBar.selectedImageTintColor=[UIColor blackColor];
    [self initBarItems];
    [self navAndBottom];
    self.window.rootViewController=_tab;
}
-(void)navAndBottom
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,
                                [UIFont boldSystemFontOfSize:18],
                                NSFontAttributeName,nil];
    if (IS_IOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=6)
    {
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont boldSystemFontOfSize:12],UITextAttributeFont,
          [UIColor darkGrayColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont boldSystemFontOfSize:12],UITextAttributeFont,
          [UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    }
    if (IS_IOS7) {
        [[UINavigationBar appearance] setBarTintColor:MainColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }
    else{
        UIImage *img = [UIImage imageNamed:@"nav_bg"];
        [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        
    }
}
- (void)initBarItems{
    /* 初始化TabBar样式 */
    NSArray *tabbarArray  = self.tab.tabBar.items;
    for (int i = 0 ; i < [tabbarArray count]; i++) {
        UITabBarItem  *tabBarItem  =  tabbarArray[i];
        tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
        NSString *imageName1 = [NSString stringWithFormat:@"tab_select%d",i + 1];
        NSString *imageName2 = [NSString stringWithFormat:@"tab%d",i + 1];
        [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:imageName1] withFinishedUnselectedImage:[UIImage imageNamed:imageName2]];
        [tabBarItem setTitle:nil];
    }
    
}