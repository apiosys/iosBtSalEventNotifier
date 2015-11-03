/*
//  ViewController.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "ViewController.h"

@interface ViewController ()
	@property(nonatomic, weak) IBOutlet UILabel *lblVersionInfo;
	@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowerThirdHeightConstraint;

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

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.lblVersionInfo.text = [self versionInformation];
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
