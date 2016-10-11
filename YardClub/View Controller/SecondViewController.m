//
//  SecondViewController.m
//  YardClub
//
//  Created by Chenya Zhang on 10/4/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "BottomToolBar.h"
#import "FirstViewController.h"
#import "SecondVCLoadTable.h"
#import "ThirdVCLoadTable.h"

@interface SecondViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UILabel *chooseRentalStoreLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SecondViewController {
    NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize table data
    [SecondVCLoadTable loadTableData:^(NSArray *data){
        if (data.count > 0) {
            tableData = data;
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    
    // Add custom buttons to top navigation bar
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone-call"] style:UIBarButtonItemStylePlain target:self action:nil];

    // Add buttons to navigation bar
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    // Add labels
    NSAttributedString *chooseRentalStoreText = [[NSAttributedString alloc] initWithString:@"WHAT KIND OF EQUIPMENT ARE YOU LOOKING FOR?" attributes:@{
                                                                                                                                 NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                 }];
    self.chooseRentalStoreLabel.numberOfLines = 0;
    self.chooseRentalStoreLabel.attributedText = chooseRentalStoreText;
    
    // Add custom bar buttons to bottom tool bar
    NSArray *toolBarButtonItems = [BottomToolBar createBottomToolBar];
    [self.bottomToolBar setItems:toolBarButtonItems animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"TableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *row = [NSString stringWithFormat:@"%li", (long)indexPath.row + 1];
    [[NSUserDefaults standardUserDefaults] setObject:row forKey:@"subcategoryRow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ThirdViewController *detailViewController = [[ThirdViewController alloc] init];
    detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
    [self.navigationController showViewController:detailViewController sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
