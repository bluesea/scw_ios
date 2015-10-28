//
//  HttpRequest.m
//  InSquare
//
//  Created by ming on 14-6-10.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HttpRequest

+(AFHTTPRequestOperationManager*)sessionmanager{
    static AFHTTPRequestOperationManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"text/html",@"application/json",nil];
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    });
    return manager;
}
+(void)printObject:(NSDictionary*)dic isReq:(BOOL)isReq{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (isReq) {
            
            LSLog(@"\n=====================请求参数==========================\n%@\n======================================================",json);
        }else {
            
            LSLog(@"\n=====================返回数据==========================\n%@\n=====================================================",json);
        }
    }
}
#pragma mark -         HTTP
#pragma mark ------HTTP GET
+(void)startHTTPRequestWithMethod:(NSString *)method
                            param:(NSDictionary*)param
                          success:(RequestSucessBlock)finishBlock
                             fail:(RequestFailBlock)failBlock{
//    if([[AFNetworkReachabilityManager sharedManager] isReachable]){
        NSString *urlstr=[NSString stringWithFormat:@"%@/%@",WEB_SERVICE_URL,method];
        [HttpRequest printObject:param isReq:YES];
        [[self sessionmanager] GET:urlstr
                        parameters:param
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               [HttpRequest printObject:responseObject isReq:NO];
                               finishBlock(responseObject);
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failBlock(error.description);
                               
                           }];
//    } else {
//        [MBProgressHUD showError:@"请检查网络连接"];
//    }

}



#pragma mark ------HTTP POST WITHOUT JSON
+(void)startPostRequestWithMethod:(NSString *)method                //接口方法名
                            param:(NSDictionary*)param              //请求参数
                          success:(RequestSucessBlock)finishBlock   //请求成功
                             fail:(RequestFailBlock)failBlock{      //请求失败

    [self startPostRequestWithMethod:method param:param json:NO success:finishBlock fail:failBlock];
    
}
#pragma mark ------HTTP POST JSON

+(void)startPostRequestWithMethod:(NSString *)method                //接口方法名
                            param:(NSDictionary*)param              //请求参数
                             json:(BOOL)flag
                          success:(RequestSucessBlock)finishBlock   //请求成功
                             fail:(RequestFailBlock)failBlock{      //请求失败
    
//    if([[AFNetworkReachabilityManager sharedManager] isReachable]){
        //接口地址
        NSString *urlstr=[NSString stringWithFormat:@"%@/%@",WEB_SERVICE_URL,method];
        //重组请求参数
        NSMutableDictionary *postdic =[NSMutableDictionary dictionaryWithDictionary:param];
        if(flag){
            [[self sessionmanager] setRequestSerializer: [AFJSONRequestSerializer serializer]];
        } else {
            [[self sessionmanager] setRequestSerializer: [AFHTTPRequestSerializer serializer]];
        }
        //打印参数
        [HttpRequest printObject:postdic isReq:YES];
        [[self sessionmanager] POST:urlstr
                         parameters:postdic
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                [HttpRequest printObject:responseObject isReq:NO];
                                finishBlock(responseObject);
                            }
                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failBlock(error.description);
                            }];

//    } else {
//        [MBProgressHUD showError:@"请检查网络连接"];
//    }
    
}

+ (void)startUploadRequestWithMethod:(NSString *)method
                               param:(NSDictionary *)param
                             fileUrl:(NSArray *)fileArray
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail{
    NSString *urlstr=[NSString stringWithFormat:@"%@/%@",WEB_SERVICE_URL,method];
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:urlstr]];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"text/html",@"application/json",nil];
    
    [manager POST:urlstr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for(NSDictionary *dic in fileArray){
            [formData appendPartWithFileData:UIImageJPEGRepresentation((UIImage*)[dic objectForKey:@"img"], 0) name:[dic valueForKey:@"name"] fileName:@"" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error.description);
    }];
    
}



