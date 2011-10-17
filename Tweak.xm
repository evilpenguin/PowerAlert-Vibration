/*
 * Tweak: PowerAlert Vibration
 * Version: 2.0
 * Created by EvilPenguin
 *
 * Enjoy :0)
 */

#import <AudioToolbox/AudioToolbox.h>

#define POWER_ALERT_PLIST @"/var/mobile/Library/Preferences/us.nakedproductions.poweralert.plist"
#define listenToNotification$withCallBack(notification, callback); CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)&callback, CFSTR(notification), NULL, CFNotificationSuspensionBehaviorHold);

static BOOL isEnabled;
static void loadSettings(void) {
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:POWER_ALERT_PLIST];
	isEnabled = [plistDict objectForKey:@"PowerAlertEnabled"] ? [[plistDict objectForKey:@"PowerAlertEnabled"] boolValue] : NO;
	[plistDict release];
}

#pragma mark -
#pragma mark == SBLowPowerAlertItem ==

%hook SBLowPowerAlertItem
- (id)initWithLevel:(unsigned)level {
	if (isEnabled) AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	return %orig(level);
}
%end

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	listenToNotification$withCallBack("com.understruction.lockvibe.update", loadSettings);
	loadSettings();
	[pool drain];
}