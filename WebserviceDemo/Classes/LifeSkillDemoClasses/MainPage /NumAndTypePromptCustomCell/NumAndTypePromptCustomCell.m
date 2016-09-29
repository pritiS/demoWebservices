//
//  NumAndTypePromptCustomCell.m
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import "NumAndTypePromptCustomCell.h"

@implementation NumAndTypePromptCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValueforCellData:(NSMutableDictionary *)dict stepData:(NSMutableArray *)arrStepData{

    lblPromtingTech.text =[NSString stringWithFormat:@"%@",dict[@"PromptingTech"]];

    //TODO: Get Collection Cell
}
@end
