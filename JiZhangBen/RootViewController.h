//
//  RootViewController.h
//  JiZhangBen
//
//  Created by mac on 13-7-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIAlertViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UIDatePicker * dataPick;    
    NSMutableArray * array;
    UIScrollView * scrollView;
    CGPoint startPoint;
    NSMutableArray * textArray;
}


@end;
