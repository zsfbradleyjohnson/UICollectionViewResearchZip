//
//  BJCardViewLayout.m
//  BJCardCollectionView
//
//  Created by bradleyjohnson on 2016/10/28.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#import "BJCardViewLayout.h"

@interface BJCardViewLayout ()

@property (nonatomic , assign) NSInteger columnCount;
@property (nonatomic , assign) CGFloat columnSpace;
@property (nonatomic , assign) CGFloat rowSpace;
@property (nonatomic , assign) UIEdgeInsets sectionInsets;

@property (nonatomic , assign) CGFloat contentX;

@property (nonatomic , strong) NSMutableArray * attributesArray;

@property (nonatomic , strong) NSMutableArray * deleteIndexPaths;
@property (nonatomic , strong) NSMutableArray * insertIndexPaths;

@end

@implementation BJCardViewLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.columnCount = [self.collectionView numberOfItemsInSection:0];    
    self.columnSpace = 20.0f;
    self.rowSpace = 10.0f;
    self.sectionInsets = UIEdgeInsetsMake(5.0f, self.collectionView.bounds.size.width*0.35, 5.0f, self.collectionView.bounds.size.width*0.35);
    self.contentX = self.sectionInsets.left;
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self.attributesArray removeAllObjects];
    for (NSInteger index = 0; index < [self.collectionView numberOfItemsInSection:0]; index++) {
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.attributesArray addObject:attributes];
    }
        
    return self.attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat w = width*0.3;
    CGFloat h = height*0.2;
    
    CGFloat x = self.sectionInsets.left + (self.columnSpace + w)*indexPath.item;
    CGFloat y = height*0.4;
    
    attributes.frame = CGRectMake(x, y, w, h);
    
    
    self.contentX = attributes.frame.origin.x + attributes.frame.size.width;

    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;

    CGFloat delta = ABS(attributes.center.x - centerX);
    CGFloat scale = 1.0 - delta / self.collectionView.frame.size.width;
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = 0.001;
//    transform = CATransform3DRotate(transform, DEGREES_TO_RADIANS(90*(attributes.center.x - centerX)/self.collectionView.frame.size.width*1.3), 0, 1, 1);
//    attributes.transform3D = transform;
    
    attributes.alpha = scale;
    
    return attributes;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentX + self.sectionInsets.right, 0);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat midCenterX = self.collectionView.center.x;
    CGFloat cardWidth = self.collectionView.bounds.size.width*0.3;
    
    CGFloat realMidX = proposedContentOffset.x + midCenterX;
    
    CGFloat more = fmodf(realMidX-self.sectionInsets.left, cardWidth+self.columnSpace);

    return CGPointMake(proposedContentOffset.x-(more-cardWidth/2.0), 0);    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    NSLog(@"准备改变");
    
    UICollectionViewUpdateItem *update = updateItems[0];
    NSLog(@"%ld -- %ld",update.indexPathBeforeUpdate.section,update.indexPathBeforeUpdate.row);
    NSLog(@"%ld -- %ld",update.indexPathAfterUpdate.section,update.indexPathAfterUpdate.row);
    NSLog(@"%ld",update.updateAction);

    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"插入动画 ： %ld -- %ld ",itemIndexPath.section,itemIndexPath.row);
    
    UICollectionViewLayoutAttributes * att = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath]) {
        if (!att) {
            att = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        
        att.alpha = 0.1f;
    }
    
    return att;
}

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"删除动画 ： %ld -- %ld ",itemIndexPath.section,itemIndexPath.row);

    UICollectionViewLayoutAttributes * att = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath]) {
        if (!att) {
            att = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        
        att.alpha = 1.0f;
        att.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));

    }
    
    return att;
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    
    NSLog(@"完成改变");
    
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

#pragma mark - initializes attributes

-(NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    
    return _attributesArray;
}

@end
