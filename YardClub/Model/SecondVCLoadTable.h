//
//  SecondVCLoadTable.h
//  YardClub
//
//  Created by Chenya Zhang on 10/8/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myCompletion)(NSArray *);

@interface SecondVCLoadTable : NSObject
+ (void)loadTableData:(myCompletion) compblock;
@end