//请求类
+(HttpRequest *)shareRequst
{
    static HttpRequest* request;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        request = [[HttpRequest alloc] init];
    });
    return request;
}
//+ (NetworkStatus)networkStatus
//{
//    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
//    // NotReachable     - 没有网络连接
//    // ReachableViaWWAN - 移动网络(2G、3G)
//    // ReachableViaWiFi - WIFI网络
//    NSString *str=[NSString stringWithFormat:@"%i",[reachability currentReachabilityStatus]];
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哈哈" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show  ];
//    return [reachability currentReachabilityStatus];
//}


#pragma mark - ---------------------------接口---------------------------------------

#pragma mark - =====================基础数据=====================
/**
 *  获取基础数据
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
#pragma mark 所有基础数据
- (void)getBasedata:(RequestSucessBlock)success
               fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:@"basedata/list"
                                      param:nil
                                    success:success
                                       fail:fail];
}

/**
 *  获取车型列表
 *
 *  @param success 成功
 *  @param fail    失败
 */
#pragma mark 车型列表
- (void)getCarType:(RequestSucessBlock)success
              fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"cartype/list"
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 快递列表
- (void)getCourier:(RequestSucessBlock)success
              fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:@"courier/list" param:nil success:success fail:fail];
}


#pragma mark - =====================登陆页面=====================

#pragma mark 登陆
/**
 *  登录接口
 *
 *  @param userName   用户名
 *  @param userPass   密码
 *  @param success    成功
 *  @param fail       失败
 */
- (void)loginWithNmae:(NSString *)userName
                 pass:(NSString *)userPass
              success:(RequestSucessBlock )success
                 fail:(RequestFailBlock )fail{
    [HttpRequest startPostRequestWithMethod:@"user/login"
                                      param:@{@"username":userName,
                                              @"password":userPass
                                              }
                                    success:success
                                       fail:fail];
}

/**
 *  修改密码
 *
 *  @param userId  用户id
 *  @param oldPwd  旧密码
 *  @param newPwd  新密码
 *  @param success 成功
 *  @param fail    失败
 */
#pragma mark 修改密码
- (void)changePwdWithUserId:(NSString *)userId
                     oldPwd:(NSString *)oldPwd
                     newPwd:(NSString *)newPwd
                    success:(RequestSucessBlock )success
                       fail:(RequestFailBlock )fail{
    [HttpRequest startPostRequestWithMethod:@"user/changePwd"
                                      param:@{@"userId":userId,
                                              @"oldPwd":oldPwd,
                                              @"newPwd":newPwd
                                              }
                                    success:success
                                       fail:fail];
}

/**
 *  上传地理位置
 *
 *  @param userId    userId
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param success   成功
 *  @param fail      失败
 */
#pragma mark 上传地理位置
- (void)catchPositionWithUserId:(NSString *) userId
                      longitude:(NSString *) longitude
                       latitude:(NSString *) latitude
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"position/catchPosition"
                                      param:@{@"userId":userId,
                                              @"longitude":longitude,
                                              @"latitude":latitude
                                              }
                                    success:success
                                       fail:fail];
}



#pragma mark - =====================平台页面=====================
#pragma mark 平台信息展示
- (void)getPlatInfo:(RequestSucessBlock)success
               fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:@"platform/index" param:nil success:success fail:false];
}

#pragma mark - =====================运力扫描=====================
#pragma mark 运力扫描
/**
 *  运力扫描
 *
 *  @param paramDic <#paramDic description#>
 *  @param success  <#success description#>
 *  @param fail     <#fail description#>
 */
- (void)driverScanWith:(NSDictionary *)paramDic
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/scan" param:paramDic success:success fail:fail];
}

#pragma mark - =====================注册=====================

#pragma mark 公司注册
- (void)companyRegistWithParam:(NSDictionary *)param
                     fileArray:(NSArray *)fileArray
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"company/regist" param:param  fileUrl:fileArray success:success fail:fail];
}

