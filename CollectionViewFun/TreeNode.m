#import "TreeNode.h"

@implementation TreeNode

+ (TreeNode *)sampleNode
{
    TreeNode *first = [TreeNode nodeWithWeight:2 children:@[]];
    TreeNode *second = [TreeNode nodeWithWeight:1 children:@[]];
    TreeNode *third = [TreeNode nodeWithWeight:1 children:@[]];
    TreeNode *fifth = [TreeNode nodeWithWeight:4 children:@[]];
    TreeNode *fourth = [TreeNode nodeWithWeight:-1 children:@[second, fifth]];
    return [TreeNode nodeWithWeight:-1 children:@[first, third, fourth]];

//    TreeNode *first = [TreeNode nodeWithWeight:2 children:@[]];
//    TreeNode *second = [TreeNode nodeWithWeight:1 children:@[]];
//    return [TreeNode nodeWithWeight:-1 children:@[first, second]];
}

+ (TreeNode *)randomTree
{
    return [self randomTreeWithChildCount:arc4random_uniform(3)+1 depth:arc4random_uniform(10)+1];
}

+ (TreeNode *)randomTreeWithChildCount:(int)childCount depth:(int)depth
{
    NSLog(@"Randomly generating tree with child count %d, depth %d", childCount, depth);
    NSMutableArray *children = [[NSMutableArray alloc] init];

    for (int i = 0; i < childCount; i++) {
        TreeNode *child = nil;

        if (depth == 0) {
            child = [TreeNode nodeWithWeight:arc4random_uniform(10)+1 children:@[]];
        } else {
            child = [self randomTreeWithChildCount:arc4random_uniform(5)+1 depth:depth-1];
        }
        [children addObject:child];
    }

    [children sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"weight" ascending:NO]]];

    return [TreeNode nodeWithWeight:-1 children:children];
}

+ (instancetype)nodeWithWeight:(NSInteger)weight children:(NSArray *)children
{
    TreeNode *node = [[self alloc] init];
    node.weight = weight;
    node.children = [children mutableCopy];
    if ([node.children count] > 0) {
        node.weight = 0;
        [node.children enumerateObjectsUsingBlock:^(TreeNode *child, NSUInteger idx, BOOL *stop) {
            child.parent = node;
            node.weight += child.weight;
        }];
    }
    return node;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.children = [[NSMutableArray alloc] init];
        self.cachedFrame = CGRectZero;
    }
    return self;
}

@end

