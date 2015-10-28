//
//  AppDelegate.h
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "DriverModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    int count;
    UIBackgroundTaskIdentifier taskId;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UserModel *user;
//@property (strong, nonatomic) ManagerModel *manager;
//@property (strong, nonatomic) DriverModel *driver;
@property (strong, nonatomic) NSString *role;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign,getter = isbbsLogin ) BOOL bbsLogin;

+(AppDelegate *)shareAppdelegate;

@end
