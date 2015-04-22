//
//  AppDelegate.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreData/CoreData.h>
#import "Reachability.h"
#import "AppNavScreen.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
      Reachability* hostReach;
}
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)handleNetworkChange:(NSNotification *)notice;
@property (strong, nonatomic) UIStoryboard *mainStoryboard;
@property (strong, nonatomic) AppNavScreen *navController;
@end
