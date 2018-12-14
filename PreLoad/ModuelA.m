//
//  ModuelA.m
//  PreLoad
//
//  Created by fox on 2018/12/14.
//  Copyright © 2018 fox. All rights reserved.
//

#import "ModuelA.h"
#import "PreLoad.h"
@implementation ModuelA
PreLoadWithStage(Stage2, ModuelA, {
    NSLog(@"%@%@",self,@"\nStage2 启动任务1 执行");
})

@end


@implementation ModuelA1
PreLoadWithStage(Stage2, ModuelA1, {
    NSLog(@"%@%@",self,@"\nStage2 启动任务2 执行");
})

@end
