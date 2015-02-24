/*
//  HelperMethods.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/23/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#import "HelperMethods.h"
#import "ConstantDefines.h"

@implementation HelperMethods

+(NSString *)notificationEnumToString:(NOTIFICATION_EVENTS)eNotificationEvent
{
	NSString *strMessage = nil;

	switch (eNotificationEvent)
	{
		case HB_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardBrakingTag]];
			break;
		case HB_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardBrakingTag]];
			break;
		case RA_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rapidAccelerationTag]];
			break;
		case RA_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rapidAccelerationTag]];
			break;
		case WK_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines walkingTag]];
			break;
		case WK_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines walkingTag]];
			break;
		case HT_LEFT_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardLeftTurnTag]];
			break;
		case HT_LEFT_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardLeftTurnTag]];
			break;
		case HT_RIGHT_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardRightTurnTag]];
			break;
		case HT_RIGHT_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines hardRightTurnTag]];
			break;
		case SPEEDING_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines speedingTag]];
			break;
		case SPEEDING_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines speedingTag]];
			break;
		case VEHICLE_ENTRY_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines vehicleEntryTag]];
			break;
		case VEHICLE_ENTRY_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines vehicleEntryTag]];
			break;
		case VEHICLE_EXIT_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines vehicleExitTag]];
			break;
		case VEHICLE_EXIT_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines vehicleExitTag]];
			break;
		case ICY_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines icyRoadTag]];
			break;
		case ICY_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines icyRoadTag]];
			break;
		case SNOW_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines snowyRoadTag]];
			break;
		case SNOW_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines snowyRoadTag]];
			break;
		case POTHOLE_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines potholeTag]];
			break;
		case POTHOLE_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines potholeTag]];
			break;
		case BAROMETRIC_CHANGE_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines barometricTag]];
			break;
		case BAROMETRIC_CHANGE_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines barometricTag]];
			break;
		case WINDOW_UP_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines windowUpTag]];
			break;
		case WINDOW_UP_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines windowUpTag]];
			break;
		case WINDOW_DOWN_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines windowDownTag]];
			break;
		case WINDOW_DOWN_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines windowDownTag]];
			break;
		case FLATTIRE_DRIVING_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines flatTireTag]];
			break;
		case FLATTIRE_DRIVING_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines flatTireTag]];
			break;
		case PHONEHANDLING_GENERIC_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingGenericTag]];
			break;
		case PHONEHANDLING_GENERIC_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingGenericTag]];
			break;
		case PHONEHANDLING_TEXT_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingTextingTag]];
			break;
		case PHONEHANDLING_TEXT_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingTextingTag]];
			break;
		case PHONEHANDLING_TALK_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingTalkingTag]];
			break;
		case PHONEHANDLING_TALK_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines phoneHandlingTalkingTag]];
			break;
		case RUMBLESTRIPS_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsTag]];
			break;
		case RUMBLESTRIPS_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsTag]];
			break;
		default:
			return nil;
	}
	
	return strMessage;
}

@end
