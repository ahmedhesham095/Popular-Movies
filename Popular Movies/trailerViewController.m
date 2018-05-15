//
//  trailerViewController.m
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/11/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import "trailerViewController.h"

@implementation trailerViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadTrailers];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return _trailerData.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"cell2";
        UITableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    _trailer= [ _trailerData objectAtIndex:indexPath.item];
    NSString *name = [_trailer valueForKey:@"name"];
    NSLog(@"%@" , name);
        cell.textLabel.text=name;
    cell.imageView.image = [UIImage imageNamed:@"play.png"];
        return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _trailer= [ _trailerData objectAtIndex:indexPath.item];
     NSString *key = [_trailer valueForKey:@"key"];
    NSString *baseUrl = @"https://www.youtube.com/watch?v=";
    NSString *urlstr = [NSString stringWithFormat: @"%@%@", baseUrl, key];
    NSLog(@"%@",urlstr);
    NSURL *url = [NSURL URLWithString:urlstr];
    [[UIApplication sharedApplication] openURL:url];
    
}


- (void) loadTrailers{
        NSString *basevideo = @"http://api.themoviedb.org/3/movie/";
        NSString *videokey = @"/videos?api_key=08d87e5d880ff0f74eaefa9f6be83a80";
        NSString *urlstr = [NSString stringWithFormat: @"%@%@%@", basevideo,_movieID, videokey];
        NSLog(@"%@",_movieID);
        NSLog(@"%@",urlstr);
        NSURL *url = [[NSURL alloc]initWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            _trailers = (NSDictionary *)responseObject;
            _trailerData = [_trailers objectForKey:@"results"];
            self.tableView.reloadData;
            NSLog(@"Done Loading Trailers ....");
            NSLog(@"%@" , _trailerData);
    
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR  ...!!!");
        }];
        [operation start];
    
}

@end
