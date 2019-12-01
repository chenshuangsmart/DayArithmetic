//
//  ViewController.m
//  08_KFrequentElements
//
//  Created by chenshuang on 2019/12/1.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *nums = @[@1,@1,@1,@2,@2,@3];
    NSArray *result = [self kFrequentElements:nums k:2];
    
    for (NSDictionary *dict in result) {
        NSLog(@"%@=%@",dict.allKeys.firstObject,dict.allValues.firstObject);
    }
}

- (NSArray *)kFrequentElements:(NSArray<NSNumber *> *)nums k:(NSInteger)k {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    // 查看出现的次数
    for (NSNumber *number in nums) {
        NSNumber *value = [param objectForKey:number];
        if (value) {
            [param setObject:@([value intValue] + 1) forKey:number];
        } else {
            [param setObject:@(1) forKey:number];
        }
    }
    
    // 对出现的次数进行排序
    NSArray *allTimes = [param.allValues sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    
    // 将出现次数进行排序,从大到小排序
    NSMutableArray *sortArrM = [NSMutableArray array];
    for (NSNumber *time in allTimes) {
        [sortArrM insertObject:[NSDictionary dictionaryWithObjectsAndKeys:time,[param allKeysForObject:time].firstObject, nil] atIndex:0];
    }
    
    return sortArrM;
}

@end
