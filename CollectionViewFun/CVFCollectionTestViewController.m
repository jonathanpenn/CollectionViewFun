#import "CVFCollectionTestViewController.h"
#import "TreeNode.h"
#import "CVFCollectionViewLayout.h"
#import <QuartzCore/QuartzCore.h>

@interface CVFCollectionTestViewController ()
@property (nonatomic, strong) NSMutableArray *nodes;
@property (nonatomic, strong) TreeNode *tree;
@end

@implementation CVFCollectionTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tree = [TreeNode randomTree];

    self.nodes = [NSMutableArray array];
    [self expandTreeToArray:self.tree];

    CVFCollectionViewLayout *layout = (CVFCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.sortedObjects = self.nodes;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.nodes count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"awesomeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 2;
    return cell;
}

- (void)expandTreeToArray:(TreeNode *)node {
    [self.nodes addObject:node];
    for (TreeNode *child in node.children) {
        [self expandTreeToArray:child];
    }
}

@end
