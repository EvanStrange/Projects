//
//  ViewController.m
//  Term Project
//
//  Created by Evan Strange on 2019-07-05.
//  Copyright © 2019 Evan Strange. All rights reserved.
//


#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Developed by Evan Strange"
                                                                   message:@"All Rights Reserved"
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"close"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:firstAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end


