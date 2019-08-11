//
//  CreateEventViewController.m
//  CALENDAR
//
//  Created by Evan Strange
//  Copyright © 2019 Evan Strange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateEventViewController.h"
#import <sqlite3.h>
@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self.editType layer] setBorderColor:[[UIColor blueColor] CGColor]];
    [[self.editType layer] setBorderWidth:.4];
    [[self.editType layer] setCornerRadius:8.0f];
    [[self.editDescription layer] setBorderColor:[[UIColor blueColor] CGColor]];
    [[self.editDescription layer] setBorderWidth:.4];
    [[self.editDescription layer] setCornerRadius:8.0f];
    self.title = @"Add Event";
    _dateLabel.text = _stringDate;
    
    NSArray *dirPaths = nil;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
            char *errMsg;
            
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS EVENTS (TYPE TEXT, DESCRIPTION TEXT, DATE TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// hide keyboard when textfields are out of focus

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_editType isFirstResponder] && (_editType != touch.view)) {
        // _inputText lost focus - close keyboard
        [_editType resignFirstResponder];
    }
    
    if ([_editDescription isFirstResponder] && (_editDescription != touch.view)) {
        // _inputText lost focus - close keyboard
        [_editDescription resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)saveFind:(id)sender {
 
   
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
  
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
           
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO EVENTS (TYPE, DESCRIPTION, DATE) VALUES (\"%@\", \"%@\", \"%@\")", _editType.text, _editDescription.text, _stringDate];
            
         //   NSLog(@"type is: %@", _editType.text);
         //  NSLog(@"type is: %@", _editDescription.text);
        //  NSLog(@"date is: %@", _stringDate);
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(_contactDB, insert_stmt,
                               -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE) {
                _status.text = @"Event added";
                _editType.text = @"";
                _editDescription.text = @"";
                
            } else {
                _status.text = @"Failed to add event";
            }
            
            
            
            sqlite3_finalize(statement);
            sqlite3_close(_contactDB);
        }
  
    
 
    
}

@end

