
#import "NewsTableViewController.h"
#import "AppDelegate.h"
#import "NewsTableViewCell.h"
#import "IconDownloader.h"
#import "DetailNewsTableViewController.h"

@interface NewsTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSData *data = appDelegate.data;
    
    self.title = @"News";
    
    //\n in xml is encoded as &#10;
    NSString *a = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *b = [a stringByReplacingOccurrencesOfString:@"&#10;" withString:@"\n"];
    data = [b dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"%@", b);
    
    _newsParser = [[NSXMLParser alloc] initWithData:data];
    _news = [[NSMutableArray alloc] init];
    [_newsParser setDelegate:self];
    [_newsParser parse];
    
    //    NSLog(@"%@", _news);
    
}

- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)dealloc
{
    // terminate all pending download connections
    [self terminateAllDownloads];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self terminateAllDownloads];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_news count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = nil;
    
    NSUInteger nodeCount = self.news.count;
    
    if (nodeCount == 0 && indexPath.row == 0)
    {
        // add a placeholder cell while waiting on table data
        cell = [tableView dequeueReusableCellWithIdentifier:@"placeholderCell" forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
        
        // Leave cells empty if there's no data yet
        if (nodeCount > 0)
        {
            // Set up the cell representing the news
            News *newsRecord = (self.news)[indexPath.row];
            
            cell.newsTitle.text = newsRecord.newsTitle;
            cell.newsDate.text = newsRecord.newsDate;
            
            // Only load cached images; defer new downloads until scrolling ends
            if (!newsRecord.newsImage)
            {
                if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
                {
                    [self startIconDownload:newsRecord forIndexPath:indexPath];
                }
                // if a download is deferred or in progress, return a placeholder image
                cell.newsImage.image = [UIImage imageNamed:@"placeholder.png"];
            }
            else
            {
                cell.newsImage.image = newsRecord.newsImage;
            }
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *currentNews = [_news objectAtIndex:indexPath.row];
    _newsImage = currentNews.newsImage;
    _newsTitle = currentNews.newsTitle;
    _newsDate = currentNews.newsDate;
    _newsDescription = currentNews.newsDescription;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showDetailNews" sender:self];
    
}

#pragma mark - NSXMLParser Delegate


- (void) parserDidStartDocument:(NSXMLParser *)parser {
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"news"])
        _currentNews = [[News alloc] init];
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    if([elementName isEqualToString:@"ntitle"]) {
        _currentNews.newsTitle = _currentNodeContent;
    }
    
    if([elementName isEqualToString:@"ndate"]) {
        _currentNews.newsDate = _currentNodeContent;
    }
    
    if([elementName isEqualToString:@"ndescription"]) {
        _currentNews.newsDescription = _currentNodeContent;
    }
    
    if([elementName isEqualToString:@"nimage"]) {
        NSString *urlString = @"http://branko-cirovic.appspot.com/etcapp/news/images/";
        NSString *imageName = _currentNodeContent;
        NSString *urlImage = [urlString stringByAppendingString:imageName];
        _currentNews.newsImageUrl = urlImage;
    }
    
    if([elementName isEqualToString:@"news"]) {
        [_news addObject:_currentNews];
    }
    
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
}

#pragma mark - Table cell image support

// -------------------------------------------------------------------------------
//    startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(News *)newsRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.newsRecord = newsRecord;
        [iconDownloader setCompletionHandler:^{
            
            NewsTableViewCell *cell = (NewsTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            
            cell.newsImage.image = newsRecord.newsImage;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        
        [iconDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//    loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows
{
    if (_news.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            News *currentNews = (self.news)[indexPath.row];
            
            if (!currentNews.newsImage)
                // Avoid the newa icon download if the news already has an icon
            {
                [self startIconDownload:currentNews forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//    scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//    scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DetailNewsTableViewController *destViewController = [segue destinationViewController];
    destViewController.newsImage = _newsImage;
    destViewController.newsTitle = _newsTitle;
    destViewController.newsDate = _newsDate;
    destViewController.newsText = _newsDescription;
}


@end

