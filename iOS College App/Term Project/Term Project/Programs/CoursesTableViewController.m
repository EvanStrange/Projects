
#import "CoursesTableViewController.h"
#import "CoursesTopHeaderTableViewCell.h"
#import "DetailCourseViewController.h"

@interface CoursesTableViewController ()

@end

@implementation CoursesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setTitle:@"Courses"];
    
    NSString *a = [[NSString alloc]initWithData:_xmlData encoding:NSUTF8StringEncoding];
    NSString *b = [a stringByReplacingOccurrencesOfString:@"&#10;" withString:@"\n"];
    _xmlData = [b dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_xmlData];
    _semesters = [[NSMutableArray alloc] init];
    [parser setDelegate:self];
    
    [parser parse];
    
    for(int i = 0; i < _semesters.count; i++) {
        Semester *s = [_semesters objectAtIndex:i];
        for(int j = 0; j < s.courses.count; j++) {
            Course *c = [s.courses objectAtIndex:j];
            NSString *cid = c.cid;
            NSString *cname = c.cname;
            NSLog(@"%@ %@\n", cid, cname);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParser Delegate

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    // NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"semester"])
    {
        _currentSemester = [[Semester alloc] init];
        _courses = [[NSMutableArray alloc] init];
        
    }
    
    if ([elementName isEqualToString:@"course"])
    {
        _currentCourse = [[Course alloc] init];
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"number"])
    {
        _currentSemester.number = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"cid"])
    {
        _currentCourse.cid = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"cname"])
    {
        _currentCourse.cname = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"credit"])
    {
        _currentCourse.credit = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"lect"])
    {
        _currentCourse.lect = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"lab"])
    {
        _currentCourse.lab = _currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"course"] )
    {
        [_courses addObject:_currentCourse];
    }
    
    if ([elementName isEqualToString:@"semester"])
    {
        _currentSemester.courses = _courses;
        [_semesters addObject:_currentSemester];
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    // NSLog(@"parserDidEndDocument");
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 80.0;
    else
        return 40.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [_semesters count] + 1;  // empty header
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if(section == 0)
        return 0;
    else {
        Semester *s = [_semesters objectAtIndex:section - 1];
        return [[s courses] count];
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell* headerCell;
    
    if(section == 0) {
        CoursesTopHeaderTableViewCell* topCell = [tableView dequeueReusableCellWithIdentifier:@"firstHeaderCell"];
        topCell.programNameLabel.text = _programNameText;
        topCell.imageView.image = [UIImage imageNamed:_imageName];
        headerCell = topCell;
    }
    else {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        
        headerCell.textLabel.font = font;
        
        headerCell.textLabel.backgroundColor = [UIColor clearColor];
        headerCell.textLabel.opaque = NO;
        headerCell.textLabel.textColor = [UIColor grayColor];
        headerCell.textLabel.highlightedTextColor = [UIColor whiteColor];
        
        switch((section) % 3) {
            case 1 : headerCell.imageView.image =  [UIImage imageNamed:@"autumn.png"]; break;
            case 2 : headerCell.imageView.image =  [UIImage imageNamed:@"winter.png"]; break;
            case 0 : headerCell.imageView.image =  [UIImage imageNamed:@"summer.png"];break;
        }
        
        NSString *semester = [NSString stringWithFormat:@"SEMESTER %ld", section];
        
        NSString *year = nil;
        
        switch((section - 1)/ 3) {
            case 0 : year = @"FIRST YEAR - "; break;
            case 1 : year = @"SECOND YEAR - "; break;
            case 2 : year = @"THIRD YEAR - "; break;
            case 3 : year = @"FOURTH YEAR - "; break;
        }
        
        headerCell.textLabel.text = [year stringByAppendingString:semester];
        
    }
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coursesCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _currentSemester = [_semesters objectAtIndex:indexPath.section - 1];
    _currentCourse = [_currentSemester.courses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = _currentCourse.cname;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = _currentCourse.cid;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _currentSemester = [_semesters objectAtIndex:indexPath.section - 1];
    _currentCourse = [_currentSemester.courses objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"showDetailCourse" sender:self];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DetailCourseViewController *destViewController = [segue destinationViewController];
    
    destViewController.cname = _currentCourse.cname;
    destViewController.cid = _currentCourse.cid;
    destViewController.lect = _currentCourse.lect;
    destViewController.lab = _currentCourse.lab;
    destViewController.credit = _currentCourse.credit;
    
}


@end

