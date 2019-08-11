

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLocationCoordinate2D location;
    location.latitude = 47.58698;
    location.longitude= -52.73468;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 800, 800); // meters
    [_mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = location;
    annotationPoint.title = @"Engineering Technology Centre";
    annotationPoint.subtitle = @"Ridge Road, St. John\'s NL, A1C 6L8";
    [_mapView addAnnotation:annotationPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

