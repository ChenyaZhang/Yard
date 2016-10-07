//
//  FirstViewController.m
//  YardClub
//
//  Created by Chenya Zhang on 10/4/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "FirstViewController.h"
#import "BottomToolBar.h"
#import "UIBarButtonItem+Badge.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (strong, nonatomic) IBOutlet UILabel *featuredEquipmentLabel;
@property (strong, nonatomic) IBOutlet UILabel *chooseRentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *rentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *contractorOwnedLabel;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add custom title and buttons to top navigation bar
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"REQUEST EQUIPMENT" attributes:@{
                                                                                                            NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:18.0],
                                                                                                            NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                                            }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.attributedText = title;
    // Set bar button item with image
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone-call"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:nil];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.badgeValue = @"15";
    self.navigationItem.leftBarButtonItem.badgeTextColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem.badgeBGColor = [UIColor colorWithRed:0.92 green:0.72 blue:0.11 alpha:1.0];
    self.navigationItem.leftBarButtonItem.badgeFont = [UIFont fontWithName:@"OpenSans-Bold" size:13.0];
    // Set bar button item image tint color
    leftBarButton.tintColor = [UIColor colorWithRed:0.92 green:0.72 blue:0.11 alpha:1.0];
    rightBarButton.tintColor = [UIColor colorWithRed:0.92 green:0.72 blue:0.11 alpha:1.0];
    // Add buttons to navigation bar
    self.topNavigationBar.titleView = titleLabel;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [self.navigationItem.titleView sizeToFit];
    
    // Add labels
    NSAttributedString *featuredEquipmentText = [[NSAttributedString alloc] initWithString:@"FEATURED EQUIPMENT" attributes:@{
                                                                                                             NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                             NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                             }];
    self.featuredEquipmentLabel.attributedText = featuredEquipmentText;

    NSAttributedString *chooseRentalStoreText = [[NSAttributedString alloc] initWithString:@"CHOOSE A RENTAL STORE" attributes:@{
                                                                                                                              NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                              NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                              }];
    self.chooseRentalStoreLabel.attributedText = chooseRentalStoreText;
    
    NSAttributedString *rentalStoreText = [[NSAttributedString alloc] initWithString:@"RENTAL STORE" attributes:@{
                                                                                                                                 NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:14.0],
                                                                                                                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                 }];
    self.rentalStoreLabel.attributedText = rentalStoreText;
    
    NSAttributedString *contractorOwnedText = [[NSAttributedString alloc] initWithString:@"CONTRACTOR-OWNED" attributes:@{
                                                                                                                  NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:14.0],
                                                                                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                  }];
    self.contractorOwnedLabel.attributedText = contractorOwnedText;
    
    NSAttributedString *label1Text = [[NSAttributedString alloc] initWithString:@"Newest rental fleet in the industry" attributes:@{
                                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"OpenSans" size:14.0],
                                                                                                                          NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                          }];
    self.label1.numberOfLines = 0;
    self.label1.attributedText = label1Text;
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
    // Add image page control
    self.imagePageControl.numberOfPages = 5;
    self.imagePageControl.currentPage = 1;
    
    // Add custom bar buttons to bottom tool bar
    NSArray *toolBarButtonItems = [BottomToolBar createBottomToolBar];
    [self.bottomToolBar setItems:toolBarButtonItems animated:YES];
    
    // Reorder views
    [self.view bringSubviewToFront:self.imagePageControl];
    [self.view bringSubviewToFront:self.bottomToolBar];
}

- (IBAction)tabYardClubAction:(UIButton *)sender {
    SecondViewController *catalogViewController = [[SecondViewController alloc] init];
    catalogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self.navigationController showViewController:catalogViewController sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
