//
//  ViewController.h
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/10/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImagePrefetcher.h>
#import <UIImageView+Webcache.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "trailerViewController.h"
#import "reviewViewController.h"
#import "Movie.h"
#import "DataBaseHelper.h"

@interface ViewController : UIViewController
@property NSDictionary *movieData;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UILabel *lblVote;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoster;
@property (weak, nonatomic) IBOutlet UITextView *txtOverview;
- (IBAction)btnTrailers:(id)sender;
- (IBAction)btnReviews:(id)sender;
@property NSDictionary *trailers;
@property NSArray *trailerData;
- (IBAction)btnFavorite:(id)sender;

@end