#pragma mark 司机报名
/**
 *  司机报名
 *
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)driverApplyWithDic:(NSDictionary *)param success:(RequestSucessBlock)success fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driverApply/add"
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark - =====================身份验证=====================
/**
 *  获取司机数量
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
#pragma mark 获取平台司机数
- (void)getDriverCount:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:@"driver/getCount" param:nil success:success fail:false];
}


/**
 *  身份验证
 *
 *  @param name    姓名
 *  @param cardNo  身份证号
 *  @param success 成功
 *  @param fail    失败
 */
#pragma mark 身份验证
- (void)driverValidWithName:(NSString *)name
                     cardNo:(NSString *)cardNo
                  managerId:(NSString *)managerId
                       page:(NSNumber *)page
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/valid"
                                      param:@{@"name":name,
                                              @"cardNo":cardNo,
                                              @"userId":managerId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}
#pragma mark 身份验证详情

#pragma mark 司机详情
/**
 *  司机详情
 *
 *  @param driverId 司机id
 *  @param userId   管理员id
 *  @param success
 *  @param fail
 */
- (void)getDriverDetailById:(NSString *)driverId
                  managerId:(NSString *)userId
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/detail"
                                      param:@{
                                              @"driverId":driverId,
                                              @"userId":userId
                                              }
                                    success:success
                                       fail:fail];
}


#pragma mark 身份验证确认承运
/**
 *  身份验证确认承运
 *
 *  @param orderId 订单编号
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)orderConfirmTransByOrderId:(NSString *)orderId
                           success:(RequestSucessBlock)success
                              fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:[NSString stringWithFormat:@"order/confirmTrans/%@",orderId ] param:nil success:success fail:false];
    
}

#pragma mark - =====================业务浏览=====================
#pragma mark 面议业务列表（运力管理）
/**
 *  业务浏览
 *
 *  @param page
 *  @param formName
 *  @param success
 *  @param fail
 */
- (void) getBzListFtFByPage:(NSNumber *)page
                   formName:(NSString *)formName
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/ftfPage"
                                      param:@{
                                              @"page": page,
                                              @"formName" : formName
                                             }
                                    success:success
                                       fail:fail];
}
#pragma mark 运力型管理员抢单
- (void) grabEndorseWithBzId:(NSString *)busiId
                      userId:(NSString *)userId
                       money:(NSString *)money
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/grabEndorse"
                                      param:@{
                                              @"busiId": busiId,
                                              @"userId" : userId,
                                              @"money" :money
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark - =====================送车链接=====================

#pragma mark  送车链接业务列表
/**
 *  送车链接业务列表
 *
 *  @param page      页码
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param carType   车型
 *  @param ori1      始发省
 *  @param ori2      始发市
 *  @param ori3      始发县区
 *  @param des1      目的省
 *  @param des2      目的市
 *  @param des3      目的县区
 *  @param stime     出发时间
 */
- (void)getSendCarLinkByPage:(NSNumber *)page
                   longitude:(NSNumber *)longitude
                    latitude:(NSNumber *)latitude
                     carType:(NSString *)carType
                        ori1:(NSString *)ori1
                        ori2:(NSString *)ori2
                        ori3:(NSString *)ori3
                        des1:(NSString *)des1
                        des2:(NSString *)des2
                        des3:(NSString *)des3
                       stime:(NSString *)stime
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/getSendCarLink"
                                      param:@{
                                              @"page": page,
                                              @"mylat": latitude,
                                              @"mylng": longitude,
                                              @"carTypeName": carType== nil? @"":carType,
                                              @"ori1": ori1== nil? @"":ori1,
                                              @"ori2": ori2== nil? @"":ori2,
                                              @"ori3": ori3== nil? @"":ori3,
                                              @"des1": des1== nil? @"":des1,
                                              @"des2": des2== nil? @"":des2,
                                              @"des3": des3== nil? @"":des3,
                                              @"stime": stime== nil? @"":stime
                                              }
                                    success:success
                                       fail:fail];
}
#pragma mark 业务详情
/**
 *  业务详情
 *
 *  @param businessId 业务id
 */
