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
	return @"flt";
}

+(NSString *)barometricTag
{
	return @"bar";
}

+(NSString *)windowDownTag
{
	return @"WDN";
}

+(NSString *)rumbleStripsTag
{
	return @"rbs";
}

+(NSString *)phoneHandlingGenericTag
{
	return @"phg";
}

+(NSString *)phoneHandlingTextingTag
{
	return @"phx";
}

+(NSString *)phoneHandlingTalkingTag
{
	return @"phk";
}

+(NSString *)icyRoadTag
{
	return @"ICE";
}

+(NSString *)snowyRoadTag
{
	return @"SNW";
}

@end
