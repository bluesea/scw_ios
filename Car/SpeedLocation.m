////
////  SpeedLocation.m
////  Car
////
////  Created by Leon on 14-9-19.
////  Copyright (c) 2014年 com.cwvs. All rights reserved.
////
//
//#import "SpeedLocation.h"
//
//@implementation SpeedLocation
//
//static SpeedLocation *instance = nil;
//
//+ (SpeedLocation *) shareInstance{
//    
//    {
//        @synchronized (self)
//        {
//            if (instance == nil)
//            {
//                instance= [[self alloc] init];
//            }
//        }
//        return instance;
//    }
//}
//
//- (id)init{
//    self = [super init];
//    if (self){
////        _service = [[CLLocationManager alloc] init];
////        _service.delegate = self;
//    }
//    return  self;
//}
//
//#pragma mark 启动定位
//- (void)start{
//    LSLog(@"-----start location");
//    _timer = [NSTimer scheduledTimerWithTimeInterval: 60 * 5 target:self selector:@selector(notification) userInfo:nil repeats:YES];
//    [_timer fire];
//    [_service startUpdatingLocation];
//    [self sendNotification];
//}
//#pragma mark 停止定位
//- (void)stop{
//    //取消所有的通知
//    [[UIApplication sharedApplication]cancelAllLocalNotifications];
//    [_service stopUpdatingLocation];
//    [_timer invalidate];
//    _timer = nil;
//    _longitude = 0;
//    _latitude = 0;
//    speed = 0;
//}
//
////#pragma mark 定位代理方法
////- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
////    CLLocation *location = locations.lastObject;
////    
////    //获取经纬度
////    _longitude = location.coordinate.longitude;
////    _latitude = location.coordinate.latitude;
////    //获取速度
////    speed = location.speed * 3.6;
////}
////
////- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
////{
////    switch (status) {
////        case kCLAuthorizationStatusNotDetermined:
////            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
////                [manager requestWhenInUseAuthorization];
////            }
////            break;
////    }
////}
//
//
//#pragma mark 超速提醒
//- (void)speedNotification{
//    
////    LSLog(@"---> 超速提醒!");
////    
////    NSString *path = nil;
////    double setSpeed = [self getSettingSpeed];
////    
////    if (speed >= 120 && speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"120" ofType:@"mp3"];
////    }
////    else if (speed >= 110&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"110" ofType:@"mp3"];
////    }
////    else if (speed >= 100&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"100" ofType:@"mp3"];
////    }
////    else if (speed >= 90&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"90" ofType:@"mp3"];
////    }
////    else if (speed >= 80&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"80" ofType:@"mp3"];
////    }
////    else if (speed >= 70&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"70" ofType:@"mp3"];
////    }
////    else if (speed >= 60&& speed >= setSpeed){
////        path = [[NSBundle mainBundle] pathForResource:@"60" ofType:@"mp3"];
////    }
////    
////    if (path != nil){
////        SystemSoundID soundID;
////        //        NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"60" ofType:@"mp3"];
////        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
////        //    AudioServicesPlaySystemSound(soundID);
////        AudioServicesPlayAlertSound(soundID);
////    }
//    
//}
//
//#pragma mark 转换速度提醒设置
//- (double)getSettingSpeed{
//    _speedId = UserDefaults(SC_DRIVER_SPEED);
//    switch (_speedId.intValue) {
//        case  1:
//            return 60;
//            break;
//        case  2:
//            return 70;
//            break;
//        case  3:
//            return 80;
//            break;
//        case  4:
//            return 90;
//            break;
//        case  5:
//            return 100;
//            break;
//        case  6:
//            return 110;
//            break;
//        case  7:
//            return 120;
//            break;
//        default:
//            return 9999;
//            break;
//    }
//}
//
//#pragma mark 转换定时提醒
//- (int)getSettingHour:(NSString *)tag{
//    switch (tag.intValue) {
//        case 0:
//            return 21;
//            break;
//        case  1:
//            return 22;
//            break;
//        case  2:
//            return 23;
//            break;
//        case  3:
//            return 0;
//            break;
//        case  4:
//            return 1;
//            break;
//        case  5:
//            return 2;
//            break;
//        case  6:
//            return 3;
//            break;
//        case  7:
//            return 4;
//            break;
//        default:
//            return -1;
//            break;
//    }
//}
//
//
//#pragma mark 发送通知
//- (void)sendNotification{
////    [[UIApplication sharedApplication]cancelAllLocalNotifications];
////    _hourIds = UserDefaults(SC_DRIVER_HOUR_ALERT);
////    NSArray *array = [_hourIds componentsSeparatedByString:@","];
////    for ( NSString *str in array) {
////        int time = [self getSettingHour:str];
////        [self setNotification:time];
////    }
//    
//}
//
//#pragma mark 通知实现发放
//- (void)setNotification:(int)time{
////    UILocalNotification *notification =[[UILocalNotification alloc] init];
////    if (notification){
////        NSDate *now=[NSDate date];
////        
////        
////        //获得系统日期
////        NSCalendar  * cal=[NSCalendar  currentCalendar];
////        NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
////        NSDateComponents * conponent= [cal components:unitFlags fromDate:now];
////        NSInteger year=[conponent year];
////        NSInteger month=[conponent month];
////        NSInteger day=[conponent day];
////        //NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
////        //获得当天提醒时间
////        NSString  * nsStringDate =  [NSString  stringWithFormat:@"%d-%d-%d-%d-%d-%d",
////                                       year, month,day,time,0, 0  ];
////        
////        //根据时间字符串获得NSDate
////        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
////        [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
////        NSDate  * todayDate=[dateformatter dateFromString:nsStringDate];
////        
////        //然后比较  now跟  todayTwelve那个大，如果已经过了12点，那就设置明天12点
////        NSComparisonResult   dateResult =  [now  compare:todayDate ];
////        if (dateResult ==  NSOrderedDescending  )
////        {
////            NSDate  *  tomorrowDate =  [todayDate  dateByAddingTimeInterval: 24 * 60 * 60];
////            
////            notification.fireDate =  tomorrowDate;
////        }
////        else
////        {
////            notification.fireDate= todayDate;
////        }
////        notification.repeatInterval = kCFCalendarUnitDay;
////        notification.timeZone=[NSTimeZone defaultTimeZone];
////        notification.applicationIconBadgeNumber += 1;
////        notification.soundName = [NSString stringWithFormat:@"%d.mp3",time];
////        
////        notification.alertBody=[NSString stringWithFormat:@"现在是%2d:00,送车网提醒您请注意休息!",time];
////        
//////        notification.alertAction = @"打开";
////        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
////        
////        LSLog(@"---通知发送:%d",time);
////    }
//
//}
//
//
//
//- (void)notification{
//    LSLog(@"--> 10分钟触发!!!!");
//    [self uploadLocation];
//    [self speedNotification];
//    
//}
//
//
//- (void)uploadLocation{
//    LSLog(@"---> 更新地理位置!");
//    if (_longitude != 0 && _latitude != 0){
//        [[HttpRequest shareRequst]catchPositionWithUserId:UserDefaults(@"userId") longitude:[NSString stringWithFormat:@"%f",_longitude] latitude:[NSString stringWithFormat:@"%f",_latitude] success:^(id obj) {
//            LSLog(@"--更新地理位置成功! %@",obj);
//        } fail:^(NSString *errorMsg) {
//        }];
//    }
//}
//
//
//@end
