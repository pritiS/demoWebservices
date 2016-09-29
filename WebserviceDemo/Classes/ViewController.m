//
//  ViewController.m
//  WebserviceDemo
//
//  Created by Priti Suthar on 6/21/16.
//  Copyright © 2016 Priti Suthar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    NSMutableArray *arrtotalElements;
    NSMutableDictionary *tempDict;
    NSString *elementValue,*element_name;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"XMLParserFile" ofType:nil]];
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    
    parser.delegate = self;
    [parser parse];

    if (arrtotalElements.count > 0 ) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Parsed Value" message:[NSString stringWithFormat:@"%@",arrtotalElements] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"catalog"]) {
        arrtotalElements = [[NSMutableArray alloc]init];
    }else if ([elementName containsString:@"book"]) {
        tempDict = [[NSMutableDictionary alloc]init];
        //[tempDict setObject:elementName forKey:@"ID"];
    }else{
        element_name = elementName;
    }
 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSArray *keys =@[@"catalog",
                     @"book",
                     @"author",
                     @"title",
                     @"genre",
                     @"price",
                     @"publish_date",
                     @"description",
                     ];
     int item = [keys indexOfObject:elementName];
    switch (item) {
        case 0:
            //ShowList
            
            break;
            
        case 1:
            if (!arrtotalElements) {
                arrtotalElements= [[NSMutableArray alloc]init];
            }
            [arrtotalElements addObject:[tempDict mutableCopy]];
            //tempDict = nil;
            break;
            
            
        default:{
            [tempDict setObject:elementValue forKey:elementName];
        }
        break;
    }
    elementValue = nil;
    element_name = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSCharacterSet * whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    string = [string stringByTrimmingCharactersInSet:whiteSpace];
    if (element_name.length <= 0) {
        return;
    }
    if(!elementValue || [elementValue length] == 0)
    {
        elementValue = string;
        [tempDict setValue:string forKey:element_name];
    }
    else
    {   elementValue =  [NSString stringWithFormat:@"%@ %@",elementValue,string];
        [tempDict setValue:elementValue forKey:element_name];
    }

}


//    [UIView animateWithDuration:1
//                          delay:0.5f
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations: ^{
//
//                         _flipView.transform = CGAffineTransformRotate(_flipView.transform, M_PI);
//                     }
//                     completion: ^(BOOL finished) {
//                         [self viewWillAppear:YES];
//                     }];

@end
