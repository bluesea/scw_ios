//
//  AppDelegate.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "PlatformViewController.h"
#import "TransportScanController.h"
#import "AFNetworkReachabilityManager.h"
#import "CustomNavigationController.h"

#define CATEGORYS       @[@"平台", @"首页", @"运力扫描"]

@interface AppDelegate()

@end

@implementation AppDelegate

+(AppDelegate *)shareAppdelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    _user = [UserModel shareUser];
    
    self.window.backgroundColor = [UIColor whiteColor];
    _tabBarController = [[UITabBarController alloc] init];
//    [self navAndBottom];
    [self initTabbarControllers];
    self.window.rootViewController = _tabBarController;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
    
}


- (void)initTabbarControllers{
    IndexViewController *index = [[IndexViewController alloc]init];
    PlatformViewController *plat = [[PlatformViewController alloc]init];
    TransportScanController *trans = [[TransportScanController alloc] init];
    
    CustomNavigationController *navi1 = [[CustomNavigationController alloc]initWithRootViewController:index];
    CustomNavigationController *navi2 = [[CustomNavigationController alloc]initWithRootViewController:plat];
    CustomNavigationController *navi4 = [[CustomNavigationController alloc]initWithRootViewController:trans];
    
    _tabBarController.viewControllers = @[navi2,navi1,navi4];
    _tabBarController.selectedIndex = 1;
    [self initBarItems];
}

-(void)navAndBottom
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,
                                [UIFont boldSystemFontOfSize:18],
                                NSFontAttributeName,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >6)
//    {
//        [[UITabBarItem appearance] setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIFont boldSystemFontOfSize:12],UITextAttributeFont,
//          [UIColor darkGrayColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//        [[UITabBarItem appearance] setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIFont boldSystemFontOfSize:12],UITextAttributeFont,
//          [UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
//    }
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ) {
        [[UINavigationBar appearance] setBarTintColor:RGBColor(13, 104, 217)];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [self.navigationBar setTranslucent:NO];
    [[UINavigationBar appearance] setTranslucent:NO];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//    }
//    else{
//        //        [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
//        
//    }
}
- (void)initBarItems
{
    /* 初始化TabBar样式 */
    NSArray *tabbarArray = self.tabBarController.tabBar.items;
    //平台，
    for (int i = 0 ; i < [tabbarArray count]; i++) {
        UITabBarItem  *tabBarItem  =  tabbarArray[i];
        tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        NSString *imageName1 = [NSString stringWithFormat:@"nav-foot%d-active",i + 1];
        NSString *imageName2 = [NSString stringWithFormat:@"nav-foot%d",i + 1];
        tabBarItem =  [tabBarItem initWithTitle:CATEGORYS[i] image:[UIImage imageNamed:imageName2] selectedImage:[UIImage imageNamed:imageName1]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //    if ([CLLocationManager significantLocationChangeMonitoringAvailable])
    //    {
    //        // Stop normal location updates and start significant location change updates for battery efficiency.
    ////        [[GlobalVariables locationManager] stopUpdatingLocation];
    ////        [[GlobalVariables locationManager] startMonitoringSignificantLocationChanges];
    //    }
    //    else
    //    {
    //        LSLog(@"Significant location change monitoring is not available.");
    //    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    if (![UserDefaults(SC_AUTO_LOGIN) boolValue]){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

@end
