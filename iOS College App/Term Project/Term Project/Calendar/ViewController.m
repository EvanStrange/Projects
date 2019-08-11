//
//  ViewController.m
//  CALENDAR
//
//  Created by Evan Strange
//  Copyright © 2019 Evan Strange. All rights reserved.
//

#import "ViewController.h"
#import "CalendarCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "EventViewController.h"
#import "CreateEventViewController.h"
#import "AppDelegate.h"
#import <UIKit/UIView.h>
#import <sqlite3.h>
@interface ViewController ()

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation ViewController
UIImageView *navBarHairlineImageView;
BOOL _viewDidLayoutSubviewsForTheFirstTime = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _viewDidLayoutSubviewsForTheFirstTime = YES;
    self.title = @"Calendar";
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_xmlData2];
    
    [parser setDelegate:self];
    [parser parse];
    
    if (!_calendar) {
        [self setCalendar:[NSCalendar currentCalendar]];
    }
    //NSLog(@"stdate is: %@", _stringDate);
    _date = [[NSDate alloc] init];
    
    NSDateComponents *components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_date];
    
    
    
    // set calendar from 2000 to current year + 10 years range
    
    long year = components.year;
    long month = components.month;
    //long day = components.day;
    
    //NSLog(@"%ld %ld %ld", day, month, year);
    
    _initialSection = (year - 2000) * 12 + month - 1; // index sections start at 0
    
    components.day = 1;
    components.month = 1;
    components.year = 2000;
    _firstDate = [_calendar dateFromComponents:components];
    
    components.year = year + 10;
    components.day = -1;
    _lastDate = [_calendar dateFromComponents:components];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navBarHairlineImageView = [self findHairlineImageViewUnder:navigationBar];
    
    UIView *bottomBorder = [[UIView alloc] init];
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, _topStack.frame.size.height - 0.5, _topStack.frame.size.width, 0.5);
    [_topStack addSubview:bottomBorder];
    
    // events
    
    self.title = @"Calendar";
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSData *data = appDelegate.data;
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *b = [a stringByReplacingOccurrencesOfString:@"&#95;" withString:@"\n"];
    data = [b dataUsingEncoding:NSUTF8StringEncoding];
    
    // NSLog(@"%@", b);
    /*
    _parser = [[NSXMLParser alloc] initWithData:data];
    _events = [[NSMutableArray alloc] init];
    [_parser setDelegate:self];
    [_parser parse];
    [self executeQuery];
    
    */
    
    //NSLog(@"%@", _events);
    
    //    [_events addObject:@"2018-07-23"];
    //    [_events addObject:@"2018-07-24"];
    //    [_events addObject:@"2018-07-01"];
    //    [_events addObject:@"2018-07-06"];
    
    
}



