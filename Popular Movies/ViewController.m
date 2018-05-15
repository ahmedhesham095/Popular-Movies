//
//  ViewController.m
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/10/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    _txtOverview.backgroundColor = [UIColor lightGrayColor];
    _lblName.text = [_movieData objectForKey:@"title"];
    _lblDate.text = [_movieData objectForKey:@"release_date"];
    NSNumber *vote = [_movieData objectForKey:@"vote_average"];
    NSString *voteStr = [vote stringValue];
    _lblVote.text = voteStr;
    _lblTitle.text = [_movieData objectForKey:@"original_language"];
    _txtOverview.text = [_movieData objectForKey:@"overview"];
    NSString *imgUrl = [_movieData objectForKey:@"backdrop_path"];
    NSString *baseUrl = @"http://image.tmdb.org/t/p/w185";
    NSString *url = [NSString stringWithFormat: @"%@%@", baseUrl, imgUrl];
    NSLog(@"%@",url);
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    [_imgPoster setImage:[UIImage imageWithData:imageData]];
    [_imgPoster sd_setImageWithURL:[NSURL URLWithString:url]];

    _imgPoster.contentMode = UIViewContentModeScaleAspectFit;
//    DataBaseHelper *h1 = [DataBaseHelper new];
//    [h1 createDatase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTrailers:(id)sender {
    NSString *idmovie =  [_movieData objectForKey:@"id"];
    trailerViewController *trailers = [self.storyboard instantiateViewControllerWithIdentifier:@"trailer"];
    trailers.movieID = idmovie;
    [self.navigationController pushViewController:trailers animated:YES];

}

- (IBAction)btnReviews:(id)sender {
    NSString *idmovie =  [_movieData objectForKey:@"id"];
    reviewViewController *review = [self.storyboard instantiateViewControllerWithIdentifier:@"review"];
    review.movieID2 = idmovie;
    [self.navigationController pushViewController:review animated:YES];

}
- (IBAction)btnFavorite:(id)sender {
    NSString *name = [_movieData objectForKey:@"title"];
    NSString *year = [_movieData objectForKey:@"release_date"];
    NSString *imgUrl = [_movieData objectForKey:@"backdrop_path"];
    NSString *baseUrl = @"http://image.tmdb.org/t/p/w185";
    NSString *url = [NSString stringWithFormat: @"%@%@", baseUrl, imgUrl];
    Movie *m1 = [Movie new];
    m1.name = name;
    m1.releaseYear = year;
    m1.imgPath = url;
    DataBaseHelper *h2 = [DataBaseHelper new];
    [h2 createDatase];
    [h2 insert:m1];
    
}
@end
