

#import "ProgramsTableViewController.h"
#import "CoursesTableViewController.h"

@interface ProgramsTableViewController ()

@end

@implementation ProgramsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setTitle:@"Programs"];
    
    _programs = @[@"Architectural", @"Civil", @"Geomatics", @"Biomedical", @"Computing Systems", @"Electrical (Power)", @"Instrumentation", @"Telecommunications", @"Chemical Processing", @"Industrial", @"Mechanical", @"Manufacturing", @"Petroleum"];
    
    _programsID = @[@"ae", @"ce", @"ge", @"eb", @"cs", @"ep", @"ei", @"te", @"cp", @"in", @"me", @"mm", @"pe"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i = 0;
    
    switch(section) {
        case 0 : i = 3; break;
        case 1 : i = 5; break;
        case 2 : i = 5; break;
        default: break;
    }
    
    return i;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    
    headerCell.textLabel.font = font;
    
    headerCell.textLabel.backgroundColor = [UIColor clearColor];
    headerCell.textLabel.opaque = NO;
    headerCell.textLabel.textColor = [UIColor grayColor];
    headerCell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    
    switch(section) {
        case 0 : headerCell.textLabel.text = @"CONSTRUCTION";
            headerCell.imageView.image = [UIImage imageNamed:@"construction.png"];  break;
        case 1 : headerCell.textLabel.text = @"ELECTRICAL-ELECTRONICS";
            headerCell.imageView.image =  [UIImage imageNamed:@"electronics.png"]; break;
        case 2 : headerCell.textLabel.text = @"MECHANICAL";
            headerCell.imageView.image =  [UIImage imageNamed:@"mechanical.png"]; break;
        default : break;
    }
    
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(indexPath.section == 0) {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [_programs objectAtIndex:row];
    }
    else if(indexPath.section == 1) {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [_programs objectAtIndex:row + 3];
    }
    else if(indexPath.section == 2) {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [_programs objectAtIndex:row + 8];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _pid = nil;
    _pname = nil;
    
    if(indexPath.section == 0) {
        NSUInteger row = [indexPath row];
        _pname = [_programs objectAtIndex:row];
        _pid = [_programsID objectAtIndex:row];
        _imageName = @"construction_p.png";
    }
    else if(indexPath.section == 1) {
        NSUInteger row = [indexPath row];
        _pname = [_programs objectAtIndex:row + 3];
        _pid = [_programsID objectAtIndex:row + 3];
        _imageName = @"electronics_p.png";
    }
    else if(indexPath.section == 2) {
        NSUInteger row = [indexPath row];
        _pname = [_programs objectAtIndex:row + 8];
        _pid = [_programsID objectAtIndex:row + 8];
        _imageName = @"mechanical_p.png";
    }
    
    NSString *xmlUrl = [@"http://branko-cirovic.appspot.com/etcapp/programs/" stringByAppendingString:[_pid stringByAppendingString:@".xml"]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *URL = [NSURL URLWithString:xmlUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                self->_urlData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                
                                                self->_xmlData = data;
                                                
                                                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                                                
                                                if (!error && httpResp.statusCode == 404) {
                                                    UIAlertController * alert = [UIAlertController
                                                                                 alertControllerWithTitle:@"Error"
                                                                                 message:@"File not found"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                                                    
                                                    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                                                           style:UIAlertActionStyleDefault
                                                                                                         handler:^(UIAlertAction *action) {
                                                                                                         }];
                                                    
                                                    [alert addAction:cancelButton];
                                                    
                                                    [self presentViewController:alert animated:YES completion:nil];
                                                }
                                                else {
                                                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                                                    // NSLog(@"%@", _urlData);
                                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
                                                    [self performSegueWithIdentifier:@"showCourses" sender:self];
                                                }
                                            }];
    
    [task resume];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    CoursesTableViewController *destViewController = segue.destinationViewController;
    destViewController.programNameText = _pname;
    destViewController.imageName = _imageName;
    destViewController.urlData = _urlData;
    destViewController.xmlData = _xmlData;
}

@end

