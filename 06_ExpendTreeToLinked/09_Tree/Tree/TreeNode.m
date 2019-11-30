//
//  TreeNode.m
//  09_Tree
//
//  Created by chenshuang on 2019/5/19.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

/** 初始化 */
- (instancetype)initWithElement:(id)element parent:(TreeNode *)parent {
    return [self initWithElement:element parent:parent left:nil right:nil];
}

- (instancetype)initWithElement:(id)element parent:(TreeNode *)parent left:(TreeNode *)left right:(TreeNode *)right {
    self = [super init];
    if (self) {
        self.element = element;
        self.parent = parent;
        self.left = left;
        if (left) {
            left.parent = self;
        }
        self.right = right;
        if (right) {
            right.parent = self;
        }
    }
    return self;
}

/** 是否是空树 */
- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

/** 是否有两个子树 */
- (BOOL)hasTwoChildren {
    return self.left != nil && self.right != nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.element];
}

- (NSInteger)value {
    return [self.element integerValue];
}

@end
