//
//  ViewController.h
//  KVOPractice
//
//  Created by 本間 光宣 on 2014/11/03.
//  Copyright (c) 2014年 rayc5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddModalView.h"

@interface ViewController : UIViewController <ModalViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

