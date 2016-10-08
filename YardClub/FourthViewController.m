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

@interface FourthViewController () {
    NSMutableArray *featuredPhotos;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UILabel *chooseRentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *rentalStoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *contractorOwnedLabel;
@property (strong, nonatomic) IBOutlet UILabel *result1;
@property (strong, nonatomic) IBOutlet UILabel *result2;
@property (strong, nonatomic) IBOutlet UILabel *itemsForComparison;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *featuredPhotoImageViewCollection;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    // Load text data
    [FourthVCLoadText loadTextData1:^(NSDictionary *dict){
        if (dict) {
            NSLog(@"Zuozuo %@", dict);
        }
    }];
    
    [FourthVCLoadText loadTextData2:^(NSDictionary *dict){
        if (dict) {
            NSLog(@"Diudiu %@", dict);
        }
    }];
    
    [FourthVCLoadText loadNameData:^(NSString *name){
        if (name) {
            NSLog(@"Baobao %@", name);
            // UI update must be in mainQueue
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.nameLabel.text = name;
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
    NSAttributedString *result1Text = [[NSAttributedString alloc] initWithString:@"Result 1" attributes:@{
                                                                                                                              NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                                              NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                                              }];
    self.result1.attributedText = result1Text;
    
    // Add labels
    NSAttributedString *result2Text = [[NSAttributedString alloc] initWithString:@"Result 2" attributes:@{
                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"OpenSans-Bold" size:15.0],
                                                                                                          NSForegroundColorAttributeName: [UIColor blackColor]
                                                                                                          }];
    self.result2.attributedText = result2Text;
    
    // Add labels
    NSAttributedString *itemsForComparisonText = [[NSAttributedString alloc] initWithString:@"DESCRIPTION\n\nDAILY RATE\nWEEKLY RATE\nMONTHLY RATE\nOPERATED RATE" attributes:@{
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

- (void)loadData {
    featuredPhotos = [[NSMutableArray alloc]init];
    // NSURLSession
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://yardclub.github.io/mobile-interview/api/results.json"]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            // Convert the returned data into a dictionary.
            NSError *error;
            NSMutableArray *returnedDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            // Check if no returnedDict
            if (returnedDictionary == NULL) {
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
                featuredPhotos = [returnedDictionary valueForKey:@"featured_photos"];
            }
            
            int i = 0;
            for (UIImageView *imageView in self.featuredPhotoImageViewCollection) {
                dispatch_async(dispatch_queue_create("imageQueue", NULL), ^{
                    NSURL *url = [NSURL URLWithString:[featuredPhotos[i] valueForKey:@"url"]];
                    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:url];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.image = image;
                    });
                });
                i++;
            }
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
