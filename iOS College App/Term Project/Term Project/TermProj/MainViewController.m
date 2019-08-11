

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white.png"]];
    /*
    UIImageView *titleImage = (UIImageView *)self.navigationItem.titleView;
    titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.navigationController.navigationBar.frame.size.width/2) - (100/2), 0, 100,self.navigationController.navigationBar.frame.size.height)];
    
    
    //setting the image for UIImageView
    titleImage.image = [UIImage imageNamed:@"csplogo.png"];
    titleImage.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = titleImage;*/
    
    /* Create an Image View to replace the Title View */
    UIImageView *imageView =
    [[UIImageView alloc]
     initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    /* Load an image. Be careful, this image will be cached */
    UIImage *image = [UIImage imageNamed:@"csplogo.png"];
    
    /* Set the image of the Image View */
    [imageView setImage:image];
    
    /* Set the Title View */
    self.navigationItem.titleView = imageView;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor greenColor]];
   
    
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

- (IBAction)metro:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.metrobus.com/html-default/index.asp"] options:@{} completionHandler:nil];
}

- (IBAction)toast:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Developed In Part By Matthew Dunne"
                                                                   message:@"All Rights Reserved"
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"close"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:firstAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end

