//
//  ViewController.h
//  CALENDAR
//
//  Created by Evan Strange
//  Copyright © 2019 Evan Strange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <UIKit/UIView.h>
#import <sqlite3.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UIStackView *topStack;
@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *firstDate;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, strong) NSDate *date;
@property NSInteger initialSection;
@property NSDate *cellDate1;
@property (nonatomic, strong) NSString *stringDate;
@property (strong, nonatomic) NSData *xmlData2;

- (IBAction)todayButton:(id)sender;
- (IBAction)addEvent:(id)sender;


@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableString *currentNodeContent;
@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSString *query;


@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *descriptions;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end


