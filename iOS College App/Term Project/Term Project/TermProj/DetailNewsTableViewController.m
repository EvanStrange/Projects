

#import "DetailNewsTableViewController.h"
#import "NewsHeaderTableViewCell.h"
#import "NewsTextTableViewCell.h"

@interface DetailNewsTableViewController ()

@end

@implementation DetailNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /* variable height cells */
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NewsHeaderTableViewCell *newsHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"newsHeaderCell"];
    newsHeaderCell.newsImage.image = _newsImage;
    
    return newsHeaderCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;     // 0.0 does not work
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGRect Rect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = Rect.size.width;
    CGFloat screenHeight = screenWidth * 3.0 / 4.0;
    
    return screenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = NULL;
    
    
    NewsTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"newsTextCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    textCell.newsTitle.text = _newsTitle;
    textCell.newsDate.text = _newsDate;
    
    // get rid of padding in UITextView
    textCell.newsText.textContainerInset = UIEdgeInsetsZero;
    textCell.newsText.textContainer.lineFragmentPadding = 0;
    
    textCell.newsText.text = _newsText;
    textCell.newsText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    textCell.newsText.textColor = [UIColor darkGrayColor];
    
    cell = textCell;
    
    return cell;
}

@end

