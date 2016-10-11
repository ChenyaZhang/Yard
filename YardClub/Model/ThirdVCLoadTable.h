//
//  ThirdVCLoadTable.h
//  YardClub
//
//  Created by Chenya Zhang on 10/9/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myCompletion)(NSArray *);
// NSString *categoryID;

@interface ThirdVCLoadTable : NSObject
+ (void)loadTableData:(myCompletion) compblock;
@end
