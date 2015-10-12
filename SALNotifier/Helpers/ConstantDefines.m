/*
//  ConstantDefines.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/23/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "ConstantDefines.h"

@implementation ConstantDefines

+(NSString *)messageDelimiter
{
	return @":";
}

+(NSString *)markConditionTag
{
	return @"MC";
}

+(NSString *)endEventTag
{
	return @"EE";
}

+(NSString *)startEventTag
{
	return @"SE";
}

+(NSString *)temperatureTag
{
	return @"TEMP";
}

+(NSString *)radioVolumeTag
{
	return @"VOL";
}

+(NSString *)percipitationTag
{
	return @"PERCIP";
}

+(NSString *)cloudCoverageTag
{
	return @"CLDCOV";
}

+(NSString *)roadConditionTag
{
	return @"ROADFINISH";
}

+(NSString *)windowPositionTag
{
	return @"WINDOWPOS";
}

+(NSString *)numberOfPeopleTag
{
	return @"NUMBERPEOPLE";
}

+(NSString *)roadMaintenanceTag
{
	return @"ROADMAINTENANCE";
}

+(NSString *)weatherInfluenceTag
{
	return @"WEATHINFLUENCE";
}

+(NSString *)temperatureUnitsTag
{
	return @"TEMPUNIT";
}

+(NSString *)percipitationVolumeTag
{
	return @"PRECIPVOL";
}

+(NSString *)hardBrakingTag
{
	return @"HB";
}

+(NSString *)rapidAccelerationTag
{
	return @"RA";
}

+(NSString *)walkingTag
{
	return @"WALK";
}

+(NSString *)speedingTag
{
	return @"SPEED";
}

+(NSString *)hardLeftTurnTag
{
	return @"HTL";
}

+(NSString *)hardRightTurnTag
{
	return @"HTR";
}

+(NSString *)vehicleExitTag
{
	return @"VEHEX";
}

+(NSString *)vehicleEntryTag
{
	return @"VEHENT";
}

+(NSString *)potholeTag
{
	return @"POTHOLE";
}

+(NSString *)windowUpTag
{
	return @"WINDOWUP";
}

+(NSString *)flatTireTag
{
	return @"FLAT";
}

+(NSString *)barometricTag
{
	return @"BAROMETRIC";
}

+(NSString *)windowDownTag
{
	return @"WINDOWDOWN";
}

+(NSString *)rumbleStripsLeftTag
{
	return @"RBL";
}

+(NSString *)rumbleStripsRightTag
{
	return @"RBR";
}

+(NSString *)airbagDriverTag
{
	return @"ABD";
}

+(NSString *)airbagPassengerTag
{
	return @"ABP";
}

+(NSString *)doorSlamTag
{
	return @"DS";
}

+(NSString *)phoneHandlingGenericTag
{
	return @"PHG";
}

+(NSString *)phoneHandlingTextingTag
{
	return @"PHX";
}

+(NSString *)phoneHandlingTalkingTag
{
	return @"PHK";
}

//Road Condition Markers
+(NSString *)dryRoadTag
{
	return @"DRY";
}

+(NSString *)wetRoadTag
{
	return @"WET";
}

+(NSString *)roughRoadTag
{
	return @"ROUGH";
}

+(NSString *)bumbpyRoadTag
{
	return @"BUMPY";
}

+(NSString *)pavedRoadTag
{
	return @"PAVED";
}

+(NSString *)gravelRoadTag
{
	return @"GRAVEL";
}

+(NSString *)floodedRoadTag
{
	return @"FLOODED";
}

+(NSString *)smoothRoadTag
{
	return @"SMOOTH";
}

+(NSString *)icyRoadTag
{
	return @"ICY";
}

+(NSString *)snowyRoadTag
{
	return @"SNOW";
}

+(NSString *)radionVolume:(int)volume
{
	switch (volume)
	{
		case 0:
			return @"LOUD";
		case 1:
			return @"MED";
		case 2:
			return @"LOW";
		case 3:
			return @"OFF";
		default:
			return @"UKN";
	}
}

+(NSString *)windowPostition:(int)position
{
	switch (position)
	{
		case 0:
			return @"UP";
		case 1:
			return @"CRACKED";
		case 2:
			return @"HALFWAY";
		case 3:
			return @"DOWN";
		default:
			return @"UNK";
			break;
	}
}

+(NSString *)degreesUnitsTag:(BOOL)bFahrenheit
{
	return (bFahrenheit == TRUE) ? @"FHR" : @"CEL";
}

+(NSString *)precipitationVolumeTag:(int)volume
{
	switch (volume)
	{
		case 0:
			return @"LITE";
		case 1:
			return @"MED";
		case 2:
			return @"HEAVY";
		default:
			break;
	}
	
	return @"UKN";
}

+(NSString *)cloudCoverageTag:(int)coverage
{
	switch (coverage)
	{
		case 0:
			return @"CLEAR";
		case 1:
			return @"PARTLYSUN";
		case 2:
			return @"OVRCAST";
		case 3:
			return @"HEAVY";
		default:
			break;
	}
	
	return @"UNK";
}

+(NSString *)precipitationTag:(int)percipitationType
{
	switch (percipitationType)
	{
		case 0:
			return @"RAIN";
		case 1:
			return @"SNOW";
		case 2:
			return @"SLEET";
		default:
			break;
	}
	
	return @"UNK";
}

@end