- (void) getBzDetailById:(NSString *)businessId
                 success:(RequestSucessBlock) success
                    fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"business/detail/%@",businessId]
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 司机抢单
/**
 *  抢单
 *
 *  @param userId  司机id
 *  @param bzId    业务id
 *  @param carNum  运输车数量
 *  @param success 成功
 *  @param fail    失败
 */
- (void) grabBzWithUserId:(NSString *)userId
               businessId:(NSString *)bzId
                   carNum:(NSString *)carNum
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/grab"
                                      param:@{
                                              @"userId":userId,
                                              @"busiId":bzId,
                                              @"carNum":carNum}
                                    success:success
                                       fail:fail];
}


#pragma mark - =====================新闻培训=====================
#pragma mark 新闻菜单
- (void) getNewsMenuWithBoard:(NSInteger)boardId
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"news/menu/%d",boardId]
                                      param:nil
                                    success:success
                                       fail:fail];
}
#pragma mark 新闻列表
/**
 *  新闻列表
 *
 *  @param typeId  <#typeId description#>
 *  @param page    <#page description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void) getNewsListWithTypeId:(NSInteger)typeId
                          page:(NSInteger)page
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"news/list"
                                      param:@{
                                              @"typeId":[NSNumber numberWithInt:typeId],
                                              @"page":[NSNumber numberWithInt:page]}
                                    success:success
                                       fail:fail];
    
}

#pragma mark 获取新闻详情
- (void)getNewsDetailWithParam:(NSDictionary *)param
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail;{
    [HttpRequest startPostRequestWithMethod:@"news/detail"
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark 评论新闻
- (void)replyNewsWithParam:(NSDictionary *)param
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"news/reply"
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark - =====================论坛交流=====================

#pragma mark 获取论坛验证码
- (void)getBbsValidCodeWithPhone:(NSString *)phone
                         success:(RequestSucessBlock) success
                            fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/getValidCode"
                                      param:@{
                                              @"phone":phone}
                                    success:success
                                       fail:fail];
}


#pragma mark 论坛注册
- (void)bbsRegistWithName:(NSString *)bbsName
                 nickName:(NSString *)nickName
                 password:(NSString *)password
                    phone:(NSString *)phone
                validCode:(NSString *)validCode
                   userId:(NSString *)userId
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/regist"
                                      param:@{@"bbsName":bbsName,
                                              @"nickName":nickName,
                                              @"password":password,
                                              @"phone":phone,
                                              @"validCode":validCode,
                                              @"userId":userId}
                                    success:success
                                       fail:fail];
}

#pragma mark 论坛注册
/**
 *  <#Description#>
 *
 *  @param bbsUser   论坛用户
 *  @param validCode <#validCode description#>
 *  @param userId    <#userId description#>
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)bbsRegistWithBbsUser:(NSDictionary *)bbsUser
                   validCode:(NSString *)validCode
                      userId:(NSString *)userId
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    NSString *requestPath;
    if ([userId isEqualToString:@""]){
        requestPath = [NSString stringWithFormat:@"bbs/regist?validCode=%@",validCode];
    } else {
        requestPath = [NSString stringWithFormat:@"bbs/regist?validCode=%@&userId=%@",validCode,userId];
    }
    [HttpRequest startPostRequestWithMethod:requestPath
                                      param:bbsUser
                                    success:success
                                       fail:fail];
    
}

#pragma mark 论坛登录
/**
 *  论坛登录
 *
 *  @param bbsName  用户名
 *  @param password 密码
 *  @param success  <#success description#>
 *  @param fail     <#fail description#>
 */
- (void)bbsLoginWithBbsName:(NSString *)bbsName
                   password:(NSString *)password
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/login"
                                      param:@{@"bbsName":bbsName,
                                              @"password":password}
                                    success:success
                                       fail:fail];}

