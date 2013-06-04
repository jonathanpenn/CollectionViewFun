@interface TreeNode : NSObject

@property (nonatomic) NSInteger weight;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic) NSInteger zIndex;

+ (TreeNode *)sampleNode;

@end
