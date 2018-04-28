//
//  AppDelegate.m
//  RQNPageViewController
//
//  Created by mac on 2018/4/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RQNPageViewController.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];

    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor greenColor];

    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor orangeColor];

    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor blueColor];


    RQNPageViewController *PGVC = [RQNPageViewController pageViewControllerWithPageTitles:@[@"A",@"B",@"C",@"D"] controllers:@[vc1,vc2,vc3,vc4] titlesViewFrame:CGRectMake(0,0 , ScreenWith,  50)];
    
//    RQNPageViewController *PGVC = [[RQNPageViewController alloc] init];
//
//    PGVC.pageTitles = @[@"A",@"B",@"C"];
//
//    PGVC.pages = @[vc1,vc2,vc3];
//    PGVC.titlesViewFrame = CGRectMake(0,0 , ScreenWith,  50);
    
    PGVC.pageViewFrame = CGRectMake(0, 50, ScreenWith, ScreenHeight - 100);
    PGVC.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:17]};
    PGVC.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor yellowColor]};
    PGVC.titleViewBackgroundColor = [UIColor whiteColor];
    PGVC.selectionIndicatorHeight = 2;
    
    PGVC.selectionIndicatorColor = [UIColor blueColor];
    PGVC.selectionIndicatorLocation = selectionIndicatorLocationDown;
    PGVC.selectionStyle = selectionStyleFullWidthStripe;

//    PGVC.selectionIndicatorLocation = selectionIndicatorLocationNone;
//    PGVC.selectionStyle = selectionStyleBox;
    
    PGVC.selectionIndicatorBoxColor = [UIColor redColor];
    
    
    UIViewController *vc = [[UIViewController alloc] init];

    
    [vc addChildViewController:PGVC];
    [vc.view addSubview:PGVC.view];

    vc.view.backgroundColor = [UIColor grayColor];
    
    self.window.rootViewController = vc;
    
//    self.window.rootViewController = PGVC;
    
    [self.window makeKeyAndVisible];
    
    
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
}


@end
