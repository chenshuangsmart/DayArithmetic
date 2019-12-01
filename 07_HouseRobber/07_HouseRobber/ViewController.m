//
//  ViewController.m
//  07_HouseRobber
//
//  Created by chenshuang on 2019/11/30.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *nums = @[@2,@6,@9,@3,@1];
    
    /// 递归 - 从前往后偷
//    int max = [self rob:nums];
    
    /// 递归 - 从后往前偷
//    int max = [self rob1:nums];
    
    /// 非递归 - 从后往前偷
//    int max = [self rob2:nums];
    
    /// 非递归 - 从后往前偷
//    int max = [self rob3:nums];
    
    /// 非递归 - 从后往前偷 - 更精简
    int max = [self rob4:nums];
    
    NSLog(@"max=%d",max);
}

/// 思路1 - 递归 - 从前往后偷
- (int)rob:(NSArray<NSNumber *> *)nums {
    if (nums.count <= 0) {
        return 0;
    }
    return [self rob:nums from:0];
}

/// 从第from号房屋开始从前往后偷
- (int)rob:(NSArray<NSNumber *> *)nums from:(NSInteger)from {
    if (from == nums.count - 1) {   // 从最后一个开始偷
        return [nums[from] intValue];
    }
    if (from == nums.count - 2) {   // 从倒数第二个开始偷
        return MAX([nums[from] intValue], [nums[from + 1] intValue]);
    }
    // 从第from房间开始偷
    int robCur = [nums[from] intValue] + [self rob:nums from:from + 2];
    // 从第from + 1房间开始偷
    int robNext = [self rob:nums from:from + 1];
    // 返回较大值
    return MAX(robCur, robNext);
}

/// 思路1 - 递归 - 从后往前偷
- (int)rob1:(NSArray<NSNumber *> *)nums {
    if (nums.count <= 0) {
        return 0;
    }
    return [self rob1:nums from:nums.count - 1];
}

/// 从第from号房屋开始从后往前偷
- (int)rob1:(NSArray<NSNumber *> *)nums from:(NSInteger)from {
    if (from == 0) {   // 从第一个开始偷
        return [nums[0] intValue];
    }
    if (from == 1) {   // 从第二个开始偷
        return MAX([nums[0] intValue], [nums[1] intValue]);
    }
    // 从第from房间开始偷
    int robCur = [nums[from] intValue] + [self rob1:nums from:from - 2];
    // 从第from - 1房间开始偷
    int robNext = [self rob1:nums from:from - 1];
    // 返回较大值
    return MAX(robCur, robNext);
}


/**
 非递归 - 从后往前偷
 利用数组存放前n个房屋的最高偷窃金额
*/
- (int)rob2:(NSArray<NSNumber *> *)nums {
    if (nums.count <= 0) {
        return 0;
    }
    if (nums.count == 1) {
        return [nums[0] intValue];
    }
    // 构造初始值数组 array[i] - 表示从第i个房间开始偷,可以偷到的最大金额
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < nums.count; i++) {
        [array addObject:@(-1)];
    }
    
    // 赋值第0,1个元素
    array[0] = nums[0];
    array[1] = @(MAX([nums[0] intValue], [nums[1] intValue]));
    
    // 再计算之后的值
    for (int i = 2; i < array.count; i++) {
        array[i] = @(MAX([nums[i] intValue] + [array[i - 2] intValue], [array[i - 1] intValue]));
    }
    
    return [array[nums.count - 1] intValue];
}

/**
 非递归 - 从后往前偷
 细心观察可以发现:每次计算只需要用到2个数组元素,所以改成使用两个整形的变量即可
 */
- (int)rob3:(NSArray<NSNumber *> *)nums {
    if (nums.count <= 0) {
        return 0;
    }
    if (nums.count == 1) {
        return [nums[0] intValue];
    }
    // 赋值第0,1个元素
    int preV = [nums[0] intValue];
    int cur = MAX([nums[0] intValue], [nums[1] intValue]);
    int tmp = [nums[0] intValue];
    // 再计算之后的值
    for (int i = 2; i < nums.count; i++) {
        tmp = cur;
        cur = MAX([nums[i] intValue] + preV, cur);
        preV = tmp;
    }
    
    return cur;
}

/**
 非递归 - 从后往前偷
 可以更精简一下代码
 */
- (int)rob4:(NSArray<NSNumber *> *)nums {
    if (nums.count <= 0) {
        return 0;
    }
    int cur = 0;
    int prev = 0;
    int tmp = 0;
    // 再计算之后的值
    for (NSNumber *num in nums) {
        tmp = cur;
        cur = MAX([num intValue] + prev, cur);
        prev = tmp;
    }
    
    return cur;
}

@end
