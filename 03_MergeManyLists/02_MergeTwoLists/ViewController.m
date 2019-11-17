//
//  ViewController.m
//  02_MergeTwoLists
//
//  Created by chenshuang on 2019/10/31.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "LinkNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LinkNode *nilNode = [[LinkNode alloc] initWithPrev:nil element:nil next:nil];
    
    // 构造三个链表
    LinkNode *k1 = [[LinkNode alloc] initWithPrev:nil element:@(1) next:nil];
    LinkNode *k2 = [[LinkNode alloc] initWithPrev:k1 element:@(4) next:nil];
    LinkNode *k3 = [[LinkNode alloc] initWithPrev:k2 element:@(7) next:nil];
    
    LinkNode *k4 = [[LinkNode alloc] initWithPrev:nil element:@(2) next:nil];
    LinkNode *k5 = [[LinkNode alloc] initWithPrev:k4 element:@(5) next:nil];
    LinkNode *k6 = [[LinkNode alloc] initWithPrev:k5 element:@(8) next:nil];

    LinkNode *k7 = [[LinkNode alloc] initWithPrev:nil element:@(3) next:nil];
    LinkNode *k8 = [[LinkNode alloc] initWithPrev:k7 element:@(6) next:nil];
    LinkNode *k9 = [[LinkNode alloc] initWithPrev:k8 element:@(9) next:nil];
    
    // 方法一
//    NSArray *linkNodes = @[k1,k4,k7];
//    LinkNode *k = [self mergeManyLists:linkNodes];
//    while (k) {
//        NSLog(@"%@",[k description]);
//        k = k.next;
//    }
    
    // 为了需要,每个节点最后是一个空的节点
//    k3.next = nilNode;
//    k6.next = nilNode;
//    k9.next = nilNode;
    
    // 方法二 逐一比较
//    NSMutableArray *linkNodes = [NSMutableArray arrayWithArray:@[k1,k4,k7]];
//    LinkNode *k = [self mergeManyLists2:linkNodes];
//    while (k) {
//        NSLog(@"%@",[k description]);
//        k = k.next;
//    }
    
    /// 方法三 逐一两两合并
//    NSMutableArray *linkNodes = [NSMutableArray arrayWithArray:@[k1,k4,k7]];
//    LinkNode *k = [self mergeManyLists3:linkNodes];
//    while (k) {
//        NSLog(@"%@",[k description]);
//        k = k.next;
//    }
    
    // 方法五 - 分治策略
    NSMutableArray *linkNodes = [NSMutableArray arrayWithArray:@[k1,k4,k7]];
    LinkNode *k = [self mergeManyLists5:linkNodes];
    while (k) {
        NSLog(@"%@",[k description]);
        k = k.next;
    }
}

/// 方法一:合并N个有序链表 - 最笨方法
- (LinkNode *)mergeManyLists:(NSArray *)linkNodes {
    if (!linkNodes || linkNodes.count == 0) {
        return nil;
    }
    NSMutableArray *nodes = [NSMutableArray array];
    for (LinkNode *node in linkNodes) {
        __strong LinkNode *strongNode = node;
        while (strongNode != nil) {
            [nodes addObject:strongNode];
            strongNode = strongNode.next;
        }
    }
    // 排序
    NSArray *newNodes = [nodes sortedArrayUsingComparator:^NSComparisonResult(LinkNode *obj1, LinkNode *obj2) {
        if (obj1.value > obj2.value) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    LinkNode *head = [[LinkNode alloc] init];
    LinkNode *cur = head;
    for (LinkNode *node in newNodes) {
        cur = cur.next = node;
    }
    return head.next;
}

/// 方法二 逐一比较
- (LinkNode *)mergeManyLists2:(NSMutableArray<LinkNode *> *)linkNodes {
    if (linkNodes == nil || linkNodes.count == 0) {
        return nil;
    }
    LinkNode *head = [[LinkNode alloc] init];
    LinkNode *cur = head;
    
    while (true) {
        int minIndex = -1;
        for (int i = 0; i < linkNodes.count; i++) {
            if (linkNodes[i] == nil || linkNodes[i].element == nil) {
                continue;
            }
            
            if (minIndex == -1 || linkNodes[i].value < linkNodes[minIndex].value) {
                minIndex = i;
            }
        }
        if (minIndex  == -1) {
            break;
        }
        
        cur = cur.next = linkNodes[minIndex];
        linkNodes[minIndex] = linkNodes[minIndex].next;
    }
    return head.next;
}

/// 方法三 逐一两两合并
- (LinkNode *)mergeManyLists3:(NSMutableArray<LinkNode *> *)linkNodes {
    if (linkNodes == nil || linkNodes.count == 0) {
        return nil;
    }
    for (int i = 1; i < linkNodes.count; i++) {
        linkNodes[0] = [self mergeTwoLists:linkNodes[0] k2:linkNodes[i]];
    }
    return linkNodes[0];
}

/// 方法四 - 优先级队列(小顶堆)
- (LinkNode *)mergeManyLists4:(NSMutableArray<LinkNode *> *)linkNodes {
    if (linkNodes == nil || linkNodes.count == 0) {
        return nil;
    }
    
    LinkNode *head = [[LinkNode alloc] initWithElement:nil next:nil];
    LinkNode *cur = head;
    
    return nil;
}

/// 方法五 - 分治策略
- (LinkNode *)mergeManyLists5:(NSMutableArray<LinkNode *> *)linkNodes {
    if (linkNodes == nil || linkNodes.count == 0) {
        return nil;
    }
    
    int step = 1;
    while (step < linkNodes.count) {
        int nextStep = step << 1;
        for (int i = 0; i + step < linkNodes.count; i += nextStep) {
            linkNodes[i] = [self mergeTwoLists:linkNodes[i] k2:linkNodes[i + step]];
        }
        step = nextStep;
    }
    return linkNodes[0];
}

/// 方法一:递归
/// 1.只要是用到递归,首先要搞清楚一个问题,这个递归函数的功能是什么
/// 2.递归基:边界
- (LinkNode *)mergeTwoLists:(LinkNode *)k1 k2:(LinkNode *)k2 {
    if (k1 == nil) return k2;
    if (k2 == nil) return k1;
    
    if (k1.value <= k2.value) {
        k1.next = [self mergeTwoLists:k1.next k2:k2];
        return k1;
    } else {
        k2.next = [self mergeTwoLists:k1 k2:k2.next];
        return k2;
    }
}

@end
