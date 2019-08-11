

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataTable.backgroundColor = [UIColor whiteColor];
    
    _hours = @[@"9:00", @"10:00", @"11:00", @"noon", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"6:00"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView delegate and data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataObject description];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"HH"];
    
    NSString *hour = [DateFormatter stringFromDate:[NSDate date]];
    NSInteger ih = [hour integerValue] - 9;
    
    cell.textLabel.text = [_hours objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_tableData objectAtIndex:indexPath.row];
    
    [DateFormatter setDateFormat:@"EEEE"];
    NSString *day = [DateFormatter stringFromDate:[NSDate date]];
    
    if(indexPath.row == ih && [_dataObject isEqualToString:day])
        cell.textLabel.textColor = [UIColor redColor];
    else
        cell.textLabel.textColor = self.view.tintColor;
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

