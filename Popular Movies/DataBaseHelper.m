//
//  DataBaseHelper.m
//  FriendsApp
//
//  Created by JETS on 4/30/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "DataBaseHelper.h"

@implementation DataBaseHelper

- (void) createDatase{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"contacts.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, IMG TEXT, YEAR TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        NSLog(@"Failed to open/create database");
    }
   
 
}
- (void) insert:(Movie *)f1{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) { NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name, img, year) VALUES (\"%@\", \"%@\", \"%@\")", [f1 name], [f1 imgPath], [f1 releaseYear]];
        const char *insert_stmt = [insertSQL UTF8String]; sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Movie added");
        } else {
            NSLog(@"Failed to add movie");
            NSLog(@"%@",[f1 name]);
            NSLog(@"%@",[f1 imgPath]);
            NSLog(@"%@",[f1 releaseYear]);
        } sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
}
- (void) deleteMovie:(Movie *)f1{
    sqlite3_stmt *deleteStmt;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) { NSString *sql = [NSString stringWithFormat:@"delete from CONTACTS where name =\"%@\"",[f1 name]];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(_contactDB, del_stmt, -1, & deleteStmt, NULL);
        if (sqlite3_step(deleteStmt) == SQLITE_DONE)
        {
          NSLog(@"Movie deleted");
        } else {
            NSLog(@"Failed to delete movie");
            NSLog(@"%@",[f1 name]);
        }
        sqlite3_finalize(deleteStmt);
        sqlite3_close(_contactDB);
}
}
- (NSMutableArray*)retreive{
    NSMutableArray *movies = [NSMutableArray new]
    ;
    sqlite3_stmt *stmt;
    int rc=0;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
        NSString * query = @"SELECT * from CONTACTS ";
        
        rc =sqlite3_prepare_v2(_contactDB, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW) //get each row in loop
            {
                
                NSString * name =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString * img =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
               NSString * year =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                Movie *f1 = [Movie new];
                f1.name =name;
                f1.releaseYear = year;
                f1.imgPath = img;
                
                [movies addObject: f1];
                NSLog(@"name: %@, phone=%@ , address =%@",name,img,year);
                
            }
            NSLog(@"Done");
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_finalize(stmt);
        sqlite3_close(_contactDB);
    
    }

    return movies;
}


@end