#pragma mark 论坛列表
/**
 *  论坛列表
 *
 *  @param type    论坛类型
 *  @param page    页码
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getBbsListWithType:(NSString *)type
                      page:(NSString *)page
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/list"
                                      param:@{@"type":type,
                                              @"page":page}
                                    success:success
                                       fail:fail];
}

#pragma mark 论坛详情
/**
 *  论坛帖子详情
 *
 *  @param bbspostId 论坛帖子编号
 *  @param userId    用户编号
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)getBbsTopicDetailWithParam:(NSDictionary *)param
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail{
    
    [HttpRequest startPostRequestWithMethod:@"bbs/detail"
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark 发表新帖
/**
 *  发表新帖
 *
 *  @param title     标题
 *  @param type      内容
 *  @param content   帖子内容
 *  @param bbsuserId 论坛用户id
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)pulishNewBbsTopicWithTitle:(NSString *)title
                              type:(NSString *)type
                           content:(NSString *)content
                         bbsuserId:(NSString *)bbsuserId
                           success:(RequestSucessBlock)success
                              fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/publish"
                                      param:@{@"title":title,
                                              @"type":type,
                                              @"content":content,
                                              @"bbsuserId":bbsuserId}
                                    success:success
                                       fail:fail];
}

#pragma mark 回帖
/**
 *  回帖
 *
 *  @param pid       帖子编号
 *  @param bbsuserId 用户编号
 *  @param content   内容
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)replyBbsTopicWithPid:(NSString *)pid
                   bbsuserId:(NSString *)bbsuserId
                     content:(NSString *)content
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/reply"
                                      param:@{@"pid":pid,
                                              @"userId":bbsuserId,
                                              @"content":content}
                                    success:success
                                       fail:fail];
}




#pragma mark - =====================会员中心 通用=====================
#pragma mark 会员中心展示
- (void)showMyCenterWithId:(NSString *) userId
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"myCenter/detail/%@",userId]
                                      param:nil
                                    success:success
                                       fail:fail];
}
#pragma mark 消息列表
/**
 *  消息列
 *
 *  @param userId  <#userId description#>
 *  @param page    <#page description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getMessageListWithId:(NSString *)userId
                        page:(NSNumber *)page
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"message/myList"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}
#pragma mark 消息查看
#pragma mark 消息删除
- (void)deleteMsgWithId:(NSInteger)msgId
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"message/delete/%d",msgId]
                                      param:nil
                                    success:success
                                       fail:fail];
}
#pragma mark 银行账号列表
- (void)getAccountListById:(NSString *)userId
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"account/getList"
                                      param:@{
                                              @"userId":userId
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 保存银行账号
- (void)addAccountByUserId:(NSString *)userId
                  bankName:(NSString *)bankName
                   accName:(NSString *)accName
                     accNo:(NSString *)accNo
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"account/add"
                                      param:@{
                                              @"userId":userId,
                                              @"bankName":bankName,
                                              @"accNo":accNo,
                                              @"accName":accName
                                              }
                                    success:success
                                       fail:fail];
}
#pragma mark 删除银行账号
- (void)deleteAccountById:(NSInteger)accountId
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"account/delete/%d",accountId]
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 我的论坛
- (void)getMyBbsListWithId:(NSString *)userId
                    isMain:(NSString *)isMain
                      page:(NSString *)page
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"bbs/myList"
                                      param:@{
                                              @"userId":userId,
                                              @"isMain":isMain,
                                              @"page":page}
                                    success:success
                                       fail:fail];
}

#pragma mark 个人资料
- (void)getUserInfoWithUserId:(NSString *)userId
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"user/info/%@",userId] param:nil success:success fail:fail];
}

- (void)getFinanceManagerDataWithUserId:(NSString *)userId
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail
{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"accCenter/detail/%@",userId] param:nil success:success fail:fail];
}

#pragma mark - =====================会员中心 司机=====================
#pragma mark 我的全部订单
#pragma mark 我的未出发订单
#pragma mark 我的未付款订单
/**
 *  我的订单
 *
 *  @param userId
 *  @param page
 *  @param success
 *  @param fail
 */
