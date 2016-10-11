//
//  ThirdVCLoadTable.m
//  YardClub
//
//  Created by Chenya Zhang on 10/9/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import "ThirdVCLoadTable.h"

static NSMutableArray *tableData;

@implementation ThirdVCLoadTable

+ (void)loadTableData: (myCompletion) compblock {
    tableData = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *categoryID = [[NSUserDefaults standardUserDefaults] stringForKey:@"subcategoryRow"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yardclub.github.io/mobile-interview/api/catalog/%@.json", categoryID]]];
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
                
                compblock([tableData copy]);
            }
        }
    }] resume];
}

@end
