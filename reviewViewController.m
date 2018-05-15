//
//  reviewViewController.m
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/11/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import "reviewViewController.h"

@implementation reviewViewController

- (void)viewDidLoad{
    [super viewDidLoad];
   
    [self loadReviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return _reviewData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"cell3";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    _review= [_reviewData objectAtIndex:indexPath.item];
    NSString *name = [_review valueForKey:@"author"];
    NSLog(@"%@" , name);
    cell.textLabel.text=name;
    return cell;
}

-(void)tableView:(UICollectionView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    NSLog(@"%d",item);
    NSLog(@"%s","ITEM SELECTED");
    _review = [ _reviewData objectAtIndex:indexPath.item];
    NSString *name = [_review objectForKey:@"content"];
    NSLog(@"%@",name);
    ReviewDetail *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"reviewDetail"];
    detail.review = name ;
    [self.navigationController pushViewController:detail animated:YES];
    
}






-(void) loadReviews{
    NSString *basevideo = @"http://api.themoviedb.org/3/movie/";
    NSString *videokey = @"/reviews?api_key=08d87e5d880ff0f74eaefa9f6be83a80";
    NSString *urlstr = [NSString stringWithFormat: @"%@%@%@", basevideo,_movieID2, videokey];
    NSLog(@"%@",_movieID2);
    NSLog(@"%@",urlstr);
    NSURL *url = [[NSURL alloc]initWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _reviews = (NSDictionary *)responseObject;
        _reviewData = [_reviews objectForKey:@"results"];
        self.tableView.reloadData;
        NSLog(@"Done Loading Trailers ....");
        NSLog(@"%@" , _reviewData);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR  ...!!!");
    }];
    [operation start];
    
    
    
}

@end
