

#import "DetailCourseViewController.h"

@interface DetailCourseViewController ()

@end

@implementation DetailCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _courseLabel.text = _cname;
    self.navigationItem.title = _cid;
    [_tableView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView delegate and data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCourseCell" forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    NSUInteger row = [indexPath row];
    switch(row) {
        case 0: cell.textLabel.text = @"Credit";
            cell.detailTextLabel.text = [_credit stringByAppendingString:@" credit hours"];
            cell.imageView.image = [UIImage imageNamed:@"credithour.png"];break;
        case 1: cell.textLabel.text = @"Lectures";
            cell.detailTextLabel.text = [_lect stringByAppendingString:@" hours per week"];
            cell.imageView.image = [UIImage imageNamed:@"lectures.png"];break;
        case 2: cell.textLabel.text = @"Labs";
            cell.detailTextLabel.text = [_lab stringByAppendingString:@" hours per week"];
            cell.imageView.image = [UIImage imageNamed:@"lab.png"];break;
        default: break;
    }
    
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


