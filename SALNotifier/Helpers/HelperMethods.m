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


+(double)celciusToFahrenheit:(double)dCelcius
{
	//Degrees Fahrenheit (°F) is equal to the Degrees Celsius (°C) * 9/5 plus 32:
	return (dCelcius * 9.0) / 5.0 + 32;
}

+(double)fahrenheitToCelcius:(double)dFahrenheit
{
	//Degrees Celsius (°C) is equal to the Degrees Fahrenheit (°F) minus 32, times 5/9:
	return (dFahrenheit - 32.0) * (5.0/9.0);
}

+(BOOL)stringToDouble:(NSString *)strVal derivedDoubleValue:(double *)dVal
{
	BOOL bStat = TRUE;
	
	double dCalcVal = 0.0;
	
	if( (strVal == nil) || (strVal.length <= 0) )
		return FALSE;
	
	@try
	{
		strVal = [strVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		strVal = [strVal stringByReplacingOccurrencesOfString:@" " withString:@""];
		
		NSScanner* scan = [NSScanner scannerWithString:strVal];
		
		bStat &= ([scan scanDouble:&dCalcVal] && [scan isAtEnd]);
		bStat &= (dCalcVal > 0.0);
	}//End try
	@catch(NSException *exception)
	{
		dCalcVal = 0.0;
		bStat = FALSE;
		NSLog(@"Exception in \"stringToInt\" - %@", exception.debugDescription);
	}//End catch
	
	*dVal = dCalcVal;
	
	return bStat;
}//End

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
		case RSL_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsLeftTag]];
			break;
		case RSL_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsLeftTag]];
			break;
		case RSR_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsRightTag]];
			break;
		case RSR_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines rumbleStripsRightTag]];
			break;
		case ABD_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines airbagDriverTag]];
			break;
		case ABD_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines airbagDriverTag]];
			break;
		case ABP_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines airbagPassengerTag]];
			break;
		case ABP_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines airbagPassengerTag]];
			break;
		case DS_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines doorSlamTag]];
			break;
		case DS_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines doorSlamTag]];
			break;
		case LCL_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines laneChangeLeftTag]];
			break;
		case LCL_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines laneChangeLeftTag]];
			break;
		case LCR_START:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines startEventTag], [ConstantDefines messageDelimiter], [ConstantDefines laneChangeRightTag]];
			break;
		case LCR_STOP:
			strMessage = [NSString stringWithFormat:@"%@%@%@", [ConstantDefines endEventTag], [ConstantDefines messageDelimiter], [ConstantDefines laneChangeRightTag]];
			break;
		default:
			return nil;
	}
	
	return strMessage;
}

@end
