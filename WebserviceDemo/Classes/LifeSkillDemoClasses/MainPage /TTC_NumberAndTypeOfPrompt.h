//
//  TTC_NumberAndTypeOfPrompt.h
//  WebserviceDemo
//
//  Created by Priti Suthar on 7/6/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTC_NumberAndTypeOfPrompt : UIViewController{
    
    __weak IBOutlet UIView *vwMainPrompt;   
    __weak IBOutlet UICollectionView *collNumberAndTypePrompt;
    
    NSMutableArray *arrStepData;
    NSMutableArray *arrPromptingTech;    
}

@end
