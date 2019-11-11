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
    
    // 构造两个链表
    LinkNode *k3 = [[LinkNode alloc] initWithElement:@(5) next:nil];
    LinkNode *k2 = [[LinkNode alloc] initWithElement:@(3) next:k3];
    LinkNode *k1 = [[LinkNode alloc] initWithElement:@(1) next:k2];
    
    LinkNode *k5 = [[LinkNode alloc] initWithElement:@(4) next:nil];
    LinkNode *k4 = [[LinkNode alloc] initWithElement:@(2) next:k5];
    
    // 方法一
//    LinkNode *k = [self mergeTwoLists2:k1 k2:k4];
//    while (k) {
//        NSLog(@"%@",[k description]);
//        k = k.next;
//    }
    
    // 方法二 递归
    LinkNode *k = [self mergeTwoLists:k1 k2:k4];
    while (k) {
        NSLog(@"%@",[k description]);
        k = k.next;
    }
}

/// 方法一:合并2个有序链表
- (LinkNode *)mergeTwoLists2:(LinkNode *)k1 k2:(LinkNode *)k2 {
    if (k1 == nil) return k2;
    if (k2 == nil) return k1;
    
    // 虚拟头结点(dummy head)
    LinkNode *head = [[LinkNode alloc] init];
    LinkNode *cur = head;
    
    while (k1 != nil && k2 != nil) {
        if (k1.value <= k2.value) {
            cur = cur.next = k1;
            k1 = k1.next;
        } else {
            cur = cur.next = k2;
            k2 = k2.next;
        }
    }
    
    if (k1 == nil) {
        cur.next = k2;
    } else if (k2 == nil) {
        cur.next = k1;
    }
    
    return head.next;
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
