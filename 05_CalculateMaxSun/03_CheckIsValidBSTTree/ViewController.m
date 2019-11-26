//
//  ViewController.m
//  03_CheckIsValidBSTTree
//
//  Created by chenshuang on 2019/11/5.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "TreeNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TreeNode *one = [[TreeNode alloc] initWithElement:@1 parent:nil left:nil right:nil];
    TreeNode *two = [[TreeNode alloc] initWithElement:@2 parent:nil left:one right:nil];
    TreeNode *three = [[TreeNode alloc] initWithElement:@3 parent:two left:nil right:nil];
    two.right = three;
    
    TreeNode *four = [[TreeNode alloc] initWithElement:@4 parent:nil left:two right:nil];
    TreeNode *five = [[TreeNode alloc] initWithElement:@5 parent:four left:nil right:nil];
    four.right = five;
    
    TreeNode *seven = [[TreeNode alloc] initWithElement:@7 parent:nil left:four right:nil];
    TreeNode *eight = [[TreeNode alloc] initWithElement:@8 parent:nil left:nil right:nil];
    TreeNode *night = [[TreeNode alloc] initWithElement:@9 parent:seven left:eight right:nil];
    seven.right = night;
    
    TreeNode *ten = [[TreeNode alloc] initWithElement:@10 parent:nil left:nil right:nil];
    TreeNode *eleven = [[TreeNode alloc] initWithElement:@11 parent:night left:ten right:nil];
    night.right = eleven;
    
    TreeNode *twelve = [[TreeNode alloc] initWithElement:@12 parent:eleven left:nil right:nil];
    eleven.right = twelve;
    
    NSLog(@"%@",eleven.description);
    
    int sum = [self maxPathSum:seven];
    NSLog(@"maxSum = %d",sum);
}

/// 求一个节点能提供给父节点的最大路径值
- (int)value:(TreeNode *)node {
    if (node == nil) {
        return 0;
    }
    int leftV = MAX([self value:node.left], 0);     // 左子树节点最大路径值
    int rightV = MAX([self value:node.right], 0);   // 右子树节点最大路径值
    
    return node.value + MAX(leftV, rightV);
}

static NSInteger sum = 0;

- (int)maxPathSum:(TreeNode *)root {
    [self value1:root];
    return sum;
}

/// 求最大路径和
- (int)value1:(TreeNode *)node {
    if (node == nil) {
        return 0;
    }
    int leftV = MAX([self value1:node.left], 0);     // 左子树节点最大路径值
    int rightV = MAX([self value1:node.right], 0);   // 右子树节点最大路径值
    
    // 路径累计求和
    sum = MAX(sum, node.value + leftV + rightV);
    NSLog(@"value = %d,sum = %d",node.value, sum);
    
    return node.value + MAX(leftV, rightV);
}

@end
