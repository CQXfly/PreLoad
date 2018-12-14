//
//  PreLoad.h
//  PreLoad
//
//  Created by fox on 2018/12/14.
//  Copyright © 2018 fox. All rights reserved.
//

#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <mach-o/ldsyms.h>
#import <UIKit/UIKit.h>

typedef void PreLoadFunc(void);

#define Stage1 "Stage1"
#define Stage2 "Stage2"
#define Stage3 "Stage3"

#define PreLoadWithStage(KEY,Module,Value)  \
+ (void)PreLoad{\
Value\
}\
void Module##load (){\
[Module  PreLoad]; \
}\
void * Module##loaddd  __attribute__((used,section("__DATA,"#KEY",regular,no_dead_strip")))  = Module##load;\

NS_ASSUME_NONNULL_BEGIN

@interface PreLoad : NSObject
{
@public PreLoadFunc ** loadStage1[128];
@public PreLoadFunc ** loadStage2[128];
@public PreLoadFunc ** loadStage3[128];
}
@property (nonatomic,assign) NSInteger stage1Len;
@property (nonatomic,assign) NSInteger stage2Len;
@property (nonatomic,assign) NSInteger stage3Len;
+ (instancetype) shared;
- (void) executeArrayForKey:(char *)key;
@end

NS_ASSUME_NONNULL_END
