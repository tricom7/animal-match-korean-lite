//
//  AppDelegate.h
//  Animal Match
//
//  Created by 심 선희 on 11. 11. 9..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) NSArray *animals;

- (void) soundPlay:(NSString *)audioName;
- (void) soundPlayBG:(NSString *)audioName;

@end
