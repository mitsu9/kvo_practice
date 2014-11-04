//
//  MemoManager.h
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Memo.h"

@interface MemoManager : NSObject

/** メモを保存する配列 */
@property NSMutableArray *memos;


/** シングルトンの管理オブジェクトを得る
 
 return `MemoManager`
*/
+ (MemoManager*)sharedManager;


/** メモを保存する
 
 @param memo `Memo` オブジェクト.
 @param block 完了後に呼び出される blocks.
*/
- (void)addMemo:(Memo*)memo withBlock:(void (^)(BOOL success))block;

@end