//
//  TTC_NumberAndTypeOfPrompt.m
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import "TTC_NumberAndTypeOfPrompt.h"
#import "PromptTypeCollectionCell.h"


#define promptTypeCellID @"promptTypeCellID"
#define stepCellID @"StepCellID"

@interface TTC_NumberAndTypeOfPrompt ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation TTC_NumberAndTypeOfPrompt

- (void)viewDidLoad {
    [super viewDidLoad];
    //Register cell
    [collNumberAndTypePrompt registerNib:[UINib nibWithNibName:@"PromptTypeCollectionCell" bundle:nil]  forCellWithReuseIdentifier:promptTypeCellID];
    
    //Create dummy data
    arrStepData = [[NSMutableArray alloc]init];
    arrPromptingTech = [[NSMutableArray alloc]init];
    
    [arrPromptingTech addObject:@{@"PromptingTech":@"Physical"}];
    [arrPromptingTech addObject:@{@"PromptingTech":@"Fully Physical"}];
    [arrPromptingTech addObject:@{@"PromptingTech":@"Faded"}];
//    [arrPromptingTech addObject:@{@"PromptingTech":@"Gesture"}];
//    [arrPromptingTech addObject:@{@"PromptingTech":@"Physical 2"}];
//    [arrPromptingTech addObject:@{@"PromptingTech":@"Fully Physical 2"}];
    
    
    [arrStepData addObject:@{@"StepData":@"Step 1",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
    [arrStepData addObject:@{@"StepData":@"Step 2",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
    [arrStepData addObject:@{@"StepData":@"Step 3",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
    [arrStepData addObject:@{@"StepData":@"Step 4",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
//    [arrStepData addObject:@{@"StepData":@"Step 5",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
//    [arrStepData addObject:@{@"StepData":@"Step 6",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
//    [arrStepData addObject:@{@"StepData":@"Step 7",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
//    [arrStepData addObject:@{@"StepData":@"Step 8",@"Physical":@"1",@"Fully Physical":@"0",@"Faded":@"2",@"Gesture":@"1",@"Physical 2":@"1",@"Fully Physical 2":@"1"}];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[collNumberAndTypePrompt layoutIfNeeded];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Collectionview Delegates and DataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1+arrPromptingTech.count;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return arrStepData.count;
    return 1+arrStepData.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PromptTypeCollectionCell *promptCell = [collectionView dequeueReusableCellWithReuseIdentifier:promptTypeCellID forIndexPath:indexPath];
    promptCell.backgroundColor = [UIColor whiteColor];
    promptCell.btnAddCount.hidden=YES;
    promptCell.btnDecreaseCount.hidden=YES;
   
    
    switch (indexPath.section) {
            
        case 0:{//for First Section i.e. headers
            
            switch (indexPath.row) {
                case 0: //prompt
                {
                    promptCell.lblPrompt.font = [UIFont boldSystemFontOfSize:13];
                    promptCell.lblPrompt.textColor = [UIColor redColor];
                    promptCell.lblPrompt.text = @"Prompt";
                    
                    return promptCell;
                    break;
                }
                    
                default:
                {
                    promptCell.lblPrompt.font = [UIFont boldSystemFontOfSize:13];
                    promptCell.lblPrompt.textColor = [UIColor blackColor];
                    NSString *str = [NSString stringWithFormat:@"%@",[arrStepData[indexPath.item-1] valueForKey:@"StepData"]];
                    promptCell.lblPrompt.text = str;
                    
                    if (indexPath.section % 2 != 0) {
                        promptCell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
                    }
                    
                    return promptCell;
                
                    break;
                }
            }
            break;
        }
        default:///For Other Rows
        {
            switch (indexPath.row) {
                case 0://for prompt type
                {
                    promptCell.lblPrompt.font = [UIFont boldSystemFontOfSize:13];
                    promptCell.lblPrompt.textColor = [UIColor blackColor];
                    //Because 0 section has default Value "Prompt" so strat with 1 section
                    NSString *str = [NSString stringWithFormat:@"%@",[arrPromptingTech[indexPath.section-1] valueForKey:@"PromptingTech"]];
                    promptCell.lblPrompt.text = str;
                    
                    if (indexPath.section % 2 != 0) {
                        promptCell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
                    }
                    
                    return promptCell;
                    break;
                }
                    
                    
                default:
                {
                    promptCell.btnAddCount.hidden=NO;
                    promptCell.btnDecreaseCount.hidden=NO;
                    promptCell.lblPrompt.font = [UIFont systemFontOfSize:13];
                    promptCell.lblPrompt.textColor = [UIColor blackColor];
                   
                    NSString *str =[NSString stringWithFormat:@"%@",[arrPromptingTech[indexPath.section-1] valueForKey:@"PromptingTech"]];
                    NSString *strStepData =[NSString stringWithFormat:@"%@",[arrStepData[indexPath.item-1] valueForKey:str]];
                    promptCell.lblPrompt.text = strStepData;
                    
                    if (indexPath.section % 2 != 0) {
                       promptCell.backgroundColor =  [UIColor colorWithWhite:242/255.0 alpha:1];
                    } else {
                         promptCell.backgroundColor = [UIColor whiteColor];
                        
                    }
                    
                    return promptCell;
                    break;
                }
            }
            
        }
            break;
    }
    
}

#define CELL_WIDTH 100
#define CELL_SPACING 10
#define COLLECTIONVIEW_WIDTH_IPAD 669

- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
    
    NSInteger viewWidth = COLLECTIONVIEW_WIDTH_IPAD;
    NSInteger totalCellWidth = CELL_WIDTH * arrStepData.count;
    NSInteger totalSpacingWidth = CELL_SPACING * (arrStepData.count -1);
    
    NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
    NSInteger rightInset = leftInset;
    
    return UIEdgeInsetsMake(0, leftInset, 0, rightInset);}

@end
