//
//  PromptTypeCollectionCell.h
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptTypeCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPrompt;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCount;
@property (weak, nonatomic) IBOutlet UIButton *btnDecreaseCount;

@property (weak, nonatomic) IBOutlet UIView *vwBg;

- (IBAction)btnStepperClicked:(UIButton *)sender;


@end
