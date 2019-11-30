//
//  ViewController.m
//  09_Tree
//
//  Created by chenshuang on 2019/5/15.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "BinarySearchTree.h"
#import "TreeNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self test1];
    
    // 前序遍历
//    [self preorder];
    
    // 中序遍历
//    [self Inorder];
    
    // 后序遍历
//    [self postorder];
    
    // 层序遍历
//    [self levelOrder];
    
    // 打印二叉搜索树
//    [self printBinarySearchTree];
    
    // 计算二叉树的高度
//    [self getTreeHeight];
    
    // 是否为完全二叉树
//    [self isComplteBinaryTree];
    
    // 找前驱节点
//    [self predecessor];
    
    // 找后继节点
//    [self successor];
    
    TreeNode *root = [self createTree];
    
    /// 前序遍历- 递归遍历
//    [self flatten:root];
    
    /// 前序遍历- 非递归遍历
//    [self flaten1:root];
    
    /// 后序遍历 - 递归遍历
    [self flatten2:root];
    
    while (root) {
        NSLog(@"%@",root);
        root = root.right;
    }
}

// 构造二叉树
- (TreeNode *)createTree {
    TreeNode *one = [[TreeNode alloc] initWithElement:@1 parent:nil left:nil right:nil];
    TreeNode *two = [[TreeNode alloc] initWithElement:@2 parent:one left:nil right:nil];
    TreeNode *three = [[TreeNode alloc] initWithElement:@3 parent:two left:nil right:nil];
    TreeNode *four = [[TreeNode alloc] initWithElement:@4 parent:nil left:nil right:nil];
    two.right = four;
    two.left = three;
    one.left = two;
    
    TreeNode *five = [[TreeNode alloc] initWithElement:@5 parent:one left:nil right:nil];
    one.right = five;
    TreeNode *six = [[TreeNode alloc] initWithElement:@6 parent:five left:nil right:nil];
    five.right = six;
    
    return one;
}

/// 前序遍历- 递归遍历
- (void)flatten:(TreeNode *)root {
    if (root == nil) {
        return;
    }
    if (root.left != nil) {
        // 保留之前的right
        TreeNode *oldRight = root.right;
        // 将left嫁接到right
        root.right = root.left;
        // 清空left
        root.left = nil;
        // 将旧的right嫁接到root的最右下角
        TreeNode *rightMost = root;
        while (rightMost.right != nil) {
            rightMost = rightMost.right;
        }
        rightMost.right = oldRight;
    }
    [self flatten:root.right];  // 依次递归遍历右节点
}

/// 前序遍历- 非递归遍历
- (void)flaten1:(TreeNode *)root {
    while (root != nil) {
        if (root.left != nil) {
            TreeNode *oldRight = root.right;    // 先保留右边的节点
            root.right = root.left; // 将左子树节点嫁接到右子树上
            root.left = nil;    // 将左子树清空
            
            // 找出右子树中最右边,最深的节点
            TreeNode *rightMost = root;
            while (rightMost.right != nil) {
                rightMost = rightMost.right;
            }
            rightMost.right = oldRight; // 将原来右节点嫁接到最右边最深的节点处
        }
        root = root.right;
    }
}

static TreeNode *prev;
/// 后序遍历 - 递归遍历
- (void)flatten2:(TreeNode *)root {
    if (root == nil) {
        return;
    }
    [self flatten2:root.right];
    [self flatten2:root.left];
    
    if (prev != nil) {
        root.right = prev;
        root.left = nil;
    }
    
    prev = root;
}

#pragma mark - 遍历

// 打印一棵二叉树
- (void)test1 {
    NSArray *data = @[@7, @4, @9, @2, @5, @8, @11, @3, @12, @1];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    NSLog(@"tree = %@",tree);
}

#pragma mark - 遍历

/// 前序遍历
- (void)preorder {
//    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    NSArray *data = @[@1,@2,@3,@4,@5,@6];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    [tree preordr];
    NSLog(@"tree = %@",tree);
}

/// 中序遍历
- (void)Inorder {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    [tree inorder];
}

/// /后序遍历
- (void)postorder {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    [tree postorder];
}

/// 层序遍历
- (void)levelOrder {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    [tree levelOrder];
}

#pragma mark - 遍历的作用

/// 利用前序遍历树状打印二叉树
- (void)printBinarySearchTree {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    NSLog(@"%@",tree.description);
}

/// 计算二叉树的高度
- (void)getTreeHeight {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    NSLog(@"递归:%d",[tree getHeight]);
    NSLog(@"递归:%d",[tree getHeight2]);
}

/// 是否为完全二叉树
- (void)isComplteBinaryTree {
    NSArray *data = @[@7,@4,@9,@2,@5,@8,@11,@1,@3,@10,@12];
    NSArray *data1 = @[@7,@4,@9,@2,@5,@8,@11];
    NSArray *data2 = @[@7,@4,@9,@2,@5,@8,@11,@1];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    BinarySearchTree *tree1 = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data1.count; i++) {
        [tree1 add:data1[i]];
    }
    BinarySearchTree *tree2 = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data2.count; i++) {
        [tree2 add:data2[i]];
    }
    NSLog(@"%d",[tree isComplteBinaryTree]);
    NSLog(@"%d",[tree1 isComplteBinaryTree]);
    NSLog(@"%d",[tree2 isComplteBinaryTree]);
}

#pragma mark - 前驱节点 | 后继节点

// 找前驱节点
- (void)predecessor {
    NSArray *data = @[@8,@4,@13,@2,@6,@10,@1,@3,@5,@7,@9,@12,@11];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    NSLog(@"二叉树为\n %@",tree.description);
    
    NSArray *data1 = @[@6,@13,@8,@7,@11,@9,@1];
    for (int i = 0; i < data1.count; i++) {
        TreeNode *node = [tree node:data1[i]];
        NSLog(@"%@的前驱节点:%@",node.element,[tree predecessor:node].element);
    }
}

// 找后继节点
- (void)successor {
    NSArray *data = @[@4,@1,@8,@2,@7,@10,@3,@5,@9,@11,@6];
    
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    for (int i = 0; i < data.count; i++) {
        [tree add:data[i]];
    }
    
    NSLog(@"二叉树为\n %@",tree.description);
    
    NSArray *data1 = @[@1,@8,@4,@7,@6,@3,@11];
    for (int i = 0; i < data1.count; i++) {
        TreeNode *node = [tree node:data1[i]];
        NSLog(@"%@的后继节点:%@",node.element,[tree successor:node].element);
    }
}

@end
