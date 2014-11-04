//
//  Memo.h
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memo : NSObject

/** メモのタイトル */
@property (nonatomic, readonly) NSString *title;

/** メモの内容 */
@property (nonatomic, readonly) NSString *memo;


/** タイトルと内容から `Memo` を初期化する
 
 @param  title タイトル
 @param  memo  メモの内容
 @return `Memo`
*/
- (instancetype)initWithTitle:(NSString*)title memo:(NSString*)memo;




@end
