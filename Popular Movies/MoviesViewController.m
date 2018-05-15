//
//  MoviesViewController.m
//  MoviesApp
//
//  Created by JETS on 5/6/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "MoviesViewController.h"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   self.title =@"Movies";
    _mydata = [NSMutableData new];
    [self loadJson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadJson{
    NSString *urlstr =[NSString stringWithFormat:@"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=08d87e5d880ff0f74eaefa9f6be83a80"];
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
       AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _myjson = (NSDictionary *)responseObject;
        _movieArray = [_myjson objectForKey:@"results"];
        self.collectionView.reloadData;
        NSLog(@"Done ....");
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR  ...!!!");
          }];
    [operation start];
}

//- (IBAction)btnFavorite:(id)sender {
//    favoriteViewController *fav = [self.storyboard instantiateViewControllerWithIdentifier:@"favorite"];
//    [self.navigationController pushViewController:fav animated:YES];
//    
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _movieArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:1];
    _Object = [ _movieArray objectAtIndex:indexPath.item];
    NSString *imgUrl = [_Object objectForKey:@"poster_path"];
    NSString *name = [_Object objectForKey:@"title"];
    NSLog(@"%@",name);
    NSLog(@"%@",imgUrl);
    NSString *baseUrl = @"http://image.tmdb.org/t/p/w185";
    NSString *url = [NSString stringWithFormat: @"%@%@", baseUrl, imgUrl];
    NSLog(@"%@",url);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    [[SDImageCache sharedImageCache] removeImageForKey:imageData fromDisk:YES];
    //recipeImageView.image =[UIImage imageWithData:imageData];
   // recipeImageView.image.sd_setImageWithURL(imageData);
    [recipeImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];

    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    NSLog(@"%d",item);
    NSLog(@"%s","ITEM SELECTED");
    _Object = [ _movieArray objectAtIndex:indexPath.item];
    NSString *name = [_Object objectForKey:@"title"];
    NSLog(@"%@",name);
     ViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detail.movieData = _Object ;
    [self.navigationController pushViewController:detail animated:YES];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will Appear");
}


- (IBAction)btnPopular:(id)sender {
    NSString *urlstr =[NSString stringWithFormat:@"http://api.themoviedb.org/3/discover/movie?sort_by=vote_average.desc&api_key=08d87e5d880ff0f74eaefa9f6be83a80"];
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _myjson = (NSDictionary *)responseObject;
        _movieArray = [_myjson objectForKey:@"results"];
        self.collectionView.reloadData;
        NSLog(@"Done ....");
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR  ...!!!");
    }];
    [operation start];
}

- (IBAction)btnTopRated:(id)sender {
    [self loadJson];
}
@end
