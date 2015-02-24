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

+(NSString *)icyRoadTag;
+(NSString *)snowyRoadTag;
+(NSString *)hardBrakingTag;
+(NSString *)rapidAccelerationTag;
+(NSString *)walkingTag;
+(NSString *)speedingTag;
+(NSString *)hardLeftTurnTag;
+(NSString *)hardRightTurnTag;
+(NSString *)vehicleExitTag;
+(NSString *)vehicleEntryTag;

+(NSString *)potholeTag;
+(NSString *)windowUpTag;
+(NSString *)flatTireTag;
+(NSString *)barometricTag;
+(NSString *)windowDownTag;
+(NSString *)rumbleStripsTag;
+(NSString *)phoneHandlingGenericTag;
+(NSString *)phoneHandlingTextingTag;
+(NSString *)phoneHandlingTalkingTag;



@end
