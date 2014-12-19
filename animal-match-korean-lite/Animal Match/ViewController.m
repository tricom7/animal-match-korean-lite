//
//  ViewController.m
//  Animal Match
//
//  Created by 심 선희 on 11. 11. 9..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@implementation ViewController
@synthesize view_result;

- (AppDelegate *)appDelegate {
	return [[UIApplication sharedApplication] delegate];	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
NSMutableSet *selectedAnimals;
NSMutableSet *tmpAnimals;
NSMutableArray *selectedArray1;
NSMutableArray *selectedArray2;
NSMutableArray *remainAnimals;
NSMutableDictionary *buttonDictionary;

NSMutableArray *curButtons;

- (void)viewDidLoad
{
    [super viewDidLoad];

    selectedAnimals = [[NSMutableSet alloc] init];
    tmpAnimals = [[NSMutableSet alloc] init];
    selectedArray1 = [[NSMutableArray alloc] init];
    selectedArray2 = [[NSMutableArray alloc] init];
    remainAnimals = [[NSMutableArray alloc] initWithArray:[self appDelegate].animals];

    [[self appDelegate] soundPlayBG:@"intro.mp3"];

    buttonDictionary = [[NSMutableDictionary alloc] init];
    
    curButtons = [[NSMutableArray alloc] init];
    
    /*********************************************************************
     * for AdMob                                                         *
     *********************************************************************/
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    bannerView_.adUnitID = @"a14f9fc018851b5";
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    [bannerView_ loadRequest:[GADRequest request]];
    /*********************************************************************/
}

- (void)viewDidUnload
{
    [bannerView_ release]; //for AdMob
    [self setView_result:nil];
    [super viewDidUnload];
}

int animal_num;
NSString *animalName;
NSString *animalName2;
NSString *imageName;
bool isPic=true;
int seqAnimal=0;

- (void)makeSilhouette {
    for (int y=0; y<2; y++) {
        for (int x=0; x<9; x++) {
            animalName = [remainAnimals objectAtIndex:seqAnimal++];
            imageName = [NSString stringWithFormat:@"IMG_SIL_%@.png",animalName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                //하단 광고 버전 
                imageView.frame = CGRectMake(30*x+30, 30*y+20, 20.0, 20.0); //iPhone 이미지뷰 위치와 크기 설정
                //광고 없는 버전
                //imageView.frame = CGRectMake(35*x+5, 40*y+20, 30.0, 30.0); //iPhone 이미지뷰 위치와 크기 설정
            } else {
                //하단 광고 버전 
                //imageView.frame = CGRectMake(50*x+170, 50*y+10, 40.0, 40.0); //iPad 이미지뷰 위치와 크기 설정
                //광고 없는 버전
                imageView.frame = CGRectMake(70*x+65, 70*y+20, 60.0, 60.0); //iPad 이미지뷰 위치와 크기 설정
            }
            [[self view] addSubview:imageView]; //이미지뷰를 뷰에 추가하기
            [imageView setAlpha:0.1];
            [buttonDictionary setObject:imageView forKey:animalName];
        }
    } 
}

- (void)makeGrid {
    seqAnimal=0;
    [selectedAnimals removeAllObjects];
    [selectedArray1 removeAllObjects];
    [selectedArray2 removeAllObjects];
    [tmpAnimals removeAllObjects];
    for (int i=0; i<6; i++) {//6개의 유일한 동물 숫자 배열 만들기
        do {
            animal_num = arc4random() % [remainAnimals count];
        } while ([selectedAnimals containsObject:[NSNumber numberWithInt:animal_num]]);
        [selectedAnimals addObject:[NSNumber numberWithInt:animal_num]];
    }

    for (NSNumber *n in selectedAnimals) {
        [selectedArray1 addObject:n];
    }
    
    for (NSNumber *n in selectedAnimals) {
        do {
            animal_num = arc4random() % 6;
        } while ([tmpAnimals containsObject:[NSNumber numberWithInt:animal_num]]);
        [tmpAnimals addObject:[NSNumber numberWithInt:animal_num]];
        
        [selectedArray2 addObject:[selectedArray1 objectAtIndex:animal_num]]; 
    }
 
    for (int y=0; y<4; y++) {
        for (int x=0; x<3; x++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //버튼 생성
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside]; //버튼셀렉터 설정
            [button setTag:x+y*3+1]; //태그 설정
            [button.titleLabel setLineBreakMode:UILineBreakModeWordWrap]; //버튼 레이블 모드 설정
            
            if (isPic) {
                isPic = false;
                animalName = [remainAnimals objectAtIndex:[[selectedArray1 objectAtIndex:seqAnimal] intValue]];
                imageName = [NSString stringWithFormat:@"IMG_TRANS_%@.png",animalName];
                [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [button setTitle:animalName forState:UIControlStateNormal]; //버튼 타이틀 설정
            } else {
                isPic = true;
                animalName2 = [remainAnimals objectAtIndex:[[selectedArray2 objectAtIndex:seqAnimal++] intValue]];
                [button setTitle:animalName2 forState:UIControlStateNormal]; //버튼 타이틀 설정
            }

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                //하단 광고 버전 
                button.frame = CGRectMake(80*x+45, 80*y+85, 72.0, 72.0); //버튼 위치와 크기 설정 
                //광고 없는 버전
                //button.frame = CGRectMake(80*x+45, 80*y+105, 72.0, 72.0); //버튼 위치와 크기 설정
                if (animalName2.length > 11) {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:9];
                } else if (animalName2.length > 9) {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
                } else {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                }
            } else {
                //하단 광고 버전 
                //button.frame = CGRectMake(200*x+90, 200*y+110, 180.0, 180.0); //버튼 위치와 크기 설정
                //광고 없는 버전
                button.frame = CGRectMake(200*x+90, 200*y+170, 180.0, 180.0); //버튼 위치와 크기 설정
                if (animalName2.length > 11) {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
                } else if (animalName2.length > 9) {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:29];
                } else {
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:35];
                }
            }
            [[self view] addSubview:button]; //버튼을 뷰에 추가하기
            [curButtons addObject:button]; //가로 보기 지원을 위해 버튼을 array에 넣어 둠.
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self makeSilhouette];
    [self makeGrid];
}

