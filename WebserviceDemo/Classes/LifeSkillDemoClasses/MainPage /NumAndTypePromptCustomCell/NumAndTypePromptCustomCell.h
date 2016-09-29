//
//  NumAndTypePromptCustomCell.h
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumAndTypePromptCustomCell : UITableViewCell{

    __weak IBOutlet UILabel *lblPromtingTech;    

}


- (void)setValueforCellData:(NSMutableDictionary *)dict stepData:(NSMutableArray*)arrStepData;

@end
