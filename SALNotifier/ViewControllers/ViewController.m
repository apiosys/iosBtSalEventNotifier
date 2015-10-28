/*
//  ViewController.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "ViewController.h"
#import "CPeripheralManager.h"

static NSString * const STOP_ADVERTISING_TEXT = @"Stop Advertising";
static NSString * const START_ADVERTISING_TEXT = @"Start Advertising";

@interface ViewController ()
	@property(nonatomic, weak) IBOutlet UIButton *btnStartStopAdvertising;
	@property(nonatomic, weak) IBOutlet UILabel *lblVersionInfo;

	@property(nonatomic ,strong) CPeripheralManager *periphMgr;
	@property (weak, nonatomic) IBOutlet UIView *theLineSeparatorView;

	-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop;//TRUE = Start  FALSE = Stop

	-(IBAction)onAdvertise:(UIButton *)sender;

	-(NSString*)versionInformation;
@end

@implementation ViewController

@synthesize periphMgr = _periphMgr;

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.lblVersionInfo.text = [self versionInformation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touches");
}

-(IBAction)onAdvertise:(UIButton *)sender
{
	if([sender.currentTitle compare:START_ADVERTISING_TEXT] == NSOrderedSame)//Starting advertising
	{
		[[CPeripheralManager thePeripheralManager] advertiseTheServices];
		[sender setTitle:STOP_ADVERTISING_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:sender isStart:TRUE];
	}
	else if([sender.currentTitle compare:STOP_ADVERTISING_TEXT] == NSOrderedSame)
	{
		[[CPeripheralManager thePeripheralManager] stopAdvertisingTheServices];
		[sender setTitle:START_ADVERTISING_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:sender isStart:FALSE];
	}
}

-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop
{
	btn.layer.cornerRadius = 10.0f;
	btn.layer.masksToBounds = TRUE;

	if(bIsStartOrStop == TRUE)//If you're starting
		btn.layer.borderColor = [[UIColor redColor]CGColor];
	else
		btn.layer.borderColor = [[UIColor colorWithRed:206.0 / 255.0 green:206.0 / 255.0 blue:206.0 / 255.0 alpha:1.0]CGColor];

	btn.layer.borderWidth = 5.0f;
}

-(NSString *)versionInformation
{
	id localizedVersion = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *version = (localizedVersion != nil) ? localizedVersion : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

	NSString *appName = [[[[NSBundle mainBundle] bundleIdentifier] componentsSeparatedByString:@"."] lastObject];

	return [NSString stringWithFormat:@"%@ - Ver: %@", appName, version];
}

@end
