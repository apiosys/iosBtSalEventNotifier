/*
//  ViewController.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "ViewController.h"
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

static const short ADVERTISING_BUTTON_BACKGROUND_IMG_TAG_VALUE = 1;
static const short HARDBRAKING_BUTTON_BACKGROUND_IMG_TAG_VALUE = 2;
static const short RAPIDACCELERATION_BUTTON_BACKGROUND_IMG_TAG_VALUE = 3;
static const short WALKING_BUTTON_BACKGROUND_IMG_TAG_VALUE = 4;
static const short VEHICLE_ENTRY_BUTTON_BACKGROUND_IMG_TAG_VALUE = 5;
static const short HARD_LEFT_BUTTON_BACKGROUND_IMG_TAG_VALUE = 6;
static const short VEHICLE_EXIT_BUTTON_BACKGROUND_IMG_TAG_VALUE = 7;
static const short HARD_RIGHT_BUTTON_BACKGROUND_IMG_TAG_VALUE = 8;
static const short SPEEDING_BUTTON_BACKGROUND_IMG_TAG_VALUE = 9;

@interface ViewController ()
	@property(nonatomic ,strong) CPeripheralManager *periphMgr;

	-(void)handleEventHB:(UIButton *)btn;//Hard-brake
	-(void)handleEventRA:(UIButton *)btn;//Rapid Accel
	-(void)handleEventVE:(UIButton *)btn;//Veh Entry
	-(void)handleEventVX:(UIButton *)btn;//Veh Exit
	-(void)handleEventWK:(UIButton *)btn;//Walking
	-(void)handleEventSP:(UIButton *)btn;//Speeding
	-(void)handleEventHTL:(UIButton *)btn;//Hard-Turn Left
	-(void)handleEventHTR:(UIButton *)btn;//Hard-Turn Right

	-(void)configureButtonBackGround:(short)sBGImageTagIndex isStart:(BOOL)bIsStartOrStop;//TRUE = Start  FALSE = Stop

	-(IBAction)onAdvertise:(UIButton *)sender;
	-(IBAction)onEventSelected:(UIButton *)sender;
@end

@implementation ViewController

@synthesize periphMgr = _periphMgr;

-(IBAction)onAdvertise:(UIButton *)sender
{
	if([sender.currentTitle compare:START_ADVERTISING_TEXT] == NSOrderedSame)//Starting advertising
	{
		[[CPeripheralManager thePeripheralManager] advertiseTheServices];
		[sender setTitle:STOP_ADVERTISING_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:ADVERTISING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([sender.currentTitle compare:STOP_ADVERTISING_TEXT] == NSOrderedSame)
	{
		[[CPeripheralManager thePeripheralManager] stopAdvertisingTheServices];
		[sender setTitle:START_ADVERTISING_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:ADVERTISING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(IBAction)onEventSelected:(UIButton *)sender
{
	NSLog(@"%@", sender.restorationIdentifier);

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
}

-(void)handleEventHB:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];

	if([btn.currentTitle compare:START_HB_TEXT] == NSOrderedSame)//Starting a hard-brake event
	{
		[periphMgr updateServiceValue:HB_START];
		[btn setTitle:STOP_HB_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARDBRAKING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HB_TEXT] == NSOrderedSame)//Starting a hard-brake event
	{
		[periphMgr updateServiceValue:HB_STOP];
		[btn setTitle:START_HB_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARDBRAKING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventRA:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];

	if([btn.currentTitle compare:START_RA_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:RA_START];
		[btn setTitle:STOP_RA_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:RAPIDACCELERATION_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_RA_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:RA_STOP];
		[btn setTitle:START_RA_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:RAPIDACCELERATION_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventVE:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_VE_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_ENTRY_START];
		[btn setTitle:STOP_VE_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:VEHICLE_ENTRY_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_VE_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_ENTRY_STOP];
		[btn setTitle:START_VE_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:VEHICLE_ENTRY_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventVX:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_VX_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_EXIT_START];
		[btn setTitle:STOP_VX_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:VEHICLE_EXIT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_VX_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:VEHICLE_EXIT_STOP];
		[btn setTitle:START_VX_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:VEHICLE_EXIT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventWK:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_WK_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:WK_START];
		[btn setTitle:STOP_WK_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:WALKING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_WK_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:WK_STOP];
		[btn setTitle:START_WK_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:WALKING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventSP:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_SP_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:SPEEDING_START];
		[btn setTitle:STOP_SP_TEXT forState:UIControlStateNormal];
		
		[self configureButtonBackGround:SPEEDING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_SP_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:SPEEDING_STOP];
		[btn setTitle:START_SP_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:SPEEDING_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventHTL:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];
	
	if([btn.currentTitle compare:START_HTL_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_LEFT_START];
		[btn setTitle:STOP_HTL_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARD_LEFT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HTL_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_LEFT_STOP];
		[btn setTitle:START_HTL_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARD_LEFT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)handleEventHTR:(UIButton *)btn
{
	CPeripheralManager *periphMgr = [CPeripheralManager thePeripheralManager];

	if([btn.currentTitle compare:START_HTR_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_RIGHT_START];
		[btn setTitle:STOP_HTR_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARD_RIGHT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:TRUE];
	}
	else if([btn.currentTitle compare:STOP_HTR_TEXT] == NSOrderedSame)//Starting a Rapid Acceleration event
	{
		[periphMgr updateServiceValue:HT_RIGHT_STOP];
		[btn setTitle:START_HTR_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:HARD_RIGHT_BUTTON_BACKGROUND_IMG_TAG_VALUE isStart:FALSE];
	}
}

-(void)configureButtonBackGround:(short)sBGImageTagIndex isStart:(BOOL)bIsStartOrStop
{
	UIView *vwBtnBG = [self.view viewWithTag:sBGImageTagIndex];

	if(vwBtnBG == nil)
		return;

	vwBtnBG.layer.cornerRadius = 10.0f;
	vwBtnBG.layer.masksToBounds = TRUE;

	if(bIsStartOrStop == TRUE)//If you're starting
		vwBtnBG.layer.borderColor = (sBGImageTagIndex != ADVERTISING_BUTTON_BACKGROUND_IMG_TAG_VALUE) ? [[UIColor redColor]CGColor] : [[UIColor blueColor]CGColor];
	else
		vwBtnBG.layer.borderColor = [[UIColor whiteColor]CGColor];

	vwBtnBG.layer.borderWidth = 5.0f;
}

@end