//
//  HttpRequest.h
//  InSquare
//
//  Created by ming on 14-6-10.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import ""

typedef void (^RequestSucessBlock) (id obj);
typedef void (^RequestFailBlock) (NSString* errorMsg);

#define WEB_SERVICE_URL @"http://121.40.177.96/songche/ws"

//#define WEB_SERVICE_URL @"http://192.168.1.109:4040/OcEntry"

@interface HttpRequest : NSObject

/**
 *  接口请求对象
 *
 *  @return HttpRequest
 */
+ (HttpRequest *)shareRequst;

/**
 *  判断网络状态
 *
 *  @return NetworkStatus
 */
//+ (NetworkStatus)networkStatus;

/**
 *  开始请求
 *
 *  @param param       请求参数
 *  @param finishBlock 成功
 *  @param failBlock   失败
 */
+(void)startHTTPRequestWithMethod:(NSString *)method
                            param:(NSDictionary*)param
                          success:(RequestSucessBlock)finishBlock
                             fail:(RequestFailBlock)failBlock;
//#pragma mark ----------------------------
#pragma mark - ---------------------------接口---------------------------------------

#pragma mark - =====================基础数据=====================

#pragma mark 所有基础数据
- (void)getBasedata:(RequestSucessBlock)success
               fail:(RequestFailBlock)fail;
#pragma mark 车型列表
- (void)getCarType:(RequestSucessBlock)success
              fail:(RequestFailBlock)fail;
#pragma mark 快递列表
- (void)getCourier:(RequestSucessBlock)success
              fail:(RequestFailBlock)fail;



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
                fail:(RequestFailBlock )fail;

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
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail;

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
                           fail:(RequestFailBlock)fail;

#pragma mark - =====================平台页面=====================
#pragma mark 平台信息展示
- (void)getPlatInfo:(RequestSucessBlock)success
               fail:(RequestFailBlock)fail;


#pragma mark - =====================运力扫描=====================
#pragma mark 运力扫描
/**
 *  运力扫描
 *
 *  @param paramDic paramDic description
 *  @param success  success description
 *  @param fail     fail description
 */
- (void)driverScanWith:(NSDictionary *)paramDic
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail;



#pragma mark - =====================注册=====================

#pragma mark 公司注册
- (void)companyRegistWithParam:(NSDictionary *)param
                     fileArray:(NSArray *)fileArray
                       success:(RequestSucessBlock)success
                          fail:(RequestFailBlock)fail;

#pragma mark 司机报名
/**
 *  司机报名
 *
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)driverApplyWithDic:(NSDictionary *)param
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;


#pragma mark - =====================身份验证=====================
/**
 *  获取司机数量
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
#pragma mark 获取平台司机数
- (void)getDriverCount:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail;


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
                       fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;


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
                              fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;
#pragma mark 运力型管理员抢单
/**
 *  运力型管理员抢单
 *
 *  @param busiId  业务编号
 *  @param userId  用户编号
 *  @param money   报价
 *  @param success success description
 *  @param fail    fail description
 */
- (void) grabEndorseWithBzId:(NSString *)busiId
                      userId:(NSString *)userId
                       money:(NSString *)money
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail;



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
                        fail:(RequestFailBlock)fail;
#pragma mark 业务详情
/**
 *  业务详情
 *
 *  @param businessId 业务id
 */
- (void) getBzDetailById:(NSString *)businessId
                 success:(RequestSucessBlock) success
                    fail:(RequestFailBlock)fail;

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
                     fail:(RequestFailBlock)fail;

#pragma mark - =====================新闻培训=====================
#pragma mark 新闻菜单
- (void) getNewsMenuWithBoard:(NSInteger)boardId
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail;
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
                          fail:(RequestFailBlock)fail;

#pragma mark 获取新闻详情
- (void)getNewsDetailWithParam:(NSDictionary *)param
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail;

#pragma mark 评论新闻
- (void)replyNewsWithParam:(NSDictionary *)param
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;



