

#import "PickerViewController.h"
#import "ViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_pickerView setDelegate:self];
    
    _programs = @[@"Programs", @"Architectural", @"Civil", @"Geomatics",
                  @"Computing", @"Biomedical", @"Instrumentation",
                  @"Electrical", @"Telecom", @"Industrial",
                  @"Mechanical", @"Manufacturing", @"Petroleum"];
    
    _years = @[@"Year", @"First", @"Second", @"Third"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0)
        return [_programs count];
    else
        return [_years count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0)
        return [_programs objectAtIndex:row];
    else
        return [_years objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ViewController *destViewController = [segue destinationViewController];
    destViewController.xmlData2 = _xmlData;
}


- (IBAction)getSchedule:(id)sender {
    NSUInteger selectedProgram = [_pickerView selectedRowInComponent:0];
    NSUInteger selectedYear = [_pickerView selectedRowInComponent:1];
    
    if(selectedProgram == 0 || selectedYear == 0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Program/Year not selected."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                             }];
        
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        //    NSInteger day = [components day];
        NSInteger month = [components month];
        //    NSInteger year = [components year];
        
        NSInteger semester = 0;
        if(month >= 9 && month <= 12) {
            semester = 3 * selectedYear - 2;
        }
        else if(month >= 1 && month <= 4) {
            semester = 3 * selectedYear - 1;
            
        }
        else {
            semester = 3 * selectedYear;
        }
        
        NSString *cid = nil;
        
        switch(selectedProgram) {
            case 1 : cid = @"ae"; break;
            case 2 : cid = @"ce"; break;
            case 3 : cid = @"ge"; break;
            case 4 : cid = @"cs"; break;
            case 5 : cid = @"eb"; break;
            case 6 : cid = @"ei"; break;
            case 7 : cid = @"ep"; break;
            case 8 : cid = @"te"; break;
            case 9 : cid = @"in"; break;
            case 10: cid = @"me"; break;
            case 11: cid = @"mm"; break;
            case 12: cid = @"pe"; break;
            default: break;
        }
        
        
        NSString *prefix = @"http://branko-cirovic.appspot.com/etcapp/timetables/android/timetable_";
        NSString *sid = [NSString stringWithFormat:@"%ld", (long)semester];
        NSString *code = [cid stringByAppendingString:sid];
        _xmlUrl = [prefix stringByAppendingString:[code stringByAppendingString:@".xml"]];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *URL = [NSURL URLWithString:_xmlUrl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    //  NSString *urlData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                    
                                                    self->_xmlData = data;
                                                    
                                                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                                                    
                                                    if (!error && httpResp.statusCode == 404) {
                                                        UIAlertController * alert = [UIAlertController
                                                                                     alertControllerWithTitle:@"Error"
                                                                                     message:@"Schedule not found."
                                                                                     preferredStyle:UIAlertControllerStyleAlert];
                                                        
                                                        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                                                               style:UIAlertActionStyleDefault
                                                                                                             handler:^(UIAlertAction *action) {
                                                                                                             }];
                                                        
                                                        [alert addAction:cancelButton];
                                                        
                                                        [self presentViewController:alert animated:YES completion:nil];
                                                    }
                                                    else {
                                                        [self performSegueWithIdentifier:@"pickerSegue" sender:nil];
                                                    }
                                                }];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [task resume];
    }
}
@end


