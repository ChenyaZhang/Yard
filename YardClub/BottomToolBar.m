//
//  BottomToolBar.m
//  YardClub
//
//  Created by Chenya Zhang on 10/5/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "BottomToolBar.h"

@implementation BottomToolBar

+ (NSArray *) createBottomToolBar {

    // Initialize button array and tool bar button array
    NSMutableArray *buttonItems = [[NSMutableArray alloc] init];
    NSMutableArray *toolBarButtonItems = [[NSMutableArray alloc] init];
    
    // Initialize buttons and set titles
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"REQUEST\nEQUIPMENT" forState:UIControlStateNormal];
    [buttonItems addObject:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"ACTIVE\nRENTALS" forState:UIControlStateNormal];
    [buttonItems addObject:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"OPEN\nREQUESTS" forState:UIControlStateNormal];
    [buttonItems addObject:button3];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"MY YARD" forState:UIControlStateNormal];
    [buttonItems addObject:button4];
    
    // Create a flexible tool bar item for alignment
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // Set button features and add to bar button array
    [toolBarButtonItems addObject:flexible];
    for (UIButton *button in buttonItems) {
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button sizeToFit];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",button.currentTitle]];
        if (toolBarButtonItems.count == 1) {
            [title addAttributes:@{
                                   NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:13.0],
                                   NSForegroundColorAttributeName: [UIColor colorWithRed:0.92 green:0.72 blue:0.11 alpha:1.0]
                                   } range:NSMakeRange(0, title.length)];
            [title addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(7, 10)];
        } else {
            [title addAttributes:@{
                                   NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:13.0],
                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                   } range:NSMakeRange(0, title.length)];
        }
        [button setAttributedTitle:title forState:UIControlStateNormal];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [toolBarButtonItems addObject:barItem];
        [toolBarButtonItems addObject:flexible];
    }
    return toolBarButtonItems;
}

@end
