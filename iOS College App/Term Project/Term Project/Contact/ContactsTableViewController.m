
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ContactsTableViewController.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Contacts";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _reach = [Reachability reachabilityForInternetConnection];
    [_reach startNotifier];
    [self updateInterfaceWithReachability:_reach];
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus status = [_reach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
            NSLog(@"Network is not reachable");
            _networkIsReachable = NO;
            break;
            
        case ReachableViaWWAN:
            NSLog(@"Network is reachable via WWAN");
            _networkIsReachable = YES;
            break;
            
        case ReachableViaWiFi:
            NSLog(@"Network is reachable via WiFi");
            _networkIsReachable = YES;
            break;
    }
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
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactsIdentifier" forIndexPath:indexPath];
    
    UIImage *cellImage = nil;
    
    if(indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSUInteger row = [indexPath row];
        
        switch(row) {
            case 0: cell.textLabel.text = @"Call";
                cellImage = [UIImage imageNamed:@"Call.png"];
                cell.imageView.image = cellImage;
                break;
                
            case 1: cell.textLabel.text = @"Write";
                cellImage = [UIImage imageNamed:@"Email.png"];
                cell.imageView.image = cellImage;
                break;
                
            case 2: cell.textLabel.text = @"Location";
                cellImage = [UIImage imageNamed:@"Location.png"];
                cell.imageView.image = cellImage;
                break;
                
            case 3: cell.textLabel.text = @"Visit Website";
                cellImage = [UIImage imageNamed:@"Website.png"];
                cell.imageView.image = cellImage;
                break;
                
                
            default: break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    switch(row) {
        case 0 : NSLog(@"Call"); [self makeCall]; break;
        case 1 : NSLog(@"Write"); [self showPicker]; break;
        case 2 : NSLog(@"Map");
            if(!_networkIsReachable) {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Error"
                                             message:@"Device has no Internet access."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction *action) {
                                                                     }];
                
                [alert addAction:cancelButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                [self performSegueWithIdentifier:@"showMapSegue" sender:self];
            }
            break;
        case 3 : NSLog(@"Web");
            if(!_networkIsReachable) {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Error"
                                             message:@"Device has no Internet access."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction *action) {
                                                                     }];
                
                [alert addAction:cancelButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
                [self performSegueWithIdentifier:@"showWebSegue" sender:self];
            }
            break;
        default: break;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)makeCall {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"7097587091"]];
    [application openURL:URL options:@{}
       completionHandler:^(BOOL success) {
           if (success) {
               NSLog(@"Opened URL");
           }
       }];
}


-(void)showPicker
{
    // This sample can run on devices running iPhone OS 2.0 or later
    // The MFMailComposeViewController class is only available in iPhone OS 3.0 or later.
    // So, we must verify the existence of the above class and provide a workaround for devices running
    // earlier versions of the iPhone OS.
    // We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
    // We launch the Mail application on the device, otherwise.
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayComposerSheet
{
    
    if(!_networkIsReachable) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Device has no Internet access."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                             }];
        
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        if([MFMailComposeViewController canSendMail]) {
            
            NSLog(@"canSendMail");
            
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            [picker setSubject:@"Program info"];
            
            // Set up recipients
            NSArray *toRecipients = [NSArray arrayWithObject:@"bc170264@gmail.com"];
            
            [picker setToRecipients:toRecipients];
            //[picker setCcRecipients:ccRecipients];
            
            // Fill out the email body text
            NSString *emailBody = @"";
            [picker setMessageBody:emailBody isHTML:NO];
            
            [self presentViewController:picker animated:YES completion: nil];
            
            
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Error"
                                         message:@"Device has no Mail setup."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action) {
                                                                 }];
            
            [alert addAction:cancelButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:bc170264@gmail.com&subject=Program Info";
    NSString *email = [NSString stringWithFormat:@"%@", recipients];
    email = [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:email];
    [application openURL:URL options:@{}
       completionHandler:^(BOOL success) {
           if (success) {
               // NSLog(@"Opened url");
           }
       }];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    
    NSString *res = nil;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            res = @"Message Cancelled";
            break;
        case MFMailComposeResultSaved:
            res = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            res = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            res = @"Action Failed";
            break;
        default:
            res = @"Message not Sent";
            break;
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Contact us"
                                 message:res
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                         }];
    
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

