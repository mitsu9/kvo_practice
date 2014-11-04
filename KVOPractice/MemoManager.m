//
//  MemoManager.m
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoManager.h"

@interface MemoManager ()

@end

@implementation MemoManager

+ (MemoManager *)sharedManager
{
    static MemoManager *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}

- (id)init
{
    self = [super init];
    if(self){
        self.memos = [NSMutableArray new];
    }
    return self;
}

/** メモを保存(追加)する */
- (void)addMemo:(Memo *)memo withBlock:(void (^)(BOOL))block
{
    // KVO 発火のため `mutableArrayValueForKey:` を介して insert する.
    [[self mutableArrayValueForKey:@"memos"] insertObjects:@[memo]
                                                 atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
}

@end