//
//  PromptTypeCollectionCell.m
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import "PromptTypeCollectionCell.h"

@implementation PromptTypeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnAddCount.hidden=YES;
    _btnDecreaseCount.hidden=YES;
    _vwBg.layer.borderColor =[UIColor darkGrayColor].CGColor;
    _vwBg.layer.borderWidth = 1;
    _vwBg.backgroundColor = [UIColor clearColor];
}

- (IBAction)btnStepperClicked:(UIButton *)sender {
    int count = [_lblPrompt.text intValue];
    switch (sender.tag) {
            
        case 101://minus 1
            if (count > 0) {
                count--;
                _lblPrompt.text =[NSString stringWithFormat:@"%d",count];
            }
            break;
            
        case 102://Add 1
            count++;
            _lblPrompt.text =[NSString stringWithFormat:@"%d",count];
            
            break;

        default:
            break;
    }
}
@end
