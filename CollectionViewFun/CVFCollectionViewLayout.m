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
    attributes.alpha = [self alphaForCellAtIndexPath:indexPath];

    return attributes;
}

- (CGFloat)alphaForCellAtIndexPath:(NSIndexPath *)indexPath
{
    TreeNode *node = self.sortedObjects[indexPath.row];
    return (CGFloat) node.weight / (CGFloat) node.parent.weight;
}

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
{
    TreeNode *node = self.sortedObjects[indexPath.row];
    node.cachedFrame = [self rectForNode:node];
    return node.cachedFrame;
}

- (CGRect)rectForNode:(TreeNode *)node
{
    if (!CGRectEqualToRect(CGRectZero, node.cachedFrame)) return node.cachedFrame;
    
    if (node.parent == nil) {
        node.cachedFrame = self.collectionView.bounds;
        return node.cachedFrame;
    }

    const CGFloat inset = 10;

    CGRect parentFrame = [self rectForNode:node.parent];

    CGFloat x = parentFrame.origin.x;
    CGFloat y = parentFrame.origin.y;
    CGFloat height = 0;
    CGFloat width = 0;

    if (parentFrame.size.height > parentFrame.size.width) {
        height = (CGFloat) node.weight / (CGFloat) node.parent.weight * parentFrame.size.height;
        width = parentFrame.size.width;
    } else {
        height = parentFrame.size.height;
        width = (CGFloat) node.weight / (CGFloat) node.parent.weight * parentFrame.size.width;
    }

    for (TreeNode *otherChild in node.parent.children) {
        if (otherChild == node) break;

        CGRect otherChildRect = [self rectForNode:otherChild];

        if (parentFrame.size.height > parentFrame.size.width) {
            y += otherChildRect.size.height + inset;
        } else {
            x += otherChildRect.size.width + inset;
        }
    }

    node.cachedFrame = CGRectInset(CGRectMake(x, y, width, height), inset, inset);

    return node.cachedFrame;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
