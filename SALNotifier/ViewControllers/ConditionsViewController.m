//
//  ConditionsViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/28/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "ConditionsViewController.h"
#import "ConstantDefines.h"
#import "CPeripheralManager.h"
#import "HelperMethods.h"

@interface ConditionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *roadConditionSegCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *roadMaintSegCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *weatherRoadEffectSegCtrl;
@property (weak, nonatomic) IBOutlet UITextField *txtbxNumPeople;
@property (weak, nonatomic) IBOutlet UITextField *temperatureTextfield;
@property (weak, nonatomic) IBOutlet UISwitch *degreesSelectionSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *precipitationSegCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *precipitationVolumeSegCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cloudCoverageSegCtrl;

@end

@implementation ConditionsViewController

-(void)viewDidLoad
{
	[self configureToolbarOnTopOfKeyboard: self.txtbxNumPeople];
	[self configureToolbarOnTopOfKeyboard: self.temperatureTextfield];
}

-(void)configureToolbarOnTopOfKeyboard:(UITextField*) textField
{
	UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
	numberToolbar.barStyle = UIBarStyleDefault;

	numberToolbar.items = [NSArray arrayWithObjects:
						   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
						   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
						   [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:textField action:@selector(resignFirstResponder)],
						   nil];

	[numberToolbar sizeToFit];
	textField.inputAccessoryView = numberToolbar;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if(textField == self.txtbxNumPeople)
	{
		NSString *numPeople = [NSString stringWithFormat:@"%@%@%@%@",
							   [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines numberOfPeopleTag], [ConstantDefines messageDelimiter]];

		numPeople = [numPeople stringByAppendingString:self.txtbxNumPeople.text];

		[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:numPeople];
	}
	else if (textField == self.temperatureTextfield)
	{
		NSString *degreesMessage = [NSString stringWithFormat:@"%@%@%@%@",
									[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines temperatureTag], [ConstantDefines messageDelimiter]];

		double dTemperature = 0.0;
		if([HelperMethods stringToDouble:self.temperatureTextfield.text derivedDoubleValue:&dTemperature] == FALSE)
			dTemperature = 0.0;

		degreesMessage = [NSString stringWithFormat:@"%@%@%@%.2lf",
								degreesMessage, [ConstantDefines degreesUnitsTag:self.degreesSelectionSwitch.on],
								[ConstantDefines messageDelimiter], dTemperature];

		[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage: degreesMessage];
	}
}

#pragma mark - Weather Conditions Actions


-(IBAction)onDegreeUnitsChange:(UISwitch *)sender
{
	double dTemperature;
	if([HelperMethods stringToDouble:self.temperatureTextfield.text derivedDoubleValue:&dTemperature])
	{
		if(sender.on == FALSE)//False is Celcius
			dTemperature = [HelperMethods fahrenheitToCelcius:dTemperature];
		else
			dTemperature = [HelperMethods celciusToFahrenheit:dTemperature];

		self.temperatureTextfield.text = [NSString stringWithFormat:@"%.1lf", dTemperature];
	}

	NSString *degreesMessage = [NSString stringWithFormat:@"%@%@%@%@",
								[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines temperatureUnitsTag],[ConstantDefines messageDelimiter]];

	degreesMessage = [degreesMessage stringByAppendingString:[ConstantDefines degreesUnitsTag:sender.on]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:degreesMessage];
}

-(IBAction)onConditionSelectionChange:(UISegmentedControl *)sender
{
	if(sender == self.cloudCoverageSegCtrl)
		[self onCloudCoverageChange];
	else if(sender == self.precipitationSegCtrl)
		[self onPrecipitationChange];
	else if(sender == self.precipitationVolumeSegCtrl)
		[self onPrecipitationVoumeChange];
}

-(void)onPrecipitationChange
{
	NSString *precipitationMessage = [NSString stringWithFormat:@"%@%@%@%@",
									  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines percipitationTag],[ConstantDefines messageDelimiter]];

	precipitationMessage = [precipitationMessage stringByAppendingString:[ConstantDefines precipitationTag:(int)self.precipitationSegCtrl.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:precipitationMessage];
}

