//
//  MoviesViewController.h
//  MoviesApp
//
//  Created by JETS on 5/6/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "favoriteViewController.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <SDWebImagePrefetcher.h>
#import <UIImageView+Webcache.h>
@interface MoviesViewController : UICollectionViewController< NSURLConnectionDelegate , NSURLConnectionDataDelegate , UIAlertViewDelegate>
@property NSMutableData *mydata ;
@property NSDictionary *myjson;
@property NSArray *movieArray;
@property NSDictionary *Object;
- (IBAction)btnPopular:(id)sender;
- (IBAction)btnTopRated:(id)sender;
- (void) loadJson;
//- (IBAction)btnFavorite:(id)sender;

@end
