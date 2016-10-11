//
//  FourthVCLoadText.h
//  YardClub
//
//  Created by Chenya Zhang on 10/8/16.
//  Copyright © 2016 Chenya Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myCompletion1)(NSDictionary *);
typedef void(^myCompletion2)(NSString *);

@interface FourthVCLoadText : NSObject
+ (void)loadTextData1:(myCompletion1) compblock;
+ (void)loadTextData2:(myCompletion1) compblock;
+ (void)loadNameData:(myCompletion2) compblock;
@end