#pragma mark - =====================论坛交流=====================
#pragma mark 获取论坛验证码
/**
 *  获取论坛验证码
 *
 *  @param phone   手机号码
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getBbsValidCodeWithPhone:(NSString *)phone
                         success:(RequestSucessBlock) success
                            fail:(RequestFailBlock)fail;

#pragma mark 论坛注册
/**
 *  论坛注册
 *
 *  @param bbsName   论坛用户名
 *  @param nickName  论坛昵称
 *  @param password  密码
 *  @param phone     手机号
 *  @param validCode 验证码
 *  @param userId    用户ID
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)bbsRegistWithName:(NSString *)bbsName
                 nickName:(NSString *)nickName
                 password:(NSString *)password
                    phone:(NSString *)phone
                validCode:(NSString *)validCode
                   userId:(NSString *)userId
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail;

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
                        fail:(RequestFailBlock)fail;


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
                       fail:(RequestFailBlock)fail;

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
                      fail:(RequestFailBlock)fail;

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
                           fail:(RequestFailBlock)fail;

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
                              fail:(RequestFailBlock)fail;

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
                        fail:(RequestFailBlock)fail;


#pragma mark - =====================会员中心 通用=====================
#pragma mark 会员中心展示
- (void)showMyCenterWithId:(NSString *) userId
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;
#pragma mark 消息列表
/**
 *  消息列表
 *
 *  @param userId  <#userId description#>
 *  @param page    <#page description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getMessageListWithId:(NSString *)userId
                        page:(NSNumber *)page
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail;
#pragma mark 消息查看
#pragma mark 消息删除
- (void)deleteMsgWithId:(NSInteger)msgId
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail;
#pragma mark 银行账号列表
- (void)getAccountListById:(NSString *)userId
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;

#pragma mark 保存银行账号
- (void)addAccountByUserId:(NSString *)userId
                  bankName:(NSString *)bankName
                   accName:(NSString *)accName
                     accNo:(NSString *)accNo
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;

#pragma mark 删除银行账号
- (void)deleteAccountById:(NSInteger)accountId
                  success:(RequestSucessBlock)success
                     fail:(RequestFailBlock)fail;

#pragma mark 我的论坛
- (void)getMyBbsListWithId:(NSString *)userId
                    isMain:(NSString *)isMain
                      page:(NSString *)page
                   success:(RequestSucessBlock)success
                      fail:(RequestFailBlock)fail;

#pragma mark 个人资料
- (void)getUserInfoWithUserId:(NSString *)userId
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail;

#pragma mark 财务数据
- (void)getFinanceManagerDataWithUserId:(NSString *)userId
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail;

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
                      fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;


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
                     fail:(RequestFailBlock)fail;

#pragma mark 运力流向录入
/**
 *  运力流向
 *
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)flowAddWithDic:(NSDictionary *)param
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail;


#pragma mark  事故录入
- (void)accidentRecord:(NSDictionary *)param
                 files:(NSArray *)fileArray
               success:(RequestSucessBlock)success
                  fail:(RequestFailBlock)fail;

#pragma mark 回单寄回
- (void)sendReceiptWith:(NSDictionary *)param
                  files:(NSArray *)fileArray
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail;

#pragma mark 确认收货
- (void)orderAcceptWith:(NSDictionary *)param
                  files:(NSArray *)fileArray
                success:(RequestSucessBlock)success
                   fail:(RequestFailBlock)fail;


#pragma mark 修改司机个人资料
//- (void)driverModifyWith:(NSString *)userId
//                   param:(NSDictionary *)param
//               fileArray:(NSArray *)fileArray
//                 success:(RequestSucessBlock)success
//                    fail:(RequestFailBlock)fail;

- (void)driverModifyWithParam:(NSDictionary *)param
               fileArray:(NSArray *)fileArray
                 success:(RequestSucessBlock)success
                    fail:(RequestFailBlock)fail;


#pragma mark - =====================会员中心 管理通用=====================

#pragma mark 业务管理
- (void)getBusinessForCompanyWithUserId:(NSString *)userId
                                   page:(NSString *)page
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail;

- (void)getBusinessDetailForModifyWithId:(NSString *)bzId
                                 success:(RequestSucessBlock) success
                                    fail:(RequestFailBlock)fail;

#pragma mark 业务发布修改
/**
 *  发布业务
 *
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)savaorupdateBzWithParam:(NSDictionary *)param
                         userId:(NSString *)userId
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail;

#pragma mark 批单列表
/**
 *  批单列表
 *
 *  @param page    页码
 *  @param userId  管理员用户id
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)getEndorsePageForCheckWithPage:(NSString *)page
                                userId:(NSString *)userId
                               success:(RequestSucessBlock) success
                                  fail:(RequestFailBlock)fail;
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
                        fail:(RequestFailBlock)fail;
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
                     success:(RequestSucessBlock )success
                        fail:(RequestFailBlock)fail;


#pragma mark 获取司机提醒设置
- (void)getRemindConfByDriverId:(NSString *)driverId
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail;

#pragma mark 保存司机提醒设置
- (void)saveRemindByDriverId:(NSString *)driverId
                     speedId:(NSString *)speedId
                     hourIds:(NSString *)hourIds
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail;


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
                              fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;

#pragma mark 公司资料
- (void)getCompanyInfoWithId:(NSString *)comId
                     success:(RequestSucessBlock)success
                        fail:(RequestFailBlock)fail;

#pragma mark 修改公司资料
- (void)modifyCompyInfoWithParam:(NSDictionary *)param
                           files:(NSArray *)files
                         success:(RequestSucessBlock)success
                            fail:(RequestFailBlock)fail;


#pragma mark 修改管理员资料
- (void)managerModifyWithParam:(NSDictionary *)param
                    fileArray:(NSArray *)fileArray
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail;

#pragma mark 订单管理
- (void)getOrderForCompanyWithUserId:(NSString *)userId
                                page:(NSString *)page
                                type:(NSString *)type
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail;

#pragma mark 获取订单详情
- (void)getOrderInfoWithOrderId:(NSString *)orderId
                         userId:(NSString *)userId
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail;

#pragma mark 订单管理状态变更
- (void)orderCheckWithOrderId:(NSString *)orderId
                       userId:(NSString *)userId
                         type:(NSString *)type
                        value:(NSString *)value
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail;



#pragma mark - =====================会员中心 动力管理员=====================
#pragma mark 批单管理详情
/**
 *  批单审核详情
 *
 *  @param endorseId 批单号码
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)getEndorseDetailForTraWithId:(NSString *)endorseId
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail;


#pragma mark 批单领队搜索
/**
 *  批单领队搜索
 *
 *  @param name    司机名称
 *  @param cardNo  司机身份证号
 *  @param userId  管理员编号
 *  @param page    页码
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)endorseSearchHeadWithName:(NSString *)name
                           cardNo:(NSString *)cardNo
                           userId:(NSString *)userId
                             page:(NSNumber *)page
                          success:(RequestSucessBlock)success
                             fail:(RequestFailBlock)fail;



#pragma mark 批单领队指派
/**
 *  批单领队指派
 *
 *  @param driverId  驾驶员编号
 *  @param endorseId 批单编号
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)endorseAppointHeadWithDrirverId:(NSString *)driverId
                              endorseId:(NSString *)endorseId
                                success:(RequestSucessBlock)success
                                   fail:(RequestFailBlock)fail;

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
                             fail:(RequestFailBlock)fail;

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
                             fail:(RequestFailBlock)fail;

#pragma mark 启用停用司机
/**
 *  启用停用司机
 *
 *  @param managerId 员工编号
 *  @param status    状态
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)driverSwitchWithId:(NSString *)driverId
                     status:(NSString *)status
                    success:(RequestSucessBlock)success
                       fail:(RequestFailBlock)fail;

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
                       fail:(RequestFailBlock)fail;

#pragma mark 事故查询
- (void)getAccidentForCompang:(NSString *)userId
                         page:(NSString *)page
                      success:(RequestSucessBlock)success
                         fail:(RequestFailBlock)fail;


#pragma mark 事故详情
- (void) getAccidentDetialWithId:(NSInteger)accidentId
                         success:(RequestSucessBlock)success
                            fail:(RequestFailBlock)fail;


#pragma mark 业务追踪
- (void) orderBzTraceWithUserId:(NSString *)userId
                           page:(NSString *)page
                        success:(RequestSucessBlock)success
                           fail:(RequestFailBlock)fail;


#pragma mark - =====================会员中心 资源管理员=====================
#pragma mark 批单审核详情
/**
 *  批单审核详情
 *
 *  @param endorseId 批单号码
 *  @param success   <#success description#>
 *  @param fail      <#fail description#>
 */
- (void)getEndorseDetailForResWithId:(NSString *)endorseId
                             success:(RequestSucessBlock)success
                                fail:(RequestFailBlock)fail;
#pragma mark 批单审核处理
/**
 *  批单审核处理
 *
 *  @param endorseId  批单编号
 *  @param auditValue 批单状态
 *  @param success    <#success description#>
 *  @param fail       <#fail description#>
 */
- (void)endorseCheckWithEndorseId:(int)endorseId
                       auditValue:(NSString *)auditValue
                          success:(RequestSucessBlock)success
                             fail:(RequestFailBlock)fail;


#pragma mark - ====================== 广告 ===============================
- (void)getAdvListWithType:(NSString *)type
                   success:(RequestSucessBlock) success
                      fail:(RequestFailBlock)fail;


#pragma mark - =====================end=====================




@end
