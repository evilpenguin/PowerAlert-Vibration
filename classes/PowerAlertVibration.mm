//
//  PowerAlertVibration.mm
//  PowerAlertVibration
//
//  Created by EvilPenguin|

#include <substrate.h>
#include <AudioToolbox/AudioToolbox.h>
#include <SpringBoard/SBLowPowerAlertItem.h>

#define POWER_ALERT_PLIST @"/var/mobile/Library/Preferences/us.nakedproductions.poweralert.plist"


HOOK(SBLowPowerAlertItem, initWithLevel$, id, unsigned level) {
	NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:POWER_ALERT_PLIST];
	BOOL value = [[plistDict objectForKey:@"powerAlert"] boolValue];
    if (value) { AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); }
	return CALL_ORIG(SBLowPowerAlertItem, initWithLevel$, level);
	[plistDict release];
}


extern "C" void PowerAlertVibrationInitialize() {	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	GET_CLASS(SBLowPowerAlertItem);
	HOOK_MESSAGE_REPLACEMENT(SBLowPowerAlertItem, initWithLevel:, initWithLevel$);	
	[pool release];
}