// find and remove hairline image under top barx`

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated {
    
    navBarHairlineImageView.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated {
    [self viewDidLoad];
    [_calendarCollectionView reloadData];
    
    NSIndexPath *indexPathForFirstRow = [NSIndexPath indexPathForRow:0 inSection:_initialSection];
    [self.calendarCollectionView selectItemAtIndexPath:indexPathForFirstRow animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.calendarCollectionView didSelectItemAtIndexPath:indexPathForFirstRow];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}


#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return [_calendar components:NSCalendarUnitMonth fromDate:_firstDate toDate:_lastDate options:0].month + 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    NSRange rangeOfWeeks = [_calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:firstOfMonth];
    
    //We need the number of calendar weeks for the full months (it will maybe include previous month and next months cells)
    
    int daysPerWeek = 7;
    return (rangeOfWeeks.length * daysPerWeek);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"calendarCell" forIndexPath:indexPath];
    
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    
    NSDateComponents *cellDateComponents = [_calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:cellDate];
    
    NSDateComponents *firstOfMonthsComponents = [_calendar components:NSCalendarUnitMonth fromDate:firstOfMonth];
    
    NSDateComponents *todayComponents = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    if(cellDateComponents.month == firstOfMonthsComponents.month) {
        NSString *day = @"";
        
        NSDateFormatter *dateFormatter;
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"d";
        day = [dateFormatter stringFromDate:cellDate];
        cell.dateNumber.text = day;
        
        
        cell.dateNumber.layer.cornerRadius = 12.0;
        cell.dateNumber.clipsToBounds = YES;
        
        if(cellDateComponents.day == todayComponents.day &&
           cellDateComponents.month == todayComponents.month &&
           cellDateComponents.year == todayComponents.year) {
            
            cell.dateNumber.backgroundColor = [UIColor blueColor];
            cell.dateNumber.textColor = [UIColor whiteColor];
        }
        else {
            cell.dateNumber.backgroundColor = [UIColor clearColor];
            cell.dateNumber.textColor = [UIColor blackColor];
            
            if(indexPath.row % 7 == 0 || (indexPath.row + 1) % 7 == 0)
                cell.dateNumber.textColor = [UIColor lightGrayColor];
            else
                cell.dateNumber.textColor = [UIColor blackColor];
        }
        // mark events
        
        cell.event.layer.cornerRadius = 3.0;
        cell.event.clipsToBounds = YES;
        
        
        NSDateFormatter *eventFormatter = [[NSDateFormatter alloc] init];
        eventFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateCell = [eventFormatter stringFromDate:cellDate];
        
        NSString *markedEvent = @"";
        for(int i = 0; i < [_events count]; i++) {
            markedEvent = [_events objectAtIndex:i];
            
            if([markedEvent isEqualToString:dateCell]) {
                cell.event.backgroundColor = [UIColor lightGrayColor];
                cell.hasEvent = YES;
            }
        }
    }
    else {
        cell.dateNumber.text = @"";
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calendarHeader" forIndexPath:indexPath];
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        headerView.month.font = font;
        headerView.month.textColor = [UIColor blueColor];
        
        UIView *bottomBorder = [UIView new];
        bottomBorder.backgroundColor = [UIColor lightGrayColor];
        bottomBorder.frame = CGRectMake(0, headerView.frame.size.height - 1, headerView.frame.size.width, 1);
        [headerView addSubview:bottomBorder];
        
        NSDateFormatter *headerDateFormatter = [[NSDateFormatter alloc] init];
        headerDateFormatter.calendar = _calendar;
        headerDateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy LLLL" options:0 locale:_calendar.locale];
        
        NSString *headerTitle = [headerDateFormatter stringFromDate:[self firstOfMonthForSection:indexPath.section]].uppercaseString;
        
        headerView.month.text = headerTitle;
        reusableview = headerView;
        
    }
    return reusableview;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = self.view.frame.size.width / 7.0;
    CGFloat height = width;
    
    return CGSizeMake(width, height);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // Only scroll when the view is rendered for the first time
    if (_viewDidLayoutSubviewsForTheFirstTime) {
        _viewDidLayoutSubviewsForTheFirstTime = NO;
        
        UICollectionViewLayoutAttributes *attributes = [_calendarCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_initialSection]];
        
        CGRect rect = attributes.frame;
        [_calendarCollectionView setContentOffset:CGPointMake(_calendarCollectionView.frame.origin.x, rect.origin.y - 32) animated:NO];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    UICollectionViewFlowLayout *flowLayout = (id)self.calendarCollectionView.collectionViewLayout;
    [flowLayout invalidateLayout]; //force the elements to get laid out again with the new size
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navBarHairlineImageView = [self findHairlineImageViewUnder:navigationBar];
    
    UIView *bottomBorder = [[UIView alloc] init];
    double width = self.view.frame.size.width;
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, _topStack.frame.size.height - 0.5, width, 0.5);
    [_topStack addSubview:bottomBorder];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    
    //We don't want to select Dates that are "disabled"
    if (![self isEnabledDate:cellDate]) {
        return NO;
    }
    
    NSDateComponents *cellDateComponents = [_calendar components:NSCalendarUnitDay|NSCalendarUnitMonth fromDate:cellDate];
    NSDateComponents *firstOfMonthsComponents = [_calendar components:NSCalendarUnitMonth fromDate:firstOfMonth];
    
    return (cellDateComponents.month == firstOfMonthsComponents.month);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.dateNumber.layer.cornerRadius = 12.0;
    cell.dateNumber.clipsToBounds = YES;
    cell.dateNumber.backgroundColor = [UIColor grayColor];
    cell.dateNumber.textColor = [UIColor whiteColor];
    
    _selectedDate = [self dateForCellAtIndexPath:indexPath];
    _cellDate1 = [self dateForCellAtIndexPath:indexPath];
    
    
    if(cell.hasEvent) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEEE MMMM d, yyyy";
        NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
        _stringDate = [formatter stringFromDate:cellDate];
        
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        formatter2.dateFormat = @"yyyy-MM-dd";
        NSDate *cellDate2 = [self dateForCellAtIndexPath:indexPath];
        NSString *stringDate2 = [formatter2 stringFromDate:cellDate2];
        
        
        
        //        _descriptions = _currentEvent.eventDescriptions;
        //        _type = _currentEvent.eventType;
        
        EventViewController *events1 = [self.storyboard instantiateViewControllerWithIdentifier:@"eventController"];
        
        events1.eventVType = @"";
        events1.eventVDescriptions = @"";
        for(int i = 2; i < [_events count]; i += 3) {
            
            
            //NSLog(@"%@, %@", stringDate2, [_events objectAtIndex:i]);
            if([[_events objectAtIndex:i] isEqualToString:stringDate2]){
                NSString* desc = [_events objectAtIndex:(i - 1)];
                NSString* type = [_events objectAtIndex:(i - 2)];
                events1.eventVDescriptions = desc;
                events1.eventVType = type;
                //NSLog(@"%@", events1.eventVType);
            }
        }
        //events1.eventVType = _currentEvent.eventType;
        //events1.eventVDescriptions = _currentEvent.eventDescriptions;
        events1.stringDate = _stringDate;
        
        [self.navigationController pushViewController:events1 animated:YES];
        [_calendarCollectionView reloadData];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell =(CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    
    if([self isTodayDate:cellDate]) {
        cell.dateNumber.backgroundColor = [UIColor blueColor];
        cell.dateNumber.textColor = [UIColor whiteColor];
    }
    else {
        cell.dateNumber.backgroundColor = [UIColor clearColor];
        cell.dateNumber.textColor = [UIColor blackColor];
    }
}

