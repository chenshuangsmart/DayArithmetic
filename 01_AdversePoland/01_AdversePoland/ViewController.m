//
//  ViewController.m
//  01_AdversePoland
//
//  Created by chenshuang on 2019/10/30.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *values = @[@"21+3*"];
    // 计算逆波兰表达式的值
    for (int i = 0; i < values.count; i++) {
        [self calculateValue:values[i]];
    }
}

- (void)calculateValue:(NSString *)value {
    Stack *stack = [[Stack alloc] init];
    
    NSMutableArray *strs = [NSMutableArray array];
    for (int i = 0; i < value.length; i++) {
        [strs addObject:[value substringWithRange:NSMakeRange(i, 1)]];
    }
    
    for (NSString *str in strs) {
        if ([str isEqualToString:@"+"]) {
            [stack push:@(stack.popInt + stack.popInt)];
        } else if ([str isEqualToString:@"-"]) {
            [stack push:@(-stack.popInt + stack.popInt)];
        } else if ([str isEqualToString:@"*"]) {
            [stack push:@(stack.popInt * stack.popInt)];
        } else if ([str isEqualToString:@"/"]) {
            NSInteger right = stack.popInt;
            [stack push:@(stack.popInt / right)];
        } else {
            [stack push:@([str intValue])];
        }
    }
    NSLog(@"表达式:%@, 值:%d",value,stack.popInt);
}

@end