- (void) getMyBzListWithId:(NSString *)userId
                      page:(NSString *)page
                      type:(int)type
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    NSString *request;
    switch (type) {
        case 0:
            request = @"order/myAllBusiList";
            break;
        case 1:
            request = @"order/myUnstartBusiList";
            break;
        case 2:
            request =@"order/myUnpayBusiList";
            break;
        default:
            break;
    }
    
    [HttpRequest startPostRequestWithMethod:request
                                      param:@{
                                              @"userId":userId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 订单查看
/**
 *  订单查看
 *
 *  @param orderId orderId
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
-  (void)getOrderDetailById:(NSString *)orderId
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startHTTPRequestWithMethod:[NSString stringWithFormat:@"order/detail/%@",orderId]
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 附近业务
/**
 *  附近业务
 *
 *  @param userId    用户id
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param page      页数
 *  @param success
 *  @param fail
 */
- (void)getNearbyBusinessById:(NSString *)userId
                longitude:(NSString *) longitude
                 latitude:(NSString *) latitude
                     page:(NSNumber *)page
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/getMyBusis"
                                      param:@{
                                              @"userId":userId,
                                              @"mylat":latitude,
                                              @"mylng":longitude,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 运力流向录入
/**
 *  运力流向
 *
 *  @param param   param description
 *  @param success success description
 *  @param fail    fail description
 */
- (void)flowAddWithDic:(NSDictionary *)param
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"flow/savaorupdate?userId=%@",UserDefaults(@"userId")]
                                      param:param
                                    success:success
                                       fail:fail];
}


#pragma mark  事故录入
- (void)accidentRecord:(NSDictionary *)param
                 files:(NSArray *)fileArray
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail{
    
    [HttpRequest startUploadRequestWithMethod:@"accident/record" param:param fileUrl:fileArray  success:success fail:fail];
    
}

#pragma mark 回单寄回
- (void)sendReceiptWith:(NSDictionary *)param
                  files:(NSArray *)fileArray
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"order/sendReceipt" param:param fileUrl:fileArray  success:success fail:fail];
}

#pragma mark 确认收货
- (void)orderAcceptWith:(NSDictionary *)param
                  files:(NSArray *)fileArray
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"order/accept" param:param fileUrl:fileArray  success:success fail:fail];
}

#pragma mark 修改司机个人资料
- (void)driverModifyWithParam:(NSDictionary *)param
                    fileArray:(NSArray *)fileArray
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"driver/modify"
                                        param:param
                                      fileUrl:fileArray
                                      success:success
                                         fail:fail];
}



#pragma mark - =====================会员中心 管理通用=====================
#pragma mark 业务管理
- (void)getBusinessForCompanyWithUserId:(NSString *)userId
                                   page:(NSString *)page
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"business/getForCompany"
                                      param:@{@"userId":userId,
                                              @"page":page}
                                    success:success
                                       fail:fail];
}

