//
//  CVFCollectionViewLayout.m
//  CollectionViewFun
//
//  Created by Jonathan on 6/4/13.
//  Copyright (c) 2013 Cocoa Manifest. All rights reserved.
//

#import "CVFCollectionViewLayout.h"
#import "TreeNode.h"

@interface CVFCollectionViewLayout ()
@end

@implementation CVFCollectionViewLayout

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributesArray = [[NSMutableArray alloc] init];
    for (int s = 0; s < [self.collectionView numberOfSections]; s++) {
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:s]; ++i) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:s];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
            [attributesArray addObject:attributes];
        }
    }

    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    attributes.frame = [self frameForCellAtIndexPath:indexPath];

    return attributes;
}

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
{
    TreeNode *node = self.sortedObjects[indexPath.row];

    CGFloat x = 0;
    CGFloat y = 300 * indexPath.row;
    CGFloat width = 50 * node.weight;
    CGFloat height = 50 * node.weight;

    return CGRectMake(x, y, width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
