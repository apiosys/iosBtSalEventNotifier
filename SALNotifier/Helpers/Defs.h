/*
//  Defs.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 1/12/15.
//  Copyright (c) 2015 Apio Systems. All rights reserved.
*/

#pragma once

typedef enum
{
	HB_START,
	HB_STOP,
	RA_START,
	RA_STOP,
	WK_START,
	WK_STOP,
	HT_LEFT_START,
	HT_LEFT_STOP,
	HT_RIGHT_START,
	HT_RIGHT_STOP,
	SPEEDING_START,
	SPEEDING_STOP,
	RSL_START,
	RSL_STOP,
	RSR_START,
	RSR_STOP,
	ABD_START,
	ABD_STOP,
	ABP_START,
	ABP_STOP,
	DS_START,
	DS_STOP,
	LCL_START,
	LCL_STOP,
	LCR_START,
	LCR_STOP,
	
	ICY_STOP,
	ICY_START,
	SNOW_STOP,
	SNOW_START,

	POTHOLE_STOP,
	POTHOLE_START,

	BAROMETRIC_CHANGE_STOP,
	BAROMETRIC_CHANGE_START,

	WINDOW_UP_STOP,
	WINDOW_UP_START,

	WINDOW_DOWN_STOP,
	WINDOW_DOWN_START,

	FLATTIRE_DRIVING_STOP,
	FLATTIRE_DRIVING_START,

	PHONEHANDLING_GENERIC_STOP,
	PHONEHANDLING_GENERIC_START,

	PHONEHANDLING_TEXT_STOP,
	PHONEHANDLING_TEXT_START,

	PHONEHANDLING_TALK_STOP,
	PHONEHANDLING_TALK_START,

	VEHICLE_ENTRY_START,
	VEHICLE_ENTRY_STOP,
	VEHICLE_EXIT_START,
	VEHICLE_EXIT_STOP
}NOTIFICATION_EVENTS;