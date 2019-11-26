//
//  TreeNode.h
//  09_Tree
//
//  Created by chenshuang on 2019/5/19.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 树节点
 */
@interface TreeNode : NSObject
/** id*/
@property(nonatomic,strong)id element;
/** left*/
@property(nonatomic,strong)TreeNode *left;
/** right*/
@property(nonatomic,strong)TreeNode *right;
/** parent*/
@property(nonatomic,strong)TreeNode *parent;
/** value */
@property(nonatomic,assign)NSInteger value;

/** 初始化 */
- (instancetype)initWithElement:(id)element parent:(TreeNode *)parent;

- (instancetype)initWithElement:(id)element parent:(TreeNode *)parent left:(TreeNode *)left right:(TreeNode *)right;

/** 是否是空树 - 即叶子节点 */
- (BOOL)isLeaf;

/** 是否有两个子树 */
- (BOOL)hasTwoChildren;

@end

NS_ASSUME_NONNULL_END