// Calendar methods

- (NSDate *)firstOfMonthForSection:(NSInteger)section
{
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;
    
    return [_calendar dateByAddingComponents:offset toDate:_firstDate options:0];
}

- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSInteger ordinalityOfFirstDay = [_calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstOfMonth];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;
    
    return [_calendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

- (IBAction)todayButton:(id)sender {
    UICollectionViewLayoutAttributes *attributes = [_calendarCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_initialSection]];
    
    CGRect rect = attributes.frame;
    [_calendarCollectionView setContentOffset:CGPointMake(_calendarCollectionView.frame.origin.x, rect.origin.y - 32) animated:YES];
}

- (IBAction)addEvent:(id)sender {
    if(_selectedDate) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEEE MMMM d, yyyy";
        _stringDate = [formatter stringFromDate:_cellDate1];
        
        CreateEventViewController *events2 = [self.storyboard instantiateViewControllerWithIdentifier:@"createEventController"];
        
        events2.stringDate = _stringDate;
        
        [self.navigationController pushViewController:events2 animated:YES];
    }
}

- (BOOL)isEnabledDate:(NSDate *)date
{
    NSDate *clampedDate = [self clampDate:date toComponents:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay)];
    if (([clampedDate compare:_firstDate] == NSOrderedAscending) || ([clampedDate compare:_lastDate] == NSOrderedDescending)) {
        return NO;
    }
    
    return YES;
}

