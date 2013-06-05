@interface TreeNode : NSObject

+ (TreeNode *)randomTree;
+ (TreeNode *)sampleNode;

@property (nonatomic) NSInteger weight;
@property (nonatomic, strong) TreeNode *parent;
@property (nonatomic, strong) NSMutableArray *children;

// Extract these to a linked data structure (he, he)
@property (nonatomic) NSInteger zIndex;
@property (nonatomic) CGRect cachedFrame;

@end
