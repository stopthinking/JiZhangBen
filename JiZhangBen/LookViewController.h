//
//  LookViewController.h
//  JiZhangBen
//
//  Created by mac on 13-8-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableArray * allArray;
    NSMutableArray * openOrCloseArray;
    NSMutableArray * changArr;
    NSString * path;
    UITextField * selectTextField;
    BOOL back;
}


@end
