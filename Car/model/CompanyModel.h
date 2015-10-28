//
//  CompanyModel.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

/** 公司名称 */
@property (nonatomic, copy) NSString *name;
/** 注册资金 */
@property (nonatomic, copy) NSString *comMoney;
/** 营业执照代码 */
@property (nonatomic, copy) NSString *licenseNo;
/** 税务登记代码 */
@property (nonatomic, copy) NSString *taxregNo;
/** 报价 */
@property (nonatomic, copy) NSString *money;
/** 组织机构代码 */
@property (nonatomic, copy) NSString *orgNo;
/** 企业法人 */
@property (nonatomic, copy) NSString *corp;
/** 联系人 */
@property (nonatomic, copy) NSString *contact;
/** 联系手机 */
@property (nonatomic, copy) NSString *contactPhone;
/** 固话 */
@property (nonatomic, copy) NSString *contactTel;
/** 邮编 */
@property (nonatomic, copy) NSString *contactPostcode;
/** 地址 */
@property (nonatomic, copy) NSString *comArea;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 省 */
@property (nonatomic, copy) NSString *province;
/** 市 */
@property (nonatomic, copy) NSString *city;
/** 区 */
@property (nonatomic, copy) NSString *district;
/** 分类名称 */
@property (nonatomic, copy) NSString *comSubTypeName;
/** 大类名称 */
@property (nonatomic, copy) NSString *comTypeName;
/** logo */
@property (nonatomic, copy) NSString *headPicUrl;
/** id */
@property (nonatomic, assign) NSInteger id;
/** 营业执照照片 */
@property (nonatomic, copy) NSString *licensePhoto;
/** 组织机构照片 */
@property (nonatomic, copy) NSString *orgPhoto;
/** 税务登记证照片 */
@property (nonatomic, copy) NSString *taxregPhoto;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) companyWithDic:(NSDictionary *)dic;


@end
