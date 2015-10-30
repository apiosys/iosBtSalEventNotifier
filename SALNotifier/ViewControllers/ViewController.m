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
	@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowerThirdHeightConstraint;

	-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop;//TRUE = Start  FALSE = Stop

	-(IBAction)onAdvertise:(UIButton *)sender;

	-(NSString*)versionInformation;
@end

@implementation ViewController
{
	CGFloat _startingLowerThirdHeight;
	UIColor * _startingButtonColor;
}

@synthesize periphMgr = _periphMgr;

-(void)viewDidLoad
{
	[super viewDidLoad];
	_startingLowerThirdHeight = self.lowerThirdHeightConstraint.constant;
	_startingButtonColor = [self.btnStartStopAdvertising titleColorForState:UIControlStateNormal];
	[self configureButtonBackGround:self.btnStartStopAdvertising isStart:FALSE];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.lblVersionInfo.text = [self versionInformation];
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
	UIColor * labelColor = (bIsStartOrStop) ? [UIColor redColor] : _startingButtonColor;
	[btn setTitleColor:labelColor forState:UIControlStateNormal];
}

-(NSString *)versionInformation
{
	id localizedVersion = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *version = (localizedVersion != nil) ? localizedVersion : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

	NSString *appName = [[[[NSBundle mainBundle] bundleIdentifier] componentsSeparatedByString:@"."] lastObject];

	return [NSString stringWithFormat:@"%@ - Ver: %@", appName, version];
}

- (IBAction)moveLineSeperator:(UIPanGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateChanged)
	{
		CGPoint translation = [sender translationInView:sender.view];
		CGFloat currentHeight = self.lowerThirdHeightConstraint.constant;
		CGFloat newHeight = currentHeight - translation.y;
		if (newHeight < 0.0)
		{
			newHeight = 0.0;
		}
		else if (newHeight > _startingLowerThirdHeight)
		{
			newHeight = _startingLowerThirdHeight;
		}
		self.lowerThirdHeightConstraint.constant = newHeight;

		[sender setTranslation:CGPointZero inView:sender.view];
	}
	else if(sender.state == UIGestureRecognizerStateEnded)
	{
		CGPoint velocity = [sender velocityInView:sender.view];

		CGFloat currentHeight = self.lowerThirdHeightConstraint.constant;
		CGFloat endingHeight;
		// Handle case where user rapidly swipes one direction or the other
		if (velocity.y > 300.0)
		{
			endingHeight = 0.0;
		}
		else if (velocity.y < -300.0)
		{
			endingHeight = _startingLowerThirdHeight;
		}
		// Handle user stopping before fully up or down
		else if (currentHeight < _startingLowerThirdHeight/2)
		{
			endingHeight = 0.0;
		}
		else
		{
			endingHeight = _startingLowerThirdHeight;
		}

		// Animate Change
		[self.view layoutIfNeeded];
		self.lowerThirdHeightConstraint.constant = endingHeight;
		[UIView animateWithDuration:0.25 animations:^{
			[self.view layoutIfNeeded];
		}];

	}
}


@end
