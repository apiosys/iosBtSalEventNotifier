/*
//  StartStopEventsView.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 4/22/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "StartStopEventsView.h"
#import "CPeripheralManager.h"

static NSString * const STOP_HB_TEXT = @"Stop HB";
static NSString * const START_HB_TEXT = @"Start HB";

static NSString * const STOP_RA_TEXT = @"Stop RA";
static NSString * const START_RA_TEXT = @"Start RA";

static NSString * const STOP_WK_TEXT = @"Stop Walking";
static NSString * const START_WK_TEXT = @"Start Walking";

static NSString * const STOP_VE_TEXT = @"Stop Veh. Entry";
static NSString * const START_VE_TEXT = @"Start Veh. Entry";

static NSString * const STOP_SP_TEXT = @"Stop Speeding";
static NSString * const START_SP_TEXT = @"Start Speeding";

static NSString * const STOP_VX_TEXT = @"Stop Veh. Exit";
static NSString * const START_VX_TEXT = @"Start Veh. Exit";

static NSString * const STOP_HTL_TEXT = @"Stop Hard-Left";
static NSString * const START_HTL_TEXT = @"Start Hard-Left";

static NSString * const STOP_HTR_TEXT = @"Stop Hard-Right";
static NSString * const START_HTR_TEXT = @"Start Hard-Right";

static NSString * const STOP_ADVERTISING_TEXT = @"Stop Advertising";
static NSString * const START_ADVERTISING_TEXT = @"Start Advertising";

static NSString * const STOP_ICYROAD_TEXT = @"Stop Icy Road";
static NSString * const START_ICYROAD_TEXT = @"Start Icy Road";

static NSString * const STOP_SNOWYROAD_TEXT = @"Stop Snow Road";
static NSString * const START_SNOWYROAD_TEXT = @"Start Snow Road";

@interface StartStopEventsView()
	@property(nonatomic, strong) UIColor *notSelectedBorderColor;

	-(IBAction)onStartStopEvent:(UIButton *)sender;
@end

@implementation StartStopEventsView
{
	CGSize _intrinsicContentSize;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	//1. Load the nib to allow the nib to drive the frame
	if([[NSBundle mainBundle] loadNibNamed:@"StartStopEventsView" owner:self options:nil] == nil)
		return self;
	
	//2. Adjust the bounds. DON'T set the frame here. That will override the IB layout of where the frame gets placed.
	self.bounds = self.backingView.bounds;
	
	//NOTE: You can set the "intrinsicContextSize" within your view.
	//This will help eliminate some of the autolayout constraints and
	//get your view to load more cleanly
	_intrinsicContentSize = self.bounds.size;
	
	//3. Add as sub-view. Note to be sure to add this only AFTER the bounds are set.
	[self addSubview:self.backingView];
	
	self.layer.borderColor = [UIColor blackColor].CGColor;
	
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];

	//1. So that all the dimiensions and connections from the nib. ie: Load the interface
	if([[NSBundle mainBundle]loadNibNamed:@"StartStopEventsView" owner:self options:nil] == nil)
		return self;

	_intrinsicContentSize = self.bounds.size;

	//2. Must now add as a sub-view
	[self addSubview:self.backingView];

	self.layer.borderColor = [UIColor blackColor].CGColor;

	return self;
}

-(void)configureButtonFrames:(UIView *)topView
{
	if(topView == nil)
		topView = self.backingView;

	for(UIView *vw in topView.subviews)
	{
		if([vw isKindOfClass:[UIScrollView class]] == TRUE)
		{
			[self configureButtonFrames:vw];
			continue;
		}

		UIButton *btn = (UIButton *)vw;
		
		if( ([btn.restorationIdentifier compare:@"startStopHbButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopRAButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopWalkingButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopSpeedingButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopVehEntryButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopVehicleExitButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopHardTurnLeftButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopHardTurnRightButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopIceRoadButton"] == NSOrderedSame) ||
				([btn.restorationIdentifier compare:@"startStopSnowRoadButton"] == NSOrderedSame) )
		{
			[self configureButtonBackGround:btn isStart:FALSE];
		}
	}
}

-(UIColor *)notSelectedBorderColor
{
	if(_notSelectedBorderColor == nil)
		_notSelectedBorderColor = [UIColor colorWithRed:206.0 / 255.0 green:206.0 / 255.0 blue:206.0 / 255.0 alpha:1.0];

	return _notSelectedBorderColor;
}

-(IBAction)onStartStopEvent:(UIButton *)sender
{	
	//Using local methods instead IBActions so we have more freedom in the future
	//with the number of parameters we pass into the handling methods.
	if([sender.restorationIdentifier compare:@"startStopHbButton"] == NSOrderedSame)
		[self handleEventHB:sender];
	else if([sender.restorationIdentifier compare:@"startStopRAButton"] == NSOrderedSame)
		[self handleEventRA:sender];
	else if([sender.restorationIdentifier compare:@"startStopWalkingButton"] == NSOrderedSame)
		[self handleEventWK:sender];
	else if([sender.restorationIdentifier compare:@"startStopSpeedingButton"] == NSOrderedSame)
		[self handleEventSP:sender];
	else if([sender.restorationIdentifier compare:@"startStopVehEntryButton"] == NSOrderedSame)
		[self handleEventVE:sender];
	else if([sender.restorationIdentifier compare:@"startStopVehicleExitButton"] == NSOrderedSame)
		[self handleEventVX:sender];
	else if([sender.restorationIdentifier compare:@"startStopHardTurnLeftButton"] == NSOrderedSame)
		[self handleEventHTL:sender];
	else if([sender.restorationIdentifier compare:@"startStopHardTurnRightButton"] == NSOrderedSame)
		[self handleEventHTR:sender];
	else if([sender.restorationIdentifier compare:@"startStopIceRoadButton"] == NSOrderedSame)
		[self handleEventIce:sender];
	else if([sender.restorationIdentifier compare:@"startStopSnowRoadButton"] == NSOrderedSame)
		[self handleEventSnow:sender];
}

-(void)handleEventHB:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_HB_TEXT] == NSOrderedSame)//Starting a hard-brake event
	{
		[periphMgr updateServiceValue:HB_START];
		[btn setTitle:STOP_HB_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HB_TEXT] == NSOrderedSame)//Starting a hard-brake event
	{
		[periphMgr updateServiceValue:HB_STOP];
		[btn setTitle:START_HB_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventRA:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_RA_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:RA_START];
		[btn setTitle:STOP_RA_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_RA_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:RA_STOP];
		[btn setTitle:START_RA_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventVE:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_VE_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_ENTRY_START];
		[btn setTitle:STOP_VE_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_VE_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_ENTRY_STOP];
		[btn setTitle:START_VE_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventVX:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_VX_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_EXIT_START];
		[btn setTitle:STOP_VX_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_VX_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_EXIT_STOP];
		[btn setTitle:START_VX_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventWK:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_WK_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:WK_START];
		[btn setTitle:STOP_WK_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_WK_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:WK_STOP];
		[btn setTitle:START_WK_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventSP:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_SP_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:SPEEDING_START];
		[btn setTitle:STOP_SP_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_SP_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:SPEEDING_STOP];
		[btn setTitle:START_SP_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventHTL:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_HTL_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_LEFT_START];
		[btn setTitle:STOP_HTL_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HTL_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_LEFT_STOP];
		[btn setTitle:START_HTL_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventHTR:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_HTR_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_RIGHT_START];
		[btn setTitle:STOP_HTR_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HTR_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_RIGHT_STOP];
		[btn setTitle:START_HTR_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventIce:(UIButton *)btn//Icy Road
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_ICYROAD_TEXT] == NSOrderedSame)//Starting a Icy Road event
	{
		[periphMgr updateServiceValue:ICY_START];
		[btn setTitle:STOP_ICYROAD_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_ICYROAD_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:ICY_STOP];
		[btn setTitle:START_ICYROAD_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)handleEventSnow:(UIButton *)btn//Snowy Road
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_SNOWYROAD_TEXT] == NSOrderedSame)//Starting a Icy Road event
	{
		[periphMgr updateServiceValue:SNOW_START];
		[btn setTitle:STOP_SNOWYROAD_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_SNOWYROAD_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:SNOW_STOP];
		[btn setTitle:START_SNOWYROAD_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:btn isStart:FALSE];
	}
}

-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop
{
	btn.layer.cornerRadius = 10.0f;
	btn.layer.masksToBounds = TRUE;
	btn.layer.borderWidth = 5.0f;
	
	if(bIsStartOrStop == TRUE)//If you're starting
		btn.layer.borderColor = [[UIColor redColor]CGColor];
	else
		btn.layer.borderColor = self.notSelectedBorderColor.CGColor;
}

@end
