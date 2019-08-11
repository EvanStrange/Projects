

#import "ViewController.h"
#import "DataViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pageData = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"];
    
    /************** XML ***********/
    
    
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_xmlData];
    _week = [[NSMutableArray alloc] init];
    
    [parser setDelegate:self];
    [parser parse];
    
    
    // Set current view to current day
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEEE"];
    
    NSString *day = [DateFormatter stringFromDate:[NSDate date]];
    
    _startIndex = 0;
    
    if([day isEqualToString:@"Saturday"] ||
       [day isEqualToString:@"Sunday"] ||
       [day isEqualToString:@"Monday"]
       )
        _startIndex = 0;
    else if([day isEqualToString:@"Tuesday"])
        _startIndex = 1;
    else if([day isEqualToString:@"Wednesday"])
        _startIndex = 2;
    else if([day isEqualToString:@"Thursday"])
        _startIndex = 3;
    else if([day isEqualToString:@"Friday"])
        _startIndex = 4;
    
    _pageViewController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options:nil];
    
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    DataViewController *startingViewController = [self viewControllerAtIndex:_startIndex storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    _pageViewController.view.frame = pageViewRect;
    
    [_pageViewController didMoveToParentViewController:self];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    if (([_pageData count] == 0) || (index >= [_pageData count])) {
        return nil;
    }
    
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = _pageData[index];
    dataViewController.tableData = [_week objectAtIndex:index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    return [_pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_pageData count];   // number of pages
}


- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return _startIndex;   // index of the first page
}

#pragma mark - NSXMLParser Delegate

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"mon"] ||
        [elementName isEqualToString:@"tue"] ||
        [elementName isEqualToString:@"wed"] ||
        [elementName isEqualToString:@"thu"] ||
        [elementName isEqualToString:@"fri"])
    {
        _day = [[NSMutableArray alloc] init];
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"cid"])
    {
        [_day addObject: _currentNodeContent];
    }
    
    
    if ([elementName isEqualToString:@"mon"] ||
        [elementName isEqualToString:@"tue"] ||
        [elementName isEqualToString:@"wed"] ||
        [elementName isEqualToString:@"thu"] ||
        [elementName isEqualToString:@"fri"])
    {
        [_week addObject: _day];
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}

@end

