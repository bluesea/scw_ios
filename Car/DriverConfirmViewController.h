//
//  DriverConfirmViewController.h
//  Car
//
//  Created by Leon on 10/14/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverConfirmViewController : UIViewController

@property (nonatomic, assign) int driverId;

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet UIView *driverInfoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *codeLbl;
@property (weak, nonatomic) IBOutlet UILabel *comNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *driverTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *cardNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *qualificationNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *licenseNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *mileageLbl;
@property (weak, nonatomic) IBOutlet UILabel *acdntNumLbl;

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UIImageView *cardPhoto;

@property (weak, nonatomic) IBOutlet UIImageView *qualificationPhoto;

@property (weak, nonatomic) IBOutlet UIImageView *licensePhoto;

@property (weak, nonatomic) IBOutlet UIView *bzInfoView;

@property (weak, nonatomic) IBOutlet UILabel *ori2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *des2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *stimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;


@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *bzFollowBtn;
- (IBAction)subAction:(UIButton *)sender;

- (IBAction)bzFollowAction:(UIButton *)sender;
@end
