//
//  trailerViewController.h
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/11/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface trailerViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSString* movieID;
@property NSDictionary *trailers;
@property NSArray *trailerData;
@property NSDictionary *trailer;
- (void) loadTrailers;

@end



