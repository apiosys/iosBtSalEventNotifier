/*
//  ViewController.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "ViewController.h"
#import "CPeripheralManager.h"
#import "ConstantDefines.h"

@interface ViewController ()
	@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
	@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowerThirdHeightConstraint;
	@property (weak, nonatomic) IBOutlet UIButton *advertisingButton;

	-(IBAction)onAdvertise:(UIButton *)sender;


	-(NSString*)versionInformation;
@end

@implementation ViewController
{
	CGFloat _startingLowerThirdHeight;
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	_startingLowerThirdHeight = self.lowerThirdHeightConstraint.constant;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.versionLabel.text = [self versionInformation];
	[UIView performWithoutAnimation: ^
	 {
		 [self configureAdvertisingButtonisAdvertising:[CPeripheralManager thePeripheralManager].isAdvertising];
		 [self.advertisingButton layoutIfNeeded];
	 }];
}

-(IBAction)onAdvertise:(UIButton *)sender
{
	CPeripheralManager * peripheralManager = [CPeripheralManager thePeripheralManager];
	if (peripheralManager.isAdvertising)
	{
		[[CPeripheralManager thePeripheralManager] stopAdvertisingTheServices];
		[sender setTitle:[ConstantDefines startAdvertisingText] forState:UIControlStateNormal];

		[self configureAdvertisingButtonisAdvertising:FALSE];
	}
	else
	{
		[[CPeripheralManager thePeripheralManager] advertiseTheServices];
		[sender setTitle:[ConstantDefines stopAdvertisingText] forState:UIControlStateNormal];
		 [self configureAdvertisingButtonisAdvertising:TRUE];
		 }
}

-(void)configureAdvertisingButtonisAdvertising:(BOOL)isAdvertising
{
	NSString * buttonText;
	if (isAdvertising)
	{
		buttonText = [ConstantDefines stopAdvertisingText];
	}
	else
	{
		buttonText = [ConstantDefines startAdvertisingText];
	}

	[self.advertisingButton setTitle:buttonText forState:UIControlStateNormal];

	UIColor * tintColor = (isAdvertising) ? [UIColor redColor] : nil;

	[self.advertisingButton setTintColor:tintColor];
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
