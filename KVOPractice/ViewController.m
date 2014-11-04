//
//  ViewController.m
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import "ViewController.h"

#import "MemoManager.h"
#import "MemoCell.h"
#import "AddModalView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // KVO で `MemoManager` の `memos` を監視する.
    [[MemoManager sharedManager] addObserver:self
                                          forKeyPath:@"memos"
                                             options:NSKeyValueObservingOptionNew
                                             context:nil];
    
    // cellの登録
    UINib *nib = [UINib nibWithNibName:@"MemoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MemoCell"];
    
    // テーブルビューの高さを自動的に設定してくれる
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** KVOで変更があった際に呼ばれる
 
 @param keypath
 @param object
 @param change
 @param context
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == [MemoManager sharedManager] && [keyPath isEqualToString:@"memos"]){
        // 配列が変更された場所のインデックス
        NSIndexSet *indexSet = change[NSKeyValueChangeIndexesKey];
        
        // 変更の種類.
        NSKeyValueChange changeKind = (NSKeyValueChange)[change[NSKeyValueChangeKindKey] integerValue];
        
        // 配列に詰め替え.
        NSMutableArray *indexPaths = [NSMutableArray array];
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }];
        
        // `memos` の変更の種類に合わせて TableView を更新.
        [self.tableView beginUpdates]; // 更新開始.
        if (changeKind == NSKeyValueChangeInsertion) {
            // 新しく追加されたとき.
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if (changeKind == NSKeyValueChangeRemoval) {
            // 取り除かれたとき.
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if (changeKind == NSKeyValueChangeReplacement) {
            // 値が更新されたとき.
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [self.tableView endUpdates]; // 更新終了.
    }
}

/** Addボタンが押された時に呼ばれる
 タイトルとメモを入力するモーダルを表示
*/
- (IBAction)pressAdd:(id)sender {
    CGRect frame = self.view.frame;
    AddModalView *modalView = [[AddModalView alloc] initWithFrame:frame];
    [self.view addSubview:modalView];
    modalView.delegate = self;
}

#pragma mark -
#pragma mark TableView datasource

/** セクション内のセルの個数を返す */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[MemoManager sharedManager].memos count];
}

/** 指定されたインデックスのセルを返す */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MemoCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/** セルの中身を設定する */
- (void)configureCell:(MemoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Memo *memo = [MemoManager sharedManager].memos[(NSUInteger) indexPath.row];

    cell.title.text = memo.title;
    cell.memo.text  = memo.memo;
}

# pragma mark -
# pragma mark TableView delegate

/** セルがタップされたときに呼ばれる */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        // タップされた場所のメモの情報をもとに編集画面を作成する
    }
}

#pragma mark -
#pragma mark ModalView delegate

/** モーダルビューの追加ボタンが押されたときに呼ばれる
 受け取ったタイトルとメモからオブジェクトを生成し保存する
*/
- (void)didPressAddbtnWithTitle:(NSString *)title memo:(NSString *)memo
{
    Memo *memoObj = [[Memo alloc] initWithTitle:title memo:memo];
    [[MemoManager sharedManager] addMemo:memoObj withBlock:^(BOOL success){}];
}

/** モーダルビューを閉じる */
- (void)closeModalView:(UIView *)modalView
{
    [modalView removeFromSuperview];
}

@end
