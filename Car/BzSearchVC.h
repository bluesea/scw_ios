//
//  BzSearchVC.h
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

#define ORI1    10
#define ORI2    11
#define ORI3    12
#define DES1    20
#define DES2    21
#define DES3    22
#define CARTYPE 30

typedef void(^ReturnTextBlock) (NSDictionary *dic);

@interface BzSearchVC : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) ReturnTextBlock block;

@property (nonatomic,strong) NSMutableDictionary *paramDic;
@property (nonatomic,strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet CustomTextField *ori1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori3Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des3Field;
@property (weak, nonatomic) IBOutlet CustomTextField *carTypeField;
@property (weak, nonatomic) IBOutlet CustomTextField *stimeField;

@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *dataPicker;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

- (IBAction)searchAction:(UIButton *)sender;
@end
