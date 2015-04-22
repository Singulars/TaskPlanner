//
//  AppDelegate.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginUserDetails.h"
#import "RegistrationScreen.h"
#import "HomeScreen.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kdeviceToken]) {
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            
            if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
                [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
                [application registerForRemoteNotifications];
            }
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
            
        }
    }
    else
    {
        [ShareObj setDeviceToken:[[NSUserDefaults standardUserDefaults] objectForKey:kdeviceToken]];
      }
    
    [_window setBackgroundColor:kWhiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleNetworkChange:) name: kReachabilityChangedNotification
                                               object: nil];
    
    hostReach = [Reachability reachabilityForInternetConnection];
    [hostReach startNotifier];
    
    NetworkStatus remoteHostStatus = [hostReach currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        NSLog(@"Internet Disconnected");
        ShareObj.isInternetConnected = NO;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        NSLog(@"Connected via WIFI");
        ShareObj.isInternetConnected = YES;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        NSLog(@"Connected via WWAN");
        ShareObj.isInternetConnected = YES;
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    self.mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    LoginUserDetails *objLogin=[LoginUserDetails fetchLoginUserDetails];
    
    if (objLogin!=nil) {
        [ShareObj setObjLoginUser:objLogin];
        [self OpenHomeScreen];
        
    }
    else{
        [self OpenLoginScreen];
    }
    
    return YES;
}

-(void)OpenHomeScreen
{
    ContainerViewController *objHome=[self.mainStoryboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
    ///self.navController = [[AppNavScreen alloc] initWithRootViewController:objHome];
    
    ShowHideStatusBarVisible(NO);
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        [self.window setRootViewController:objHome];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}

- (void)OpenLoginScreen
{
     RegistrationScreen *objRegi=[self.mainStoryboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"];
    self.navController = [[AppNavScreen alloc] initWithRootViewController:objRegi];
    
    ShowHideStatusBarVisible(NO);
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        [self.window setRootViewController:self.navController];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}



#pragma mark-
#pragma mark- APNS Metods...

-(void)handlePushNotification:(NSDictionary *)pushNotificationPayload
{
    [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:pushNotificationPayload];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<> "]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device token---%@", token);
    [ShareObj setDeviceToken:token];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kdeviceToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"device token failed%s ==> %@",__FUNCTION__,error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo ::--> %@",userInfo);
    
    NSDictionary *diccPushInfo=[userInfo objectForKey:@"aps"];
    
    switch (application.applicationState)
    {
        case UIApplicationStateActive:
        {
            NSInteger appState=[[diccPushInfo objectForKey:@"pushType"] integerValue];
            
            switch (appState) {
                case 0:
                {
                  
                    
                }
                    break;
                case 1:
                {
                    [Common ShowAlertAccordingTOInstagram:[diccPushInfo objectForKey:@"alert"]];
                }
                    break;
                case 2:
                {
                    [Common ShowAlertAccordingTOInstagram:[diccPushInfo objectForKey:@"alert"]];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case UIApplicationStateBackground:
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
        }
            break;
        case UIApplicationStateInactive:
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
        }
            break;
            
        default:
            break;
    }
    
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data Logic
#pragma mark -
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack
#pragma mark -
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kDataModel withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath:[DOC_DIR_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",kDataModel]]];
    //    NSLog(@"%@",DOC_DIR_PATH);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Reachability Change Notification
#pragma mark -

- (void)handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [hostReach currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        NSLog(@"Internet Disconnected");
        ShareObj.isInternetConnected = NO;  // Internet not Connected
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        //        message = @"Internet Connected via WIFI";
        NSLog(@"Connected via WIFI");
        ShareObj.isInternetConnected = YES; // Connected via WIFI
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        NSLog(@"Connected via WWAN");
        ShareObj.isInternetConnected = YES; // Connected via WWAN
    }
}

@end
