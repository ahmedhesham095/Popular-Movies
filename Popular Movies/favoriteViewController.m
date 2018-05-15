//
//  favoriteViewController.m
//  Popular Movies
//
//  Created by Ahmed Hesham on 5/15/18.
//  Copyright © 2018 Ahmed Hesham. All rights reserved.
//

#import "favoriteViewController.h"

@implementation favoriteViewController

- (void)viewDidLoad{
    [super viewDidLoad];
//     self=@"Favourites";
    self.title = @"Favorites";
    _favorites = [NSMutableArray new];
//    DataBaseHelper *h1 = [DataBaseHelper new];
//    [h1 createDatase];
//    _favorites = [h1 retreive];
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    [tableHeaderView setBackgroundColor:[UIColor blueColor]];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10,320,25)];
//    headerLabel.text = @"Header view";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    [tableHeaderView addSubview:headerLabel];
    [self.tableView setTableHeaderView:tableHeaderView];
    self.tableView.reloadData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return _favorites.count;
}
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    [tableView layoutIfNeeded];
    return @"Favorites";
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"cell4";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Movie *m1 = [Movie new ];
    m1 = [_favorites objectAtIndex:indexPath.row];
//    _review= [_reviewData objectAtIndex:indexPath.item];
    NSString *name = m1.name;
    NSString *year = m1.releaseYear;
    NSString *img = m1.imgPath;
    NSLog(@"%@" , name);
    
    cell.textLabel.text=name;
    cell.detailTextLabel.text=year;
     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:img]];
  //  self.tableView.reloadData;

        return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Movie *f1 = [Movie new];
        f1 = [_favorites objectAtIndex:indexPath.row];
        DataBaseHelper *h1 = [DataBaseHelper new];
        [h1 createDatase];
        [h1 deleteMovie:f1];
        [_favorites removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s", "view will appear favorites");
    [super viewWillAppear:animated];
//    self.tableView.reloadData;
//    [Self reloadInputViews reload];
    DataBaseHelper *h1 = [DataBaseHelper new];
    [h1 createDatase];
    _favorites = [h1 retreive];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    [self.tableView reloadData];
    
}


@end
