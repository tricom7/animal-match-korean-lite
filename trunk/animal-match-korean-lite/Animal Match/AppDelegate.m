//
//  AppDelegate.m
//  Animal Match
//
//  Created by 심 선희 on 11. 11. 9..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize animals;

- (void)dealloc
{
    [animals release];
    
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (void)fillData {
    animals = [[NSArray alloc] initWithObjects:
               @"새",
               @"곰",
               @"낙타",
               @"코끼리",
               @"기린",
               @"하마",
               @"해파리",
               //@"표범",
               @"사자",
               @"호랑이",
               @"팽귄",
               @"코뿔소",
               //@"북극곰",
               @"해마",
               @"뱀",
               @"거북이",
               @"바다거북",
               @"고래",
               @"얼룩말",
               @"원숭이",
               nil];
}
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [self fillData];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


AVAudioPlayer *av;
NSString *sndPath;

AVAudioPlayer *avBG;//intro 음악용
NSString *sndPathBG;//intro 음악용

- (void) soundPlay:(NSString *)audioName {

    if (avBG.playing) {
        [avBG stop];
    } 
    
    if (av.playing) {
        [av stop];
        [av release];
    } else {
        [av release];
    }
    
	sndPath = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
    //    NSLog(@"sndPath = %@",sndPath);
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:sndPath];
    av = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];

    [fileURL release];
    [av play];
}

//intro 음악용
- (void) soundPlayBG:(NSString *)audioName{
    
    if (avBG.playing) {
        [avBG stop];
        [avBG release];
    } else {
        [avBG release];
    }
    
	sndPathBG = [[NSBundle mainBundle] pathForResource:audioName ofType:nil];
    //    NSLog(@"sndPathBG = %@",sndPath);
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:sndPathBG];
    avBG = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];
    
    avBG.numberOfLoops = -1;
    NSLog(@"avBG.numberOfLoops = %d",avBG.numberOfLoops);
    
    [fileURL release];
    [avBG play];
}


@end
