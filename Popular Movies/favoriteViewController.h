//
//  favoriteViewController.h
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/15/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "DataBaseHelper.h"
#import <SDWebImagePrefetcher.h>
#import <UIImageView+Webcache.h>

@interface favoriteViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *favorites;

@end
