
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

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
            _networkIsReachable = NO;
            break;
            
        case ReachableViaWWAN:
            _networkIsReachable = YES;
            _networkIsReachableWWAN = YES;
            break;
            
        case ReachableViaWiFi:
            _networkIsReachable = YES;
            _networkIsReachableWiFi = YES;
            break;
    }
    
    if(_networkIsReachable && _failed) {
        _failed = NO;
        
        // Initially failed but now we have internet
        
        NSURL *url = [NSURL URLWithString:@"http://branko-cirovic.appspot.com/etcapp/news/news.xml"];
        _data = [[NSData alloc] initWithContentsOfURL:url];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        self.window.rootViewController = viewController;
        
        [self.window makeKeyAndVisible];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _reach = [Reachability reachabilityForInternetConnection];
    [_reach startNotifier];
    [self updateInterfaceWithReachability:_reach];
    
    if(!_networkIsReachable) {
        _failed = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ErrorViewController"];
        self.window.rootViewController = viewController;
        
        [self.window makeKeyAndVisible];
    }
    else {
        _failed = NO;
        NSURL *url = [NSURL URLWithString:@"http://branko-cirovic.appspot.com/etcapp/news/news.xml"];
        _data = [[NSData alloc] initWithContentsOfURL:url];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


@end

