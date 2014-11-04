//
//  AddModalView.m
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import "AddModalView.h"

@interface AddModalView ()
@property (nonatomic, strong) id keyboardObserver;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *memoTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) IBOutlet UIView *dismissView;
@end

@implementation AddModalView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // xibの読み込み
        UINib *nib = [UINib nibWithNibName:@"AddModalView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];
        self.frame = frame;
        
        // 背景を透過させる
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        
        // キーボードの高さが変更されたときの通知を受け取る
        self.keyboardObserver = [[NSNotificationCenter defaultCenter]
                                 addObserverForName:UIKeyboardWillChangeFrameNotification
                                 object:nil
                                 queue:nil
                                 usingBlock:^(NSNotification *note) {
                                     [self keyboardWillChangeFrame:note];
                                 }];
        
        // タップされたときの通知を受け取る
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressDismissView:)];
        [self.dismissView addGestureRecognizer:tapGesture];
    }
    return self;
}

/** キーボードの高さが変わった時に呼ばれる
 
 キーボードが出てきたとき、ビューを上にスライドする
 キーボードが戻ると、ビューも元の位置に戻す
*/
- (void)keyboardWillChangeFrame:(NSNotification*)notification
{
    // 変化後のキーボードのframe
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self convertRect:keyboardRect fromView:nil];
    
    // キーボードの高さが変わるアニメーションの時間
    double animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // キーボードの位置は全体の高さからキーボードの高さを引けばわかる
    CGFloat keyboardHeight = self.bounds.size.height - keyboardRect.origin.y;
    
    // キーボードの高さ分だけconstantを高くする
    self.keyboardHeight.constant = keyboardHeight;
    
    // レイアウトを変える必要がある.
    [UIView animateWithDuration:animationDuration animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark -
#pragma mark TextField delegate

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    // キーボードを隠す.
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark IBAction

/** Addボタンが押された時に呼ばれる
 
 押された時の処理をdelegate先でおこなう
*/
- (IBAction)pressAdd:(id)sender
{
    if([self.delegate respondsToSelector:@selector(didPressAddbtnWithTitle:memo:)]){
        [self.delegate didPressAddbtnWithTitle:self.titleTextField.text memo:self.memoTextField.text];
    }
    [self pressDismissView:nil];
}

/** ブラックアウトしているビューがタップされた時に呼ばれる
 
 このモーダルビューを閉じる処理をdelegate先でおこなう
*/
- (void)pressDismissView:(UITapGestureRecognizer *)sender
{
    if([self.delegate respondsToSelector:@selector(closeModalView:)]){
        [self.delegate closeModalView:self];
    }
}

@end