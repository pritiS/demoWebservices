//
//  CustomCollectionViewLayout.m
//  Brightec
//
//  Created by JOSE MARTINEZ on 03/09/2014.
//  Copyright (c) 2014 Brightec. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

#define NUMBEROFCOLUMNS 7

@interface CustomCollectionViewLayout ()
@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (strong, nonatomic) NSMutableArray *itemsSize;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) NSUInteger numOFcolumn;
@end

@implementation CustomCollectionViewLayout

- (void)prepareLayout
{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSUInteger column = 0; // Current column inside row
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0; // To determine the contentSize
    CGFloat contentHeight = 0.0; // To determine the contentSize
    
    
    if (self.itemAttributes.count > 0) { // We don't enter in this if statement the first time, we enter the following times
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger index = 0; index < numberOfItems; index++) {
                if (section != 0 && index != 0) { // This is a content cell that shouldn't be sticked
                    
                    continue;
                }
                
                
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
                if (section == 0) { // We stick the first row
                    CGRect frame = attributes.frame;
                    frame.origin.y = self.collectionView.contentOffset.y;
                    attributes.frame = frame;
                    
                }
                if (index == 0) { // We stick the first column
                    CGRect frame = attributes.frame;
                    frame.origin.x = self.collectionView.contentOffset.x;
                    attributes.frame = frame;
                }
            }
        }
        
        return;
    }
    
    _numOFcolumn = [self.collectionView numberOfItemsInSection:0];
    
    if (self.itemAttributes <= 0) {
        
        // The following code is only executed the first time we prepare the layout
        self.itemAttributes = [@[] mutableCopy];
        self.itemsSize = [@[] mutableCopy];
        
        // Tip: If we don't know the number of columns we can call the following method and use the NSUInteger object instead of the NUMBEROFCOLUMNS macro
        // NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        // We calculate the item size of each column
        if (self.itemsSize.count != _numOFcolumn) {
            [self calculateItemsSize:_numOFcolumn];
        }
        
        // We loop through all items
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSMutableArray *sectionAttributes = [@[] mutableCopy];
            
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            if (self.itemsSize.count < numberOfItems) {
                [self calculateItemsSize:numberOfItems];
            }
            for (NSUInteger index = 0; index < numberOfItems; index++) {
                CGSize itemSize = CGSizeMake(100, 60);
                
                // We create the UICollectionViewLayoutAttributes object for each item and add it to our array.
                // We will use this later in layoutAttributesForItemAtIndexPath:
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
                
                if (section == 0 && index == 0) {
                    attributes.zIndex = 1024; // Set this value for the first item (Sec0Row0) in order to make it visible over first column and first row
                } else if (section == 0 || index == 0) {
                    attributes.zIndex = 1023; // Set this value for the first row or section in order to set visible over the rest of the items
                }
                
                [self.collectionView setContentOffset:CGPointMake(0, 0)];//Priti
                
                if (section == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.y = self.collectionView.contentOffset.y;
                    attributes.frame = frame; // Stick to the top
                }
                if (index == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.x = self.collectionView.contentOffset.x;
                    attributes.frame = frame; // Stick to the left
                }
                
                [sectionAttributes addObject:attributes];
                
                xOffset = xOffset+itemSize.width;
                column++;
                
                // Create a new row if this was the last column
                if (column == _numOFcolumn ) {
                    if (xOffset > contentWidth) {
                        contentWidth = xOffset;
                    }
                    
                    // Reset values
                    column = 0;
                    xOffset = 0;
                    
                    yOffset += itemSize.height;
                    
                }
            }
            [self.itemAttributes addObject:sectionAttributes];
        }
        
        // Get the last item to calculate the total height of the content
        UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
        contentHeight = attributes.frame.origin.y+ attributes.frame.size.height;
        self.contentSize = CGSizeMake(contentWidth, contentHeight);
        
    }
    
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemAttributes[indexPath.section][indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [@[] mutableCopy];
    
    NSArray *firstSection = self.itemAttributes[0];
    NSArray *secondSection = self.itemAttributes[1];
    UICollectionViewLayoutAttributes * firstAttr = firstSection[0];
    UICollectionViewLayoutAttributes * secondAttr = secondSection[0];
    
    if ((secondAttr.frame.origin.y - firstAttr.frame.origin.y) >= 60) {
        
        for (UICollectionViewLayoutAttributes *attribute in firstSection) {
            attribute.frame = CGRectMake(attribute.frame.origin.x,attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
        }
        
        [self.itemAttributes replaceObjectAtIndex:0 withObject:firstSection];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, 0)];
    }
    
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES; // Set this to YES to call prepareLayout on every scroll
}

/*
- (CGSize)sizeForItemWithColumnIndex:(NSUInteger)columnIndex
{
    NSString *text = @"abcdefghijklmop";
    switch (columnIndex) { // This only makes sense if the size of the items should be different
        case 0:
            text = @"Col 0";
            break;
        case 1:
            text = @"Col 1";
            break;
        case 2:
            text = @"Col 2";
            break;
        case 3:
            text = @"Col 3";
            break;
        case 4:
            text = @"Col 4";
            break;
        case 5:
            text = @"Col 5";
            break;
        case 6:
            text = @"Col 6";
            break;
        case 7:
            text = @"Col 7";
            break;
            
        default:
            break;
    }
    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
    if (columnIndex == 0) {
        size.width += 12; // In our design the first column should be the widest one
    }
    return CGSizeMake([@(size.width + 9) floatValue], 60); // Extra space of 9px for all the items
}
 */

- (void)calculateItemsSize:(int)numberofColumn
{
    for (NSUInteger index = 0; index < numberofColumn; index++) {
        if (self.itemsSize.count <= index) {
            //CGSize itemSize = [self sizeForItemWithColumnIndex:index];
            //NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
            NSValue *itemSizeValue = [NSValue valueWithCGSize:CGSizeMake(100, 60)];
            [self.itemsSize addObject:itemSizeValue];
        }
    }
}

@end
