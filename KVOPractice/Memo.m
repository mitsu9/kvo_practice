//
//  Memo.m
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"

@interface Memo ()

@end

@implementation Memo

-(instancetype)initWithTitle:(NSString *)title memo:(NSString *)memo
{
    self = [super init];
    if(self){
        _title = title;
        _memo  = memo;
    }
    return self;
}

@end