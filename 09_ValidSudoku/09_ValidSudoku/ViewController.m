//
//  ViewController.m
//  09_ValidSudoku
//
//  Created by chenshuang on 2019/12/8.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"

/// 有效的数独
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray<NSArray *> *board = @[
                      @[@"5",@"3",@".",@".",@"7",@".",@".",@".",@"."],
                      @[@"6",@".",@".",@"1",@"9",@"5",@".",@".",@"."],
                      @[@".",@"9",@"8",@".",@".",@".",@".",@"6",@"."],
                      @[@"8",@".",@".",@".",@"6",@".",@".",@".",@"3"],
                      @[@"4",@".",@".",@"8",@".",@"3",@".",@".",@"1"],
                      @[@"7",@".",@".",@".",@"2",@".",@".",@".",@"6"],
                      @[@".",@"6",@".",@".",@".",@".",@"2",@"8",@"."],
                      @[@".",@".",@".",@"4",@"1",@"9",@".",@".",@"5"],
                      @[@".",@".",@".",@".",@"8",@".",@".",@"7",@"9"]];
    
    NSArray<NSArray *> *board1 = @[
                                  @[@"8",@"3",@".",@".",@"7",@".",@".",@".",@"."],
                                  @[@"6",@".",@".",@"1",@"9",@"5",@".",@".",@"."],
                                  @[@".",@"9",@"8",@".",@".",@".",@".",@"6",@"."],
                                  @[@"8",@".",@".",@".",@"6",@".",@".",@".",@"3"],
                                  @[@"4",@".",@".",@"8",@".",@"3",@".",@".",@"1"],
                                  @[@"7",@".",@".",@".",@"2",@".",@".",@".",@"6"],
                                  @[@".",@"6",@".",@".",@".",@".",@"2",@"8",@"."],
                                  @[@".",@".",@".",@"4",@"1",@"9",@".",@".",@"5"],
                                  @[@".",@".",@".",@".",@"8",@".",@".",@"7",@"9"]];
    
//    BOOL result = [self isValidSudoku:board];
//    BOOL result1 = [self isValidSudoku:board1];
    
//    BOOL result = [self isValidSudoku2:board];
//    BOOL result1 = [self isValidSudoku2:board1];
    
    BOOL result = [self isValidSudoku3:board];
    BOOL result1 = [self isValidSudoku3:board1];
    
    NSLog(@"result = %d, result2 = %d",result,result1);
}

/// 有效的数独
- (BOOL)isValidSudoku:(NSArray<NSArray *> *)board {
    NSMutableArray<NSMutableArray *> *rows = [NSMutableArray array];
    NSMutableArray<NSMutableArray *> *cols = [NSMutableArray array];
    NSMutableArray<NSMutableArray *> *boxes = [NSMutableArray array];
    // 赋值数据
    for (int i = 0; i < 9; i++) {
        [rows addObject:[NSMutableArray array]];
        [cols addObject:[NSMutableArray array]];
        [boxes addObject:[NSMutableArray array]];
    }
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            NSString *num = board[row][col];
            if ([num isEqualToString:@"."]) {
                continue;
            }
            
            if ([rows[row] containsObject:num]) {
                return false;
            }
            if ([cols[col] containsObject:num]) {
                return false;
            }
            // 计算每个数字所在九宫格的位置
            int boxIndex = (row / 3) * 3 + col / 3;
            if ([boxes[boxIndex] containsObject:num]) {
                return false;
            }
            
            // 表示未出现过,则添加进数组中
            [rows[row] addObject:num];
            [cols[col] addObject:num];
            [boxes[boxIndex] addObject:num];
        }
    }
    return true;
}

/// 有效的数独
- (BOOL)isValidSudoku2:(NSArray<NSArray *> *)board {
    NSMutableArray<NSMutableArray *> *rows = [NSMutableArray array];
    NSMutableArray<NSMutableArray *> *cols = [NSMutableArray array];
    NSMutableArray<NSMutableArray *> *boxes = [NSMutableArray array];
    
    // 赋值数据 - bool类型数据
    for (int i = 0; i < 9; i++) {
        NSMutableArray<NSNumber *> *bools = [NSMutableArray array];
        for (int j = 0; j < 9; j++) {
            [bools addObject:@(0)];
        }
        [rows addObject:bools.mutableCopy];
        [cols addObject:bools.mutableCopy];
        [boxes addObject:bools.mutableCopy];
    }
    
    int temNum = 0;
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            NSString *num = board[row][col];
            if ([num isEqualToString:@"."]) {
                continue;
            }
            temNum = num.intValue - 1;
            if ([rows[row][temNum] intValue]) {    // 表示之前第row行,temNum列出现过num元素
                return false;
            }
            if ([cols[col][temNum] intValue]) {    // 表示之前第col行,temNum列出现过num元素
                return false;
            }
            // 计算每个数字所在九宫格的位置
            int boxIndex = (row / 3) * 3 + col / 3;
            if ([boxes[boxIndex][temNum] intValue]) {
                return false;
            }
            
            // 表示未出现过,在temNum位置置为1
            rows[row][temNum] = @(1);
            cols[col][temNum] = @(1);
            boxes[boxIndex][temNum] = @(1);
        }
    }
    return true;
}

/// 有效的数独
- (BOOL)isValidSudoku3:(NSArray<NSArray *> *)board {
    NSMutableArray<NSNumber *> *rows = [NSMutableArray array];
    NSMutableArray<NSNumber *> *cols = [NSMutableArray array];
    NSMutableArray<NSNumber *> *boxes = [NSMutableArray array];
    
    // 赋值数据
    for (int i = 0; i < 9; i++) {
        [rows addObject:@(0)];
        [cols addObject:@(0)];
        [boxes addObject:@(0)];
    }
    
    /** 解释说明 第一行第一列为5的时候
     9 8 7 6 5 4 3 2 1
     0 0 0 0 0 0 0 0 0
     0 0 0 0 1 0 0 0 0 &
     -------------------
     0 0 0 0 0 0 0 0 0 如果为零,表示5之前没有出现过,否则出现过
     */
    int temNum = 0;
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            NSString *num = board[row][col];
            if ([num isEqualToString:@"."]) {
                continue;
            }
            temNum = 1 << (num.intValue - 1);   // 比如5,则1左移4位
            if ((rows[row].intValue & temNum) != 0) {
                return false;
            }
            if ((cols[col].intValue & temNum) != 0) {
                return false;
            }
            // 计算每个数字所在九宫格的位置
            int boxIndex = (row / 3) * 3 + col / 3;
            if ((boxes[boxIndex].intValue & temNum) != 0) {
                return false;
            }
            
            // 表示未出现过,在temNum位置置为1
            // 比如 row = 0,col = 0, num = 5,则在第5个位置为1,即1左移4位, 0 0 0 0 1 0 0 0 0
            rows[row] = @(rows[row].intValue + (1 << (num.intValue - 1)));
            cols[col] = @(cols[col].intValue + (1 << (num.intValue - 1)));
            boxes[boxIndex] = @(boxes[boxIndex].intValue + (1 << (num.intValue - 1)));
        }
    }
    return true;
}

@end