- (void)getBusinessDetailForModifyWithId:(NSString *)bzId
                                 success:(RequestSucessBlock) success
                                    fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"business/detailForModify/%@",bzId ]
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 业务发布修改
/**
 *  发布业务
 *
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)savaorupdateBzWithParam:(NSDictionary *)param
                         userId:(NSString*)userId
                        success:(RequestSucessBlock)success fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"business/savaorupdate?userId1=%@",userId]
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark 批单列表
- (void)getEndorsePageForCheckWithPage:(NSString *)page
                                userId:(NSString *)userId
                               success:(RequestSucessBlock) success
                                  fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"endorse/pageForCheck"
                                      param:@{
                                              @"page":page,
                                              @"userId":userId
                                              }
                                    success:success
                                       fail:fail];
    
}
#pragma mark 发布资讯
/**
 *  发布资讯
 *
 *  @param title   资讯标题
 *  @param content 资讯内容
 *  @param userId  发布人id
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)publishNewsWithTitle:(NSString *)title
                     content:(NSString *)content
                      userId:(NSString *)userId
                     success:(RequestSucessBlock )success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"news/publish"
                                      param:@{
                                              @"title":title,
                                              @"content":content,
                                              @"userId":userId
                                              }
                                    success:success
                                       fail:fail];
}
#pragma mark 发布通知
/**
 *  发布通知
 *
 *  @param title   通知标题
 *  @param content 通知内容
 *  @param userId  发布人id
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)publishNoticeWithTitle:(NSString *)title
                       content:(NSString *)content
                        userId:(NSString *)userId
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"notice/publish"
                                      param:@{
                                              @"title":title,
                                              @"content":content,
                                              @"userId":userId
                                              }
                                    success:success
                                       fail:fail];
    
}

#pragma mark 获取司机提醒设置
- (void)getRemindConfByDriverId:(NSString *)driverId
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"remindConf/detail"
                                      param:@{
                                              @"driverId":driverId
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 保存司机提醒设置
- (void)saveRemindByDriverId:(NSString *)driverId
                     speedId:(NSString *)speedId
                     hourIds:(NSString *)hourIds
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"remindConf/saveorupdate"
                                      param:@{
                                              @"driverId":driverId,
                                              @"speedId":speedId,
                                              @"hourIds":hourIds
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 员工维护
/**
 *  员工维护列表
 *
 *  @param userId  当前登录用户id
 *  @param page    页数
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getManagerForCompanyWithId:(NSString *)userId
                              page:(NSString *)page
                           success:(RequestSucessBlock)success
                              fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"manager/getForCompany"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 启用停用员工
/**
 *  启用停用员工
 *
 *  @param managerId 员工编号
 *  @param status    状态
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)managerSwitchWithId:(NSString *)managerId
                     status:(NSString *)status
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"manager/switch"
                                      param:@{
                                              @"managerId":managerId,
                                              @"status":status
                                              }
                                    success:success
                                       fail:fail];
}


#pragma mark 添加员工
/**
 *  添加员工
 *
 *  @param param   员工字典
 *  @param userId  用户id
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)addManagerWithParam:(NSDictionary *)param
                     userId:(NSString *)userId
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"manager/add?userId=%@",userId]
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark 公司资料
- (void)getCompanyInfoWithId:(NSString *)comId
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"company/info/%@",comId]
                                      param:nil
                                    success:success
                                       fail:fail];
}

#pragma mark 修改公司资料
- (void)modifyCompyInfoWithParam:(NSDictionary *)param
                           files:(NSArray *)files
                         success:(RequestSucessBlock)success
                            fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"company/modify"
                                        param:param
                                      fileUrl:files
                                      success:success
                                         fail:fail];
}

- (void)managerModifyWithParam:(NSDictionary *)param
                     fileArray:(NSArray *)fileArray
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail{
    [HttpRequest startUploadRequestWithMethod:@"manager/modify"
                                        param:param
                                      fileUrl:fileArray
                                      success:success
                                         fail:fail];
}

#pragma mark 订单管理
- (void)getOrderForCompanyWithUserId:(NSString *)userId
                                page:(NSString *)page
                                type:(NSString *)type
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"order/getForCompany"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page,
                                              @"type":type}
                                    success:success
                                       fail:fail];
}

#pragma mark 订单详情
- (void)getOrderInfoWithOrderId:(NSString *)orderId
                         userId:(NSString *)userId
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"order/info"
                                      param:@{
                                              @"orderId":orderId,
                                              @"userId":userId
                                            }
                                    success:success
                                       fail:fail];
}


#pragma mark 订单管理状态变更
- (void)orderCheckWithOrderId:(NSString *)orderId
                       userId:(NSString *)userId
                         type:(NSString *)type
                        value:(NSString *)value
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"order/check"
                                      param:@{@"orderId":orderId,
                                              @"userId":userId,
                                              @"type":type,
                                              @"value":value}
                                    success:success
                                       fail:fail];
}



#pragma mark - =====================会员中心 动力管理员=====================
#pragma mark 批单管理详情
- (void)getEndorseDetailForTraWithId:(NSString *)endorseId
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"endorse/detailForTra/%@",endorseId]
                                      param:nil
                                    success:success
                                       fail:fail];
}
#pragma mark 批单领队搜索
- (void)endorseSearchHeadWithName:(NSString *)name
                           cardNo:(NSString *)cardNo
                           userId:(NSString *)userId
                             page:(NSNumber *)page
                          success:(RequestSucessBlock)success
                             fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"endorse/seachHead"
                                      param:@{
                                              @"name":name,
                                              @"cardNo":cardNo,
                                              @"userId":userId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 批单领队指派
- (void)endorseAppointHeadWithDrirverId:(NSString *)driverId
                              endorseId:(NSString *)endorseId
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"endorse/appointHead"
                                      param:@{
                                              @"driverId":driverId,
                                              @"endorseId":endorseId
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 司机维护
/**
 *  司机维护列表
 *
 *  @param userId  当前登录用户id
 *  @param page    页数
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getDriverForCompanyWithId:(NSString *)userId
                              page:(NSString *)page
                             name:(NSString *)name
                           cardNo:(NSString *)cardNo
                           success:(RequestSucessBlock)success
                              fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/getForCompany"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page,
                                              @"name":name,
                                              @"cardNo":cardNo
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 司机扫描
/**
 *  司机维护列表
 *
 *  @param userId  当前登录用户id
 *  @param page    页数
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)scanDriverForCompanyWithId:(NSString *)userId
                              page:(NSString *)page
                              name:(NSString *)name
                            cardNo:(NSString *)cardNo
                           success:(RequestSucessBlock)success
                              fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/scanForCompany"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page,
                                              @"name":name,
                                              @"cardNo":cardNo
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 启用停用司机
/**
 *  启用停用司机
 *
 *  @param driverId  员工编号
 *  @param status    状态
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)driverSwitchWithId:(NSString *)driverId
                    status:(NSString *)status
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"driver/switch"
                                      param:@{
                                              @"driverId":driverId,
                                              @"status":status
                                              }
                                    success:success
                                       fail:fail];
}

#pragma mark 添加司机
/**
 *  添加司机
 *
 *  @param param   司机字典
 *  @param userId  用户id
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)addDriverWithParam:(NSDictionary *)param
                    userId:(NSString *)userId
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"driver/add?userId=%@",userId]
                                      param:param
                                    success:success
                                       fail:fail];
}

#pragma mark 事故查询
- (void)getAccidentForCompang:(NSString *)userId
                         page:(NSString *)page
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"accident/getForCompany"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page}
                                    success:success
                                       fail:fail];
}

#pragma mark 事故详情
- (void) getAccidentDetialWithId:(NSInteger)accidentId
                         success:(RequestSucessBlock)success
                            fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"accident/detail/%d",accidentId] param:nil success:success fail:fail];
}

#pragma mark 业务追踪
- (void) orderBzTraceWithUserId:(NSString *)userId
                           page:(NSString *)page
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"order/busiTrace"
                                      param:@{
                                              @"userId":userId,
                                              @"page":page
                                              }
                                    success:success
                                       fail:fail];
}



#pragma mark - =====================会员中心 资源管理员=====================

#pragma mark 批单审核详情
- (void)getEndorseDetailForResWithId:(NSString *)endorseId
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:[NSString stringWithFormat:@"endorse/detailForRes/%@",endorseId]
                                      param:nil
                                    success:success
                                       fail:fail];
}
#pragma mark 批单处理详情
- (void)endorseCheckWithEndorseId:(int )endorseId
                       auditValue:(NSString *)auditValue
                          success:(RequestSucessBlock)success
                             fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"/endorse/check"
                                      param:@{
                                              @"endorseId":[NSString stringWithFormat:@"%d",endorseId],
                                              @"auditValue":auditValue
                                              }
                                    success:success
                                       fail:fail];
}


#pragma mark - ====================== 广告 ===============================
- (void)getAdvListWithType:(NSString *)type
                   success:(RequestSucessBlock) success
                      fail:(RequestFailBlock)fail{
    [HttpRequest startPostRequestWithMethod:@"adv/getList" param:@{@"type":type} success:success fail:fail];
}


#pragma mark - ===================== - End - ============================


@end