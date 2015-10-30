//
//  EventAction.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 10/29/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "EventAction.h"
#import "ConstantDefines.h"
#import "CPeripheralManager.h"

@interface EventAction()
	+(EventAction*) eventActionForTag:(NSString*)tag andDisplayLabel:(NSString*)displayLabel;
	-(void) setEventTag:(NSString*) tag;
	-(void) setDisplayLabel:(NSString*) displayLabel;
	-(NSString*) serviceValueMessage;

@end

@implementation EventAction

+ (NSArray *)allEventActions
{
	static dispatch_once_t once;
	static NSArray * eventActions;
	dispatch_once(&once, ^{
		eventActions = @[
						 [EventAction eventActionForTag:[ConstantDefines hardBrakingTag] andDisplayLabel:@"Hard Brake"],
						 [EventAction eventActionForTag:[ConstantDefines rapidAccelerationTag] andDisplayLabel:@"Rapid Acceleration"],
						 [EventAction eventActionForTag:[ConstantDefines vehicleEntryTag] andDisplayLabel:@"Vehicle Entry"],
						 [EventAction eventActionForTag:[ConstantDefines vehicleExitTag] andDisplayLabel:@"Vehicle Exit"],
						 [EventAction eventActionForTag:[ConstantDefines hardLeftTurnTag] andDisplayLabel:@"Hard Turn-Left"],
						 [EventAction eventActionForTag:[ConstantDefines hardRightTurnTag] andDisplayLabel:@"Hard Turn-Right"],
						 [EventAction eventActionForTag:[ConstantDefines speedingTag] andDisplayLabel:@"Speeding"],
						 [EventAction eventActionForTag:[ConstantDefines walkingTag] andDisplayLabel:@"Walking"],
						 [EventAction eventActionForTag:[ConstantDefines laneChangeLeftTag] andDisplayLabel:@"Lane Change-Left"],
						 [EventAction eventActionForTag:[ConstantDefines laneChangeRightTag] andDisplayLabel:@"Lane Change-Right"],
						 [EventAction eventActionForTag:[ConstantDefines rumbleStripsLeftTag] andDisplayLabel:@"Rumble Strips-Left"],
						 [EventAction eventActionForTag:[ConstantDefines rumbleStripsRightTag] andDisplayLabel:@"Rumble Strips-Right"],
						 [EventAction eventActionForTag:[ConstantDefines airbagDriverTag] andDisplayLabel:@"Airbag-Driver"],
						 [EventAction eventActionForTag:[ConstantDefines airbagPassengerTag] andDisplayLabel:@"Airbag-Passenger"],
						 [EventAction eventActionForTag:[ConstantDefines doorSlamTag] andDisplayLabel:@"Door Slam"]
						 ];
	});

	return eventActions;
}

+(EventAction *)eventActionForTag:(NSString *)tag andDisplayLabel:(NSString *)displayLabel
{
	EventAction * action = [[EventAction alloc] init];
	[action setEventTag:tag];
	[action setDisplayLabel:displayLabel];
	return action;
}

-(void)setEventTag:(NSString *)tag
{
	_eventTag = tag;
}

-(void)setDisplayLabel:(NSString *)displayLabel
{
	_displayLabel = displayLabel;
}

-(void)sendAction
{
	_isStarted = !_isStarted;
	[[CPeripheralManager thePeripheralManager] updateServiceValueWithMessage:[self serviceValueMessage]];
}

-(NSString*) serviceValueMessage
{
	NSString * marker;
	if (self.isStarted)
	{
		marker = [ConstantDefines startEventTag];
	}
	else
	{
		marker = [ConstantDefines endEventTag];
	}
	return [NSString stringWithFormat:@"%@%@%@", marker, [ConstantDefines messageDelimiter], self.eventTag];
}

@end
