//
//  MyCell.m
//  JiZhangBen
//
//  Created by mac on 13-8-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
@synthesize label;
@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor  lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label release];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 190, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.backgroundColor = [UIColor clearColor];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.textColor = [UIColor lightGrayColor];
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [self.contentView addSubview:textField];
        [textField release];
    }
    return self;
}
- (void)dealloc
{
    label = nil;
    textField = nil;
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
