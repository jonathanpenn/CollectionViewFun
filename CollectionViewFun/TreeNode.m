#import "TreeNode.h"

@implementation TreeNode

+ (TreeNode *)sampleNode
{
    TreeNode *first = [TreeNode nodeWithWeight:2 children:@[]];
    TreeNode *second = [TreeNode nodeWithWeight:1 children:@[]];
    return [TreeNode nodeWithWeight:3 children:@[first, second]];
}

+ (instancetype)nodeWithWeight:(NSInteger)weight children:(NSArray *)children
{
    TreeNode *node = [[self alloc] init];
    node.weight = weight;
    node.children = [children mutableCopy];
    return node;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

