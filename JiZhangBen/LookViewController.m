//
//  LookViewController.m
//  JiZhangBen
//
//  Created by mac on 13-8-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "LookViewController.h"
#import "MyCell.h"

@interface LookViewController ()

@end

@implementation LookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem * leftBarBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBarBI;
    [leftBarBI release];
    
    
    UIBarButtonItem * rightBarBI = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(change)];
    self.navigationItem.rightBarButtonItem = rightBarBI;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [rightBarBI release];
    
    allArray = [[NSMutableArray alloc] init];
    openOrCloseArray = [[NSMutableArray alloc] init];
    
    
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
    path = [[documentsDirectory stringByAppendingPathComponent:@"cc.txt"] retain];
    NSString * st = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray * array = [st componentsSeparatedByString:@"\n"];
    
    for (int i=0; i<array.count; i++) {
        NSArray * subArray = [[array objectAtIndex:i] componentsSeparatedByString:@"    "];
        [allArray insertObject:subArray atIndex:0];
        if (i == 0) {
            [openOrCloseArray addObject:@"1"];
        }else{
            [openOrCloseArray addObject:@"0"];
        }
        
        subArray = nil;
    }
    array = nil;

    UITableView * listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, heigh-44) style:UITableViewStylePlain];
    listTableView.tag = 444;
    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.dataSource = self;
    listTableView.sectionHeaderHeight = 40;
    listTableView.delegate = self;
    listTableView.separatorColor = [UIColor blackColor];
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTableView];
    [listTableView release];
    back = NO;
}
#pragma mark - 返回
-(void)back
{
    if (self.navigationItem.rightBarButtonItem.enabled) {
        back = YES;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据已经更改，需要保存数据吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 889;
        [alertView show];
        [alertView release];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - 保存
-(void)change
{
    if (changArr != nil) {
        [self textFieldDidEndEditing:selectTextField];
    }else{
        NSMutableData *writer1 = [[NSMutableData alloc] init];
        NSString * string = [[[NSMutableString alloc] init] autorelease];
        
        for (int i=allArray.count-1; i>=0; i--) {
            for (int j=0; j<[[allArray objectAtIndex:i] count]; j++) {
                if (j != [[allArray objectAtIndex:i] count]-1) {
                    string = [string stringByAppendingFormat:@"%@    ",[[allArray objectAtIndex:i] objectAtIndex:j]];
                }else{
                    string = [string stringByAppendingFormat:@"%@",[[allArray objectAtIndex:i] objectAtIndex:j]];
                }
            }
            if (i != 0) {
                string  = [string stringByAppendingFormat:@"\n"];
            }
        }
        
        [writer1 appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        //将其他数据添加到缓冲中
        //将缓冲的数据写入到文件中
        BOOL yesOrNo = [writer1 writeToFile:path atomically:YES];
        [writer1 release];
        if (yesOrNo) {
            UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alerView show];
            [alerView release];
        }
        self.navigationItem.rightBarButtonItem.enabled = NO;
        if (back) {
            [self back];
            back = NO;
        }
    }
}
#pragma mark - section开关
-(void)openOrClose:(UITapGestureRecognizer *)tap
{
    if ([[openOrCloseArray objectAtIndex:tap.view.tag] isEqualToString:@"0"]) {
        [openOrCloseArray replaceObjectAtIndex:tap.view.tag withObject:@"1"];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [((UITableView *)[self.view viewWithTag:444]) reloadData];
        [[self.view viewWithTag:444] setFrame:CGRectMake(0, 44, 320, heigh-44)];
        [UIView commitAnimations];
    }else{
        [openOrCloseArray replaceObjectAtIndex:tap.view.tag withObject:@"0"];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [((UITableView *)[self.view viewWithTag:444]) reloadData];
        [[self.view viewWithTag:444] setFrame:CGRectMake(0, 44, 320, heigh-44)];
        [UIView commitAnimations];
    }
    
}
#pragma mark - UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allArray.count;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[openOrCloseArray objectAtIndex:section] isEqualToString:@"0"]) {
        return 0;
    }else{
         return [[allArray objectAtIndex:section] count]-1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    if (!cell) {
        cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"list"] autorelease];
        UIImage * iamge = [UIImage imageNamed:@"cell.png"];
        UIImageView * cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40.5f, 320, 3.5f)];
        cellImageView.image = [iamge stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        [cell.contentView addSubview:cellImageView];
        iamge = nil;
        [cellImageView release];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * stringArray = [[[allArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] componentsSeparatedByString:@"："];

    cell.label.text = [NSString stringWithFormat:@"%@：",[stringArray objectAtIndex:0]];
    cell.textField.placeholder = cell.label.text;
    cell.textField.text = [stringArray objectAtIndex:1];
    cell.textField.delegate = self;
    cell.contentView.tag = indexPath.section;
    
    int num = 0;
    for (int i=0; i<indexPath.section; i++) {
        num += [[allArray objectAtIndex:i] count];
    }
    cell.textField.tag = 100 + num + indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<allArray.count; i++) {
        for (int j=0; j<[[allArray objectAtIndex:i] count]; j++) {
            NSIndexPath * index = [NSIndexPath indexPathForRow:j inSection:i];
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:index];
            for (id view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    [(UITextField *)view resignFirstResponder];
                }
            }
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    view.backgroundColor = self.view.backgroundColor;
    view.tag = section;
    
    int num = [[allArray objectAtIndex:section] count];
    NSString * string = [[allArray objectAtIndex:section] objectAtIndex:num-1];
    NSArray * strArray = [string componentsSeparatedByString:@"："];
    NSString * str = [strArray objectAtIndex:strArray.count-1];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 260, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:28];
    label.text = str;
    [view addSubview:label];
    [label release];
    
    UIImageView * colorView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 4.5)];
    colorView1.userInteractionEnabled = YES;
    colorView1.image = [UIImage imageNamed:@"tiao.png"];
    [view addSubview:colorView1];
    [colorView1 release];

    UIImageView * colorView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35.5, 320, 4.5)];
    colorView2.userInteractionEnabled = YES;
    colorView2.image = [UIImage imageNamed:@"tiao1.png"];
    [view addSubview:colorView2];
    [colorView2 release];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openOrClose:)];
    [view addGestureRecognizer:tap];
    [tap release];
    
    return view;
}
#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(changArr == nil){
        changArr = [[NSMutableArray alloc] init];
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    selectTextField = [textField retain];
    [[self.view viewWithTag:444] setFrame:CGRectMake(0, 44, 320, heigh-44-216)];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int num = textField.tag-100;
    for (int i=0; i<textField.superview.tag; i++) {
        num -= [[allArray objectAtIndex:i] count];
    }
    NSArray * stringArray = [[[allArray objectAtIndex:textField.superview.tag] objectAtIndex:num] componentsSeparatedByString:@"："];
    if (![textField.text isEqualToString:[stringArray objectAtIndex:1]]) {
        if(textField.text.length == 0){
            textField.text = @"0";
        }
        [changArr addObject:[NSString stringWithFormat:@"%d",textField.superview.tag]];
        [changArr addObject:[NSString stringWithFormat:@"%d",num]];
        [changArr addObject:[NSString stringWithFormat:@"%@%@",textField.placeholder,textField.text]];
        [changArr addObject:[stringArray objectAtIndex:1]];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据需要更改吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 888;
        [alert show];
        [alert release];
        [[self.view viewWithTag:444] setFrame:CGRectMake(0, 44, 320, heigh-44)];
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [textField resignFirstResponder];
        [[self.view viewWithTag:444] setFrame:CGRectMake(0, 44, 320, heigh-44)];
    }
    
}
#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 888) {
        if (buttonIndex == 1) {
            [[allArray objectAtIndex:[[changArr objectAtIndex:0] integerValue]] replaceObjectAtIndex:[[changArr objectAtIndex:1] integerValue] withObject:[changArr objectAtIndex:2]];
        }else{
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:[[changArr objectAtIndex:1] integerValue] inSection:[[changArr objectAtIndex:0] integerValue]];
            UITableViewCell * cell = [((UITableView *)[self.view viewWithTag:444]) cellForRowAtIndexPath:indexpath];
            for (id view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    ((UITextField *)view).text = [changArr objectAtIndex:3];
                }
            }            
        }
        [changArr removeAllObjects];
        [changArr release],changArr = nil;
        if (alertView.tag == 888 && buttonIndex == 1) {
            [self change];
            [selectTextField resignFirstResponder];
        }
    }else{
        if (buttonIndex == 1) {
            [self change];
        }
        if (changArr == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
- (void)dealloc
{
    [allArray release],allArray = nil;
    [openOrCloseArray release],openOrCloseArray = nil;
    changArr = nil;
    [path release],path = nil;
    [selectTextField release],selectTextField = nil;
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
