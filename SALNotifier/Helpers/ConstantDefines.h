/*
//  ConstantDefines.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/23/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface ConstantDefines : NSObject

+(NSString *)messageDelimiter;

+(NSString *)endEventTag;
+(NSString *)startEventTag;
+(NSString *)markConditionTag;

//Condition Identifiers
+(NSString *)temperatureTag;
+(NSString *)radioVolumeTag;
+(NSString *)percipitationTag;
+(NSString *)cloudCoverageTag;
+(NSString *)roadConditionTag;
+(NSString *)windowPositionTag;
+(NSString *)numberOfPeopleTag;
+(NSString *)roadMaintenanceTag;
+(NSString *)weatherInfluenceTag;
+(NSString *)temperatureUnitsTag;
+(NSString *)percipitationVolumeTag;

//Road Condition Markers
+(NSString *)dryRoadTag;
+(NSString *)wetRoadTag;
+(NSString *)icyRoadTag;
+(NSString *)snowyRoadTag;
+(NSString *)roughRoadTag;
+(NSString *)pavedRoadTag;
+(NSString *)bumbpyRoadTag;
+(NSString *)gravelRoadTag;
+(NSString *)smoothRoadTag;
+(NSString *)floodedRoadTag;

//Weather Condition Markers

/**
 @param: percipitationType: (0 = rain) (1 = snow) (2 = sleet)
 */
+(NSString *)precipitationTag:(int)percipitationType;

/**
 @param: bFahrenheit: (true = fahrenheit) (false = celcius)
 */
+(NSString *)degreesUnitsTag:(BOOL)bFahrenheit;

/**
 @param: volume: (0 = light) (1 = medium) (2 = heavy)
 */
+(NSString *)precipitationVolumeTag:(int)volume;

/**
 @param: coverage: (0 = Clear) (1 = Partial Sunny) (2 = Overcast) (3 = Heavy clouds)
 */
+(NSString *)cloudCoverageTag:(int)coverage;


//Vehicle Condition
+(NSString *)radionVolume:(int)volume;
+(NSString *)windowPostition:(int)position;

//Event Markers
+(NSString *)walkingTag;
+(NSString *)speedingTag;
+(NSString *)hardBrakingTag;
+(NSString *)vehicleExitTag;
+(NSString *)vehicleEntryTag;
+(NSString *)hardLeftTurnTag;
+(NSString *)hardRightTurnTag;
+(NSString *)rapidAccelerationTag;

//Road Hazards
+(NSString *)potholeTag;
+(NSString *)rumbleStripsTag;

+(NSString *)windowUpTag;

//Vehicle Condition
+(NSString *)flatTireTag;
+(NSString *)barometricTag;
+(NSString *)windowDownTag;

+(NSString *)phoneHandlingGenericTag;
+(NSString *)phoneHandlingTextingTag;
+(NSString *)phoneHandlingTalkingTag;

@end



