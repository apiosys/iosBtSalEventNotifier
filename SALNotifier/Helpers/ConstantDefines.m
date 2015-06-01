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
	return @"WK";
}

+(NSString *)speedingTag
{
	return @"SP";
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
	return @"VX";
}

+(NSString *)vehicleEntryTag
{
	return @"VE";
}

+(NSString *)potholeTag
{
	return @"PTH";
}

+(NSString *)windowUpTag
{
	return @"WUP";
}

+(NSString *)flatTireTag
{
	return @"FLT";
}

+(NSString *)barometricTag
{
	return @"BAR";
}

+(NSString *)windowDownTag
{
	return @"WDN";
}

+(NSString *)rumbleStripsTag
{
	return @"RBS";
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
	return @"RUF";
}

+(NSString *)bumbpyRoadTag
{
	return @"BPY";
}

+(NSString *)pavedRoadTag
{
	return @"PVD";
}

+(NSString *)gravelRoadTag
{
	return @"GVL";
}

+(NSString *)floodedRoadTag
{
	return @"FLD";
}

+(NSString *)smoothRoadTag
{
	return @"SMH";
}

+(NSString *)icyRoadTag
{
	return @"ICE";
}

+(NSString *)snowyRoadTag
{
	return @"SNW";
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
			return @"LT";
		case 1:
			return @"MD";
		case 2:
			return @"HV";
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
			return @"CLR";
		case 1:
			return @"PSU";
		case 2:
			return @"OVC";
		case 3:
			return @"HVY";
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
			return @"RAI";
		case 1:
			return @"SNW";
		case 2:
			return @"SLT";
		default:
			break;
	}
	
	return @"UNK";
}

@end
