//
//  FourthVCLoadImage.m
//  YardClub
//
//  Created by Chenya Zhang on 10/8/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "FourthVCLoadImage.h"

static NSMutableArray *featuredPhotos;

@implementation FourthVCLoadImage

+ (void)loadImageData: (myCompletion) compblock {
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
                
                compblock([featuredPhotos copy]);
            }
        }
    }] resume];
}

@end
