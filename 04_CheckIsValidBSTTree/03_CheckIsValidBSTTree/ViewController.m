//
//  ViewController.m
//  03_CheckIsValidBSTTree
//
//  Created by chenshuang on 2019/11/5.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "TreeNode.h"
#import "Stack.h"
#import "Queue.h"

@interface ViewController ()
/** last */
@property(nonatomic,assign)NSInteger last;
/** nodes*/
@property(nonatomic,strong)Queue *nodes;
/** mins*/
@property(nonatomic,strong)NSMutableArray *mins;
/** maxs*/
@property(nonatomic,strong)NSMutableArray *maxs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.last = NSNotFound;
    
    TreeNode *one = [[TreeNode alloc] initWithElement:@1 parent:nil left:nil right:nil];
    TreeNode *two = [[TreeNode alloc] initWithElement:@2 parent:nil left:one right:nil];
    TreeNode *three = [[TreeNode alloc] initWithElement:@3 parent:two left:nil right:nil];
    TreeNode *four = [[TreeNode alloc] initWithElement:@4 parent:nil left:two right:nil];
    TreeNode *five = [[TreeNode alloc] initWithElement:@5 parent:four left:nil right:nil];
    TreeNode *seven = [[TreeNode alloc] initWithElement:@7 parent:nil left:four right:nil];
    TreeNode *eight = [[TreeNode alloc] initWithElement:@8 parent:nil left:nil right:nil];
    TreeNode *night = [[TreeNode alloc] initWithElement:@9 parent:seven left:eight right:nil];
    TreeNode *ten = [[TreeNode alloc] initWithElement:@10 parent:nil left:nil right:nil];
    TreeNode *eleven = [[TreeNode alloc] initWithElement:@11 parent:night left:ten right:nil];
    TreeNode *twelve = [[TreeNode alloc] initWithElement:@12 parent:eleven left:nil right:nil];
    
    // 思路一 中序遍历 迭代
//    BOOL isValidBST = [self isValidBST:seven];
//    NSLog(@"result = %d",isValidBST);
    
    // 思路一 中序遍历 递归
//    BOOL isValidBST2 = [self isValidBST2:seven];
//    NSLog(@"result2 = %d",isValidBST2);
    
    // 思路二 - 遍历的同时指定范围 - 前序遍历
//    BOOL isValidBST3 = [self isValidBST3:seven];
//    NSLog(@"result3 = %d",isValidBST3);
    
    self.nodes = [[Queue alloc] init];
    self.mins = [[NSMutableArray alloc] init];
    self.maxs = [[NSMutableArray alloc] init];
    
    /// 思路2 - 遍历的同时指定范围 - 层序遍历
    BOOL isValidBST4 = [self isValidBST4:seven];
    NSLog(@"result4 = %d",isValidBST4);
}

/// 思路一 中序遍历 迭代
- (BOOL)isValidBST:(TreeNode *)root {
    if (root == nil) {
        return true;
    }
    
    Stack *stack = [[Stack alloc] init];
    while (true) {
        while (root != nil) {
            [stack push:root];
            root = root.left;
        }
        if ([stack isEmpty]) {
            break;
        }
        root = [stack pop];
        
        if (self.last != NSNotFound && root.value <= self.last) {
            return false;
        }
        self.last = root.value;
        root = root.right;
    }
    return true;
}

/// 递归调用
- (BOOL)isValidBST2:(TreeNode *)root {
    if (root == nil) {
        return true;
    }
    
    if (![self isValidBST:root.left]) {
        return false;
    }
    
    if (self.last != NSNotFound && root.value <= self.last) {
        return false;
    }
    self.last = root.value;
    
    if (![self isValidBST:root.right]) {
        return false;
    }
    
    return true;
}

// 思路2 - 遍历的同时指定范围 - 前序遍历
- (BOOL)isValidBST3:(TreeNode *)root {
    return [self isValidBST3:root min:NSNotFound max:NSNotFound];
}

- (BOOL)isValidBST3:(TreeNode *)node min:(NSInteger)min max:(NSInteger)max {
    if (node == nil) {
        return true;
    }
    if (min != NSNotFound && node.value <= min) {
        return false;
    }
    if (max != NSNotFound && node.value >= max ) {
        return false;
    }
    // 遍历左边节点
    if (![self isValidBST3:node.left min:min max:node.value]) {
        return false;
    }
    
    // 遍历右边节点
    if (![self isValidBST3:node.right min:node.value max:max]) {
        return false;
    }
    
    return true;
}

/// 思路2 - 遍历的同时指定范围 - 层序遍历
- (BOOL)isValidBST4:(TreeNode *)root {
    if (root == nil) {
        return true;
    }
    [self offer:root min:NSNotFound max:NSNotFound];
    
    // 循环遍历
    while (!self.nodes.isEmpty) {
        TreeNode *node = [self.nodes deQueue];
        NSInteger min = [[self.mins objectAtIndex:0] integerValue];
        
        if (min != NSNotFound && node.value <= min) {
            return false;
        }
        
        NSInteger max = [[self.maxs objectAtIndex:0] integerValue];
        if (max != NSNotFound && node.value >= max) {
            return false;
        }
        
        // 遍历左右子树
        [self offer:node.left min:min max:node.value];
        [self offer:node.right min:node.value max:max];
    }
    return true;
}

- (void)offer:(TreeNode *)node min:(NSInteger)min max:(NSInteger)max {
    if (node == nil) {
        return;
    }
    [self.nodes enQueue:node];
    [self.mins addObject:@(min)];
    [self.maxs addObject:@(max)];
}

@end
