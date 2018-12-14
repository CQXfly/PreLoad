//
//  ViewController.m
//  PreLoad
//
//  Created by fox on 2018/12/14.
//  Copyright © 2018 fox. All rights reserved.
//

#import "ViewController.h"
#import "PreLoad.h"
@interface ViewController ()

@end

@implementation ViewController

PreLoadWithStage(Stage1, ViewController, {
    NSLog(@"i ‘m your dady");
})

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"执行Stage1 ====================================");
        [[PreLoad shared] executeArrayForKey:Stage1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"执行Stage2 ====================================");
        [[PreLoad shared] executeArrayForKey:Stage2];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"执行Stage3 ====================================");
        [[PreLoad shared] executeArrayForKey:Stage3];
    });
}


@end
