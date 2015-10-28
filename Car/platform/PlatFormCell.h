//
//  PlatFormCell.h
//  Car
//
//  Created by Leon on 9/4/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlatFormCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bzLbl;

@property (weak, nonatomic) IBOutlet UILabel *fLbl;

@property (weak, nonatomic) IBOutlet UILabel *newsLbl;
@property (weak, nonatomic) IBOutlet UILabel *tLbl;

@property (weak, nonatomic) IBOutlet UIImageView *comPic1;
@property (weak, nonatomic) IBOutlet UIImageView *comPic2;
@property (weak, nonatomic) IBOutlet UIImageView *comPic3;
@property (weak, nonatomic) IBOutlet UIImageView *comPic4;

@property (weak, nonatomic) IBOutlet UILabel *comName1;
@property (weak, nonatomic) IBOutlet UILabel *comName2;
@property (weak, nonatomic) IBOutlet UILabel *comName3;
@property (weak, nonatomic) IBOutlet UILabel *comName4;

@end
