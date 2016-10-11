//
//  FourthViewController.m
//  YardClub
//
//  Created by Chenya Zhang on 10/5/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "FourthViewController.h"
#import "ThirdViewController.h"
#import "BottomToolBar.h"
#import "UIImage+animatedGIF.h"
#import "FourthVCLoadText.h"
#import "FourthVCLoadImage.h"

@interface FourthViewController ()

@property (strong, nonatomic) IBOutlet UINavigationItem *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UILabel *chooseRentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *rentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *contractorOwnedLabel;
@property (strong, nonatomic) IBOutlet UILabel *choiceA;
@property (strong, nonatomic) IBOutlet UILabel *choiceB;
@property (strong, nonatomic) IBOutlet UILabel *itemsForComparison;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *featuredPhotoImageViewCollection;
@property (strong, nonatomic) IBOutlet UILabel *choiceAContent;
@property (strong, nonatomic) IBOutlet UILabel *choiceBContent;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load text data
    [FourthVCLoadText loadTextData1:^(NSDictionary *dict){
        if (dict) {
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSAttributedString *choiceAContentText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@\n\n%@\n\n%@\n%@\n%@\n%@", [dict objectForKey:@"name"], [dict objectForKey:@"description"], [dict objectForKey:@"daily_rate"], [dict objectForKey:@"weekly_rate"], [dict objectForKey:@"monthly_rate"], [dict objectForKey:@"operated_rates"]] attributes:@{
                                                                                                                                                                                                                                                                                                                                                                                                 NSFontAttributeName: [UIFont fontWithName:@"OpenSans" size:15.0],
                                                                                                                                                                                                                                                                                                                                                                                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                                                                                                                                                                                                                                                                                 }];
                self.choiceAContent.numberOfLines = 0;
                self.choiceAContent.attributedText = choiceAContentText;
            }];
        }
    }];
    
    [FourthVCLoadText loadTextData2:^(NSDictionary *dict){
        if (dict) {
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSAttributedString *choiceBContentText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@\n%@\n\n%@\n%@\n%@\n%@", [dict objectForKey:@"name"], [dict objectForKey:@"description"], [dict objectForKey:@"daily_rate"], [dict objectForKey:@"weekly_rate"], [dict objectForKey:@"monthly_rate"], [dict objectForKey:@"operated_rates"]] attributes:@{
                                                                                                                                                                                                                                                                                                                                                                                               NSFontAttributeName: [UIFont fontWithName:@"OpenSans" size:15.0],
                                                                                                                                                                                                                                                                                                                                                                                               NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                                                                                                                                                                                                                                                                               }];
                self.choiceBContent.numberOfLines = 0;
                self.choiceBContent.attributedText = choiceBContentText;
            }];
        }
    }];
    
    [FourthVCLoadText loadNameData:^(NSString *name){
        if (name) {
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.nameLabel.text = name;
            }];
        }
    }];
    
    // Load image data
    [FourthVCLoadImage loadImageData:^(NSArray *images){
        if (images) {
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                int i = 0;
                for (UIImageView *imageView in self.featuredPhotoImageViewCollection) {
                    NSURL *url = [NSURL URLWithString:[images[i] valueForKey:@"url"]];
                    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:url];
                    imageView.image = image;
                    i++;
                }
            }];
        }
    }];
    
    // Add text data
    self.nameLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:15.0];
    
    // Add custom buttons to top navigation bar
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone-call"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    // Add buttons to navigation bar
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    NSAttributedString *chooseRentalStoreText = [[NSAttributedString alloc] initWithString:@"YOUR FINAL RESULT IS HERE" attributes:@{
                                                                                                                                     NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                                     NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                     }];
    self.chooseRentalStoreLabel.attributedText = chooseRentalStoreText;
    
    // Add labels
    NSAttributedString *result1Text = [[NSAttributedString alloc] initWithString:@"Choice A" attributes:@{
                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                          NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                          }];
    self.choiceA.attributedText = result1Text;
    
    // Add labels
    NSAttributedString *result2Text = [[NSAttributedString alloc] initWithString:@"Choice B" attributes:@{
                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                          NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                          }];
    self.choiceB.attributedText = result2Text;
    
    // Add labels
    NSAttributedString *itemsForComparisonText = [[NSAttributedString alloc] initWithString:@"\nNAME\n\nDESCRIPTION\n\n\nDAILY RATE\nWEEKLY RATE\nMONTHLY RATE\nOPERATED RATE" attributes:@{
                                                                                                                                                                                            NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                                                                                            NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                                                                                            }];
    self.itemsForComparison.numberOfLines = 0;
    self.itemsForComparison.attributedText = itemsForComparisonText;
    
    // Add custom bar buttons to bottom tool bar
    [self.view bringSubviewToFront:self.nameLabel];
    NSArray *toolBarButtonItems = [BottomToolBar createBottomToolBar];
    [self.bottomToolBar setItems:toolBarButtonItems animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
