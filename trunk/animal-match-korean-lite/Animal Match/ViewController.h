//
//  ViewController.h
//  Animal Match
//
//  Created by 심 선희 on 11. 11. 9..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h" //for AdMob

@class AppDelegate;

@interface ViewController : UIViewController{
    GADBannerView *bannerView_; //for AdMob
}

- (AppDelegate *)appDelegate;

@property (retain, nonatomic) IBOutlet UIView *view_result;

- (IBAction)act_result:(id)sender;
- (IBAction)goVeganSoft:(id)sender;
- (IBAction)goDesignCompany:(id)sender;

@end
