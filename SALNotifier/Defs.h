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
	VEHICLE_ENTRY_START,
	VEHICLE_ENTRY_STOP,
	VEHICLE_EXIT_START,
	VEHICLE_EXIT_STOP
}NOTIFICATION_EVENTS;