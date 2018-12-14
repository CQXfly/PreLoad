//
//  ModuleB.m
//  PreLoad
//
//  Created by fox on 2018/12/14.
//  Copyright © 2018 fox. All rights reserved.
//

#import "ModuleB.h"
#import "PreLoad.h"
@implementation ModuleB
PreLoadWithStage(Stage3, ModuleB, {
     NSLog(@"%@%@",self,@"\nStage3 启动任务1 执行");})
@end

@implementation ModuleB1
PreLoadWithStage(Stage3, ModuleB1, {
    NSLog(@"%@%@",self,@"\nStage3 启动任务2 执行");
})
@end
