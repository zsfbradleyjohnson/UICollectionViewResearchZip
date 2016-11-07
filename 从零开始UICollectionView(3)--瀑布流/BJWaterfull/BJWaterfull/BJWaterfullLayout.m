//
//  BJWaterfullLayout.m
//  BJWaterfull
//
//  Created by bradleyjohnson on 2016/10/27.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "BJWaterfullLayout.h"

@interface BJWaterfullLayout ()

@property (nonatomic , assign) NSInteger columnCount;
@property (nonatomic , assign) NSInteger columnSpace;
@property (nonatomic , assign) NSInteger rowSpace;
@property (nonatomic , assign) UIEdgeInsets sectionInsets;
@property (nonatomic , strong) NSMutableArray * columnYArray;
@property (nonatomic , strong) NSMutableArray * attributesArray;

@end

@implementation BJWaterfullLayout

-(void)dealloc
{
    self.delegate = nil;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.columnCount = 3;
    self.columnSpace = 10;
    self.rowSpace = 10;
    self.sectionInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.columnYArray removeAllObjects];
    for (NSInteger index = 0; index < self.columnCount; index++) {
        [self.columnYArray addObject:@(self.sectionInsets.top)];
    }
    
    [self.attributesArray removeAllObjects];
    for (NSInteger index = 0; index<[self.collectionView numberOfItemsInSection:0]; index++) {
        
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        [self.attributesArray addObject:attributes];
    }
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat weight = self.collectionView.frame.size.width;
    CGFloat w = (weight - self.sectionInsets.left - self.sectionInsets.right - (self.columnCount-1)*self.columnSpace)/self.columnCount;
    CGFloat h = [self.delegate BJWaterfullLayout:self index:indexPath.item weight:w];
    
    NSInteger minIndex = 0;
    CGFloat minContent = [self.columnYArray[0] floatValue];
    for (NSInteger index = 0; index < self.columnYArray.count; index++) {
        CGFloat theContentY = [self.columnYArray[index] floatValue];
        if (theContentY < minContent) {
            minIndex = index;
            minContent = theContentY;
        }
    }

    CGFloat x = self.sectionInsets.left + (w+self.columnSpace)*minIndex;
    CGFloat y = minContent + self.rowSpace;
    
    attributes.frame = CGRectMake(x, y, w, h);
    
    self.columnYArray[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}

-(CGSize)collectionViewContentSize
{
    CGFloat maxContent = [self.columnYArray[0] floatValue];
    
    for (NSInteger index = 0; index < self.columnYArray.count; index++) {
        CGFloat theContentY = [self.columnYArray[index] floatValue];
        if (theContentY > maxContent) {
            maxContent = theContentY;
        }
    }
    
    return CGSizeMake(0, maxContent + self.sectionInsets.bottom);
}


#pragma mark - initializes attributes

-(NSMutableArray *)columnYArray
{
    if (!_columnYArray) {
        _columnYArray = [[NSMutableArray alloc] init];
    }
    return _columnYArray;
}

-(NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

@end
