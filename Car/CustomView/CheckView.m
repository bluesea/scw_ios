//
//  CheckView.m
//  Car
//
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "CheckView.h"
@interface CheckView()

@property (weak, nonatomic) IBOutlet UILabel *resCheckname;
@property (weak, nonatomic) IBOutlet UILabel *traCheckname;

@end

@implementation CheckView

+ (instancetype) checkView{
    return [[[NSBundle mainBundle] loadNibNamed:@"CheckView" owner:nil options:nil] lastObject];
}

- (void)setCheck:(Check *)check{
    _check = check;
    _resCheckname.text = _check.resCheckName;
    _traCheckname.text = _check.traCheckName;
}

@end
