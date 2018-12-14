//
//  PreLoad.m
//  PreLoad
//
//  Created by fox on 2018/12/14.
//  Copyright © 2018 fox. All rights reserved.
//

#import "PreLoad.h"

#ifndef __LP64__
typedef uint32_t MemoryType;
#else /* defined(__LP64__) */
typedef uint64_t MemoryType;
#endif /* defined(__LP64__) */

void reaadFunc(char *sectionName, const struct mach_header *mhp) ;
static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{

     reaadFunc(Stage1, mhp);
     reaadFunc(Stage2, mhp);
     reaadFunc(Stage3, mhp);
}

__attribute__((constructor))
void initProphet() {
    _dyld_register_func_for_add_image(dyld_callback);
}

void reaadFunc(char *sectionName, const struct mach_header *mhp) {
    
    unsigned long size = 0;
#ifndef __LP64__
    MemoryType *memory = (MemoryType*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    MemoryType *memory = (MemoryType*)getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif
    
    long counter = size/sizeof( void *);
    
    if (sectionName == Stage1) {
        for(int idx = 0; idx < counter; ++idx){
            PreLoadFunc * my = (PreLoadFunc *)memory[idx];
            [PreLoad shared]->loadStage1[idx] = my;
        }
        
        if (counter > 0) {
            [PreLoad shared].stage1Len = counter;
        }
    } else if (sectionName == Stage2) {
        for(int idx = 0; idx < counter; ++idx){
            PreLoadFunc * my = (PreLoadFunc *)memory[idx];
            [PreLoad shared]->loadStage2[idx] = my;
        }
        
        if (counter > 0) {
            [PreLoad shared].stage2Len = counter;
        }
    } else if (sectionName == Stage3) {
        for(int idx = 0; idx < counter; ++idx){
            PreLoadFunc * my = (PreLoadFunc *)memory[idx];
            [PreLoad shared]->loadStage3[idx] = my;
        }
        
        if (counter > 0) {
            [PreLoad shared].stage3Len = counter;
        }
    }
}

@implementation PreLoad
+ (instancetype) shared {
    static dispatch_once_t onceToken;
    static PreLoad * lan ;
    dispatch_once(&onceToken, ^{
        lan = [[PreLoad alloc] init];
    });
    return  lan;
}

- (void) executeArrayForKey:(char *)key {
    if (key == Stage1) {
        for( int i = 0 ; i < self.stage1Len; i ++) {
            PreLoadFunc * f = (PreLoadFunc *)self->loadStage1[i];
            f();
        }
    } else if (key == Stage2) {
        for( int i = 0 ; i < self.stage2Len; i ++) {
            PreLoadFunc * f = (PreLoadFunc *)self->loadStage2[i];
            f();
        }
    } else if (key == Stage3) {
        for( int i = 0 ; i < self.stage3Len; i ++) {
            PreLoadFunc * f = (PreLoadFunc *)self->loadStage3[i];
            f();
        }
    }
}
@end
