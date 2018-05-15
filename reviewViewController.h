//
//  reviewViewController.h
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/11/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ReviewDetail.h"

@interface reviewViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSString *movieID2;
@property NSDictionary *reviews;
@property NSArray *reviewData;
@property NSDictionary *review;
- (void) loadReviews;


@end