NSString *preTitle=@"";
UIButton *preButton;
bool isSecondButton=false;
int score=0;
int x,y;

UIImageView *tmpImageView;

- (void)buttonClicked:(UIButton*)button
{
    if (isSecondButton) {
        isSecondButton=false;
        if ([preTitle isEqualToString:button.titleLabel.text]) {
            [[self appDelegate] soundPlay:@"O.mp3"];
            
            [preButton setAlpha:0];
            [button setAlpha:0];
            preButton = nil;
            score++;

            tmpImageView=[buttonDictionary objectForKey:button.titleLabel.text];
            tmpImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_TRANS_%@.png",button.titleLabel.text]];
            [tmpImageView setAlpha:1.0];
            
            //remainAnimals에서 맞춘 animal 빼기
            [remainAnimals removeObject:preTitle];
        } else {
            [[self appDelegate] soundPlay:@"X.mp3"];
            [preButton setAlpha:1.0];
            [preButton setEnabled:true];
        }
    } else {
        isSecondButton=true;
        [button setEnabled:false];
        [button setAlpha:0.2];
        [[self appDelegate] soundPlay:[NSString stringWithFormat:@"%@.mp3",button.titleLabel.text]];
    }

    preTitle = button.titleLabel.text;
    preButton = button;

    if (score%6==0 && score!=0 && [remainAnimals count]>0) {
        score=0;
        [self makeGrid];
        [[self appDelegate] soundPlay:@"Clapping Crowd Studio 01.mp3"];
    }
    
    if ([remainAnimals count]==0) {
        [[self appDelegate] soundPlay:@"Kids Cheering.mp3"];
        [view_result setHidden:false];
        
        for (animalName in [self appDelegate].animals) {
            tmpImageView=[buttonDictionary objectForKey:animalName];            
        }
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [view_result release];
    [super dealloc];
}

- (IBAction)act_result:(id)sender {
    for (animalName in [self appDelegate].animals) {
        tmpImageView=[buttonDictionary objectForKey:animalName];
        tmpImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_SIL_%@.png",animalName]];
        [tmpImageView setAlpha:0.1];
    }
    
    [view_result setHidden:true];
    
    remainAnimals = [[NSMutableArray alloc] initWithArray:[self appDelegate].animals];
    score=0;
    seqAnimal=0;
    [self makeGrid];
    [[self appDelegate] soundPlayBG:@"intro.mp3"];
}


- (IBAction)goVeganSoft:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/vegansoft"]];
}

- (IBAction)goDesignCompany:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.customizedgirl.com"]];
}


@end
