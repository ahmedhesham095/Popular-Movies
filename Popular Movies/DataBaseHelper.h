//
//  DataBaseHelper.h
//  FriendsApp
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"


@interface DataBaseHelper : NSObject
@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

- (void) createDatase;
- (void) insert :(Movie*) f1;
- (void) deleteMovie : (Movie*)f1;
- (NSMutableArray*) retreive;

@end
