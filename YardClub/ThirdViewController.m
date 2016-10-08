//
//  ThirdViewController.m
//  YardClub
//
//  Created by Chenya Zhang on 10/5/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "ThirdViewController.h"
#import "SecondViewController.h"
#import "BottomToolBar.h"
#import "FourthViewController.h"

@interface ThirdViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UILabel *chooseRentalStoreLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ThirdViewController {
    NSMutableArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize table data
    [self loadData];
    
    // Add custom buttons to top navigation bar
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone-call"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    // Add buttons to navigation bar
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    // Add labels
    NSAttributedString *chooseRentalStoreText = [[NSAttributedString alloc] initWithString:@"WHAT KIND OF EQUIPMENT ARE YOU LOOKING FOR?" attributes:@{
                                                                                                                                                       NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                                                       NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                                       }];
    self.chooseRentalStoreLabel.attributedText = chooseRentalStoreText;
    self.chooseRentalStoreLabel.numberOfLines = 0;
    
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
    FourthViewController *resultViewController = [[FourthViewController alloc] init];
    resultViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
    [self.navigationController showViewController:resultViewController sender:self];
}

- (void)loadData {
    tableData = [[NSMutableArray alloc]init];
    // NSURLSession
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yardclub.github.io/mobile-interview/api/catalog/%@.json", self.categoryID]]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            // Convert the returned data into a dictionary.
            NSError *error;
            NSMutableArray *returnedArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            // Check if no returnedDict
            if (returnedArray == NULL) {
                NSLog(@"No return data available for display!");
            } else if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
                // No error
            } else {
                // If no error occurs, check the HTTP status code.
                NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                // If it's other than 200, then show it on the console.
                if (HTTPStatusCode != 200) {
                    NSLog(@"HTTP status code = %ld!", (long)HTTPStatusCode);
                }
                for (int i = 0; i < returnedArray.count; i++) {
                    NSDictionary *objectDict = [returnedArray objectAtIndex:i];
                    NSString *value = [objectDict valueForKey:@"display_name"];
                    [tableData addObject:value];
                }
            }
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
