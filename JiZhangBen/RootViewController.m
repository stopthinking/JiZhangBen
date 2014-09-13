//
//  RootViewController.m
//  JiZhangBen
//
//  Created by mac on 13-7-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "RootViewController.h"
#import "LookViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)buuildLableFrame:(CGRect)frame string:(NSString *)textString superView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor  blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = textString;
    [view addSubview:label];
    [label release];
}
-(void)buildWithTextFieldFrame:(CGRect)frame string:(NSString *)string superView:(UIView *)view tag:(NSInteger)tag
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleBezel;
    if ([[textArray objectAtIndex:tag-array.count-1] isEqualToString:@"0"]) {
        textField.placeholder = string;
    }else{
        textField.text = [textArray objectAtIndex:tag-array.count-1];
    }
    textField.tag = tag;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:textField];
    [textField release];
}
-(void)buildWithViewFrame:(CGRect)frame tag:(NSInteger)tag string:(NSString *)string superView:(UIView *)view
{
    UIView * articView = [[UIView alloc] initWithFrame:frame];
    articView.backgroundColor = [UIColor clearColor];
    articView.tag = tag;
    [view addSubview:articView];
    [self buuildLableFrame:CGRectMake(0, 3, 100, 30) string:string superView:articView];
    [self buildWithTextFieldFrame:CGRectMake(100, 5, 190, 30) string:string superView:articView tag:tag+array.count];
    
    UIPanGestureRecognizer * swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.delegate= self;
    [articView addGestureRecognizer:swipe];
    [swipe release];

    [articView release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, heigh)];
    scrollView.backgroundColor = self.view.backgroundColor;
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [scrollView addGestureRecognizer:tap];
    [tap release];
    
    array = [[NSMutableArray alloc] initWithObjects:@"早饭",@"午饭",@"晚饭",@"水果",@"零食",@"生活",@"水电",@"房租",@"医药",@"礼品",@"车票",@"其他", nil];
    textArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    [self build];
    
    UIView * datView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 256)];
    datView.backgroundColor = [UIColor clearColor];
    datView.tag = 666;
    
    dataPick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
    dataPick.datePickerMode = UIDatePickerModeDate;
    [datView addSubview:dataPick];
    [dataPick release];
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [datView addSubview:toolBar];
    [toolBar release];

    UIButton * saveButton = [[UIButton alloc] init];
    [saveButton setFrame:CGRectMake(240, 5, 60, 30)];
    [saveButton setBackgroundColor:[UIColor clearColor]];
    [saveButton setTintColor:[UIColor clearColor]];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:30];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [datView addSubview:saveButton];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setFrame:CGRectMake(20, 5, 30, 30)];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTintColor:[UIColor clearColor]];
    [addButton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [datView addSubview:addButton];
    
    UIButton * allButton = [[UIButton alloc] init];
    [allButton setFrame:CGRectMake(130, 5, 60, 30)];
    [allButton setBackgroundColor:[UIColor clearColor]];
    [allButton setTintColor:[UIColor clearColor]];
    [allButton setTitle:@"查看" forState:UIControlStateNormal];
    allButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:30];
    [allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(look) forControlEvents:UIControlEventTouchUpInside];
    [datView addSubview:allButton];
    
    [saveButton release];
    [allButton release];
    [scrollView addSubview:datView];
    [datView release];
    
    self.view = scrollView;
    [scrollView release];
}
-(void)build
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    for (int i=0; i<array.count; i++) {
        [self buildWithViewFrame:CGRectMake(0, 10+40*i, 320, 40) tag:i+1 string:[array objectAtIndex:i] superView:scrollView];
    }
    [[self.view viewWithTag:666] setFrame:CGRectMake(0, 10+40*array.count+10, 320, 256)];
    
    scrollView.contentSize = CGSizeMake(320, 10+40*array.count+10+256);
    [UIView commitAnimations];
}
#pragma mark - 取消键盘
-(void)tap:(UITapGestureRecognizer *)sender
{
    for (int i=0; i<array.count; i++) {
        [((UITextField *)[self.view viewWithTag:array.count+i+1]) resignFirstResponder];
    }
}
#pragma mark - 拖动删除
-(void)swipe:(UIPanGestureRecognizer *)swipe
{
    if (swipe.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [swipe locationInView:scrollView];
        if (abs(point.x - startPoint.x)>100 && abs(point.y - startPoint.y)<20) {
            int num = swipe.view.tag;
            for (int i=0; i<array.count; i++) {
                [[self.view viewWithTag:i+1] removeFromSuperview];
            }
            [array removeObjectAtIndex:num-1];
            [textArray removeObjectAtIndex:num-1];
            [self build];
        }
        
    }
}
#pragma mark - 保存
-(void)save
{
    UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定保存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = 888;
    [alerView show];
    [alerView release];
    [self textWhetherNill];
}
#pragma mark - 添加
-(void)add
{
    UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"             " message:@"           " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = 889;
    
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(75, 30, 125, 30)];
    textField.placeholder = @"请输入名称";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.font = [UIFont systemFontOfSize:20];
    [alerView addSubview:textField];
    textField.backgroundColor = self.view.backgroundColor;
    [textField release];
    [alerView show];
    [alerView release];
}
#pragma mark - 查看
-(void)look
{
    LookViewController * lookVC = [[LookViewController alloc] initWithNibName:@"LookViewController" bundle:nil];
    UINavigationController * navigationVC = [[UINavigationController alloc] initWithRootViewController:lookVC];
    [self presentViewController:navigationVC animated:YES completion:nil];
    [lookVC release];
    [navigationVC release];
}
#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textArray replaceObjectAtIndex:textField.tag-array.count-1 withObject:textField.text];
}
#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 888) {
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //获取路径
            //参数NSDocumentDirectory要获取那种路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
            //更改到待操作的目录下
            [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
            //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
            //获取文件路径
            //    [fileManager removeItemAtPath:@"username"error:nil];
            NSString * path = [documentsDirectory stringByAppendingPathComponent:@"cc.txt"];
            
            NSMutableData *writer1 = [[NSMutableData alloc] init];
            NSString * st = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSDate *select = [dataPick date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateAndTime =  [dateFormatter stringFromDate:select];
            [dateFormatter release];
            NSString * string = [[[NSMutableString alloc] init] autorelease];
            if (st == nil) {
                for (int i=0; i<array.count; i++) {
                    string = [string stringByAppendingFormat:@"%@：%@    ",[array objectAtIndex:i],((UITextField *)[self.view viewWithTag:array.count+i+1]).text];
                }
            }else{
                string = [string stringByAppendingFormat:@"%@\n",st];
                for (int i=0; i<array.count; i++) {
                    string = [string stringByAppendingFormat:@"%@：%@    ",[array objectAtIndex:i],((UITextField *)[self.view viewWithTag:array.count+i+1]).text];
                }
            }
            string = [string stringByAppendingFormat:@"日期：%@",dateAndTime];
            //将字符串添加到缓冲中
            [writer1 appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
            //将其他数据添加到缓冲中
            //将缓冲的数据写入到文件中
            BOOL yesOrNo = [writer1 writeToFile:path atomically:YES];
            [writer1 release];
            
            if (yesOrNo) {
                UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alerView show];
                [alerView release];
                
                for (int i=0; i<array.count; i++) {
                    ((UITextField *)[self.view viewWithTag:array.count+i+1]).text = nil;
                }
            }
        }else{
            for (id view in alertView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    if (((UITextField *)view).text != nil) {
                        for (int i=0; i<array.count; i++) {
                            [[self.view viewWithTag:i+1] removeFromSuperview];
                        }
                        [array addObject:((UITextField *)view).text];
                        [textArray addObject:@"0"];
                        [self build];
                    }else{
                        UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alerView show];
                        [alerView release];
                    }
                }
            }
        }
    }
    
}
#pragma mark - 没有输入为0
-(void)textWhetherNill
{
    for (int i=0; i<array.count; i++) {
        if (((UITextField *)[self.view viewWithTag:array.count+i+1]).text == nil) {
            ((UITextField *)[self.view viewWithTag:array.count+i+1]).text = @"0";
        }
    }
}
#pragma mark - UIGestureRecognizerDelegate delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    startPoint = [gestureRecognizer locationInView:scrollView];
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





- (void)dealloc
{
    dataPick = nil;
    [array release],array = nil;
    scrollView = nil;
    [textArray release],textArray = nil;
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
