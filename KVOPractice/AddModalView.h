//
//  AddModalView.h
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewDelegate;

@interface AddModalView : UIView

/** delegateオブジェクト */
@property (nonatomic, weak) id <NSObject, ModalViewDelegate> delegate;

@end

@protocol ModalViewDelegate

/** 確定ボタンが押された時に呼び出す */
- (void)didPressAddbtnWithTitle:(NSString*)title memo:(NSString*)memo;

/** モーダルを閉じるときに呼び出す */
- (void)closeModalView:(UIView*)view;

@end
