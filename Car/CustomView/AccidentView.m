//
//  AccidentView.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AccidentView.h"
#import "UIImageView+WebCache.h"

@interface AccidentView()

@property (weak, nonatomic) IBOutlet UITextView *process;
@property (weak, nonatomic) IBOutlet UIImageView *photo1;
@property (weak, nonatomic) IBOutlet UIImageView *photo2;
@property (weak, nonatomic) IBOutlet UIImageView *photo3;


@end

@implementation AccidentView

+ (instancetype) accidentView{
    return [[[NSBundle mainBundle] loadNibNamed:@"AccidentView" owner:nil options:nil] lastObject];
}

- (void)setAccident:(AccidentDetail *)accident{
    _accident = accident;
    _process.text  = _accident.process;
    
    [_photo1 sd_setImageWithURL:[NSURL URLWithString:_accident.photo1] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    [_photo2 sd_setImageWithURL:[NSURL URLWithString:_accident.photo2] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    [_photo3 sd_setImageWithURL:[NSURL URLWithString:_accident.photo3] placeholderImage:[UIImage imageNamed:@"no_pic"]];
}

@end