-(void)onPrecipitationVoumeChange
{
	NSString *precipitationVolumeMessage = [NSString stringWithFormat:@"%@%@%@%@",
											[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines percipitationVolumeTag], [ConstantDefines messageDelimiter]];

	precipitationVolumeMessage = [precipitationVolumeMessage stringByAppendingString:[ConstantDefines precipitationVolumeTag:(int)self.precipitationVolumeSegCtrl.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:precipitationVolumeMessage];
}

-(void)onCloudCoverageChange
{
	NSString *cloudCoverageMessage = [NSString stringWithFormat:@"%@%@%@%@",
									  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines cloudCoverageTag], [ConstantDefines messageDelimiter]];

	cloudCoverageMessage = [cloudCoverageMessage stringByAppendingString:[ConstantDefines cloudCoverageTag:(int)self.cloudCoverageSegCtrl.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:cloudCoverageMessage];
}

#pragma mark - Vehicle Conditions Actions


-(IBAction)onRadioVolumeChange:(UISegmentedControl *)sender
{
	NSString *radioVolumeMessage = [NSString stringWithFormat:@"%@%@%@%@",
									[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines radioVolumeTag], [ConstantDefines messageDelimiter]];

	radioVolumeMessage = [radioVolumeMessage stringByAppendingString:[ConstantDefines radionVolume:(int)sender.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:radioVolumeMessage];
}

-(IBAction)onWindowPositionChanged:(UISegmentedControl *)sender
{
	NSString *windowPositionMessage = [NSString stringWithFormat:@"%@%@%@%@",
									   [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines windowPositionTag], [ConstantDefines messageDelimiter]];

	windowPositionMessage = [windowPositionMessage stringByAppendingString:[ConstantDefines windowPostition:(int)sender.selectedSegmentIndex]];

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:windowPositionMessage];
}



#pragma mark Road Condition Actions

-(IBAction)onRoadConditionChange:(UISegmentedControl *)sender
{
	if(sender == self.roadConditionSegCtrl)
		[self onRoadPavementChange];
	else if(sender == self.roadMaintSegCtrl)
		[self onRoadmaintenanceChange];
	else if(sender == self.weatherRoadEffectSegCtrl)
		[self onRoadWeatherAffectChange];
}

-(void)onRoadPavementChange
{
	NSString *roadConditionMessage = [NSString stringWithFormat:@"%@%@%@%@",
									  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines roadConditionTag], [ConstantDefines messageDelimiter]];

	switch (self.roadConditionSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:[ConstantDefines pavedRoadTag]];
			break;
		case 1:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:[ConstantDefines gravelRoadTag]];
			break;
		default:
			roadConditionMessage = [roadConditionMessage stringByAppendingString:@"UKN"];
			break;
	}

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadConditionMessage];
}

-(void)onRoadmaintenanceChange
{
	NSString *roadMaintenanceMessage = [NSString stringWithFormat:@"%@%@%@%@",
										[ConstantDefines markConditionTag], [ConstantDefines messageDelimiter],[ConstantDefines roadMaintenanceTag], [ConstantDefines messageDelimiter]];

	switch (self.roadMaintSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines smoothRoadTag]];
			break;
		case 1:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines roughRoadTag]];
			break;
		case 2:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:[ConstantDefines bumbpyRoadTag]];
			break;
		default:
			roadMaintenanceMessage = [roadMaintenanceMessage stringByAppendingString:@"UKN"];
			break;
	}

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadMaintenanceMessage];
}

-(void)onRoadWeatherAffectChange
{
	NSString *roadWeatherConditionsMessage = [NSString stringWithFormat:@"%@%@%@%@",
											  [ConstantDefines markConditionTag], [ConstantDefines messageDelimiter], [ConstantDefines weatherInfluenceTag], [ConstantDefines messageDelimiter]];

	switch (self.weatherRoadEffectSegCtrl.selectedSegmentIndex)
	{
		case 0:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines dryRoadTag]];
			break;
		case 1:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines wetRoadTag]];
			break;
		case 2:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines floodedRoadTag]];
			break;
		case 3:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines icyRoadTag]];
			break;
		default:
			roadWeatherConditionsMessage = [roadWeatherConditionsMessage stringByAppendingString:[ConstantDefines snowyRoadTag]];//Reserved and not used right now.
			break;
	}

	[[CPeripheralManager thePeripheralManager] sendEventNotificationMessage:roadWeatherConditionsMessage];
}

@end