- (NSDate *)clampDate:(NSDate *)date toComponents:(NSUInteger)unitFlags
{
    NSDateComponents *components = [_calendar components:unitFlags fromDate:date];
    return [_calendar dateFromComponents:components];
}

- (BOOL)isTodayDate:(NSDate *)date
{
    return [self clampAndCompareDate:date withReferenceDate:[NSDate date]];
}

- (BOOL)isSelectedDate:(NSDate *)date
{
    if (!_selectedDate) {
        return NO;
    }
    return [self clampAndCompareDate:date withReferenceDate:_selectedDate];
}

- (BOOL)clampAndCompareDate:(NSDate *)date withReferenceDate:(NSDate *)referenceDate
{
    NSDate *refDate = [self clampDate:referenceDate toComponents:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay)];
    NSDate *clampedDate = [self clampDate:date toComponents:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay)];
    
    return [refDate isEqualToDate:clampedDate];
}

#pragma mark - NSXMLParser Delegate

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    //     NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"event"])
    {
        _currentEvent = [[Event alloc] init];
        //NSLog(@"event is: %@", Event);
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"type"]) {
        _currentEvent.eventType = _currentNodeContent;
        //NSLog(@"event is: %@", _currentEvent.eventType);
    }
    
    if ([elementName isEqualToString:@"date"]) {
        _currentEvent.eventDate = _currentNodeContent;
        //       NSLog(@"event is: %@", _currentEvent.eventDate);
    }
    
    if ([elementName isEqualToString:@"description"]) {
        _currentEvent.eventDescriptions = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"event"]) {
        [_events addObject:_currentEvent.eventType];
        [_events addObject:_currentEvent.eventDescriptions];
        [_events addObject:_currentEvent.eventDate];
        
        //NSLog(@"event is: %@", _currentEvent.eventType);
    }
    
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    //     NSLog(@"parserDidEndDocument");
}
- (void) executeQuery{
    int rc;
    //NSLog(@"stdate is: %@", _stringDate);
    sqlite3_stmt *statement;
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"contacts.db"]];
    const char *dbpath = [_databasePath UTF8String];
    if ((rc = sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT TYPE, DESCRIPTION, DATE FROM EVENTS"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *typeField = [[NSMutableString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                NSString *descField = [[NSMutableString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                NSString *dateField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                //NSLog(@"%@, %@, %@", dateField, descField, typeField);
                
                NSString * dateStr = dateField;
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
                [dateFormat setDateFormat:@"EEEE MMMM d, yyyy"];
                
                NSDate *date = [dateFormat dateFromString:dateStr];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSString *finalDate = [dateFormat stringFromDate:date];
                NSString *finalType = [NSString stringWithFormat:@"%@",typeField];
                //NSLog(finalType);
                //NSString *modifiedTypeString = [finalType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString *finalDesc = [NSString stringWithFormat:@"%@",descField];
                //NSString *modifiedDescString = [finalDesc stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                //NSLog(finalDate);
                
                _currentEvent = [[Event alloc] init];
                _currentEvent.eventType = finalType;
                _currentEvent.eventDescriptions = finalDesc;
                _currentEvent.eventDate = finalDate;
                
                //NSLog(@"%@, %@, %@", _currentEvent.eventType, _currentEvent.eventDate, _currentEvent.eventDescriptions);
                
                if(_currentEvent.eventType != nil) //or if(str != nil) or if(str.length>0)
                {
                    [_events addObject:_currentEvent.eventType];
                } else {
                    NSLog(@"No event type");
                }
                if(_currentEvent.eventDescriptions != nil) //or if(str != nil) or if(str.length>0)
                {
                    [_events addObject:_currentEvent.eventDescriptions];
                }else {
                    NSLog(@"No event description");
                }
                if(_currentEvent.eventDate != nil) //or if(str != nil) or if(str.length>0)
                {
                    [_events addObject:_currentEvent.eventDate];
                }else {
                    NSLog(@"No event date");
                }
                
                
                //NSLog(@"%@", _events);
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
}



@end


