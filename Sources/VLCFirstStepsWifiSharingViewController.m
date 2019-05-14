/*****************************************************************************
 * VLCFirstStepsWifiSharingViewController
 * VLC for iOS
 *****************************************************************************
 * Copyright (c) 2013-2014 VideoLAN. All rights reserved.
 * $Id$
 *
 * Authors: Felix Paul Kühne <fkuehne # videolan.org>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

#import "VLCFirstStepsWifiSharingViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "VLC-Swift.h"

@implementation VLCFirstStepsWifiSharingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.connectDescriptionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"FIRST_STEPS_WIFI_CONNECT_DETAILS", nil), [[UIDevice currentDevice] model]];
    self.uploadDescriptionLabel.text = NSLocalizedString(@"FIRST_STEPS_WIFI_UPLOAD_DETAILS", nil);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:kVLCThemeDidChangeNotification object:nil];
    [self updateTheme];
    NSString *address = @"192.168.1.2"; // something generic
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = getifaddrs(&interfaces);

    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                if([@(temp_addr->ifa_name) isEqualToString:WifiInterfaceName])
                    address = @(inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr));
            }
            temp_addr = temp_addr->ifa_next;
        }
    }

    freeifaddrs(interfaces);
    self.currentAddressLabel.text = [NSString stringWithFormat:@"http://%@", address];
}

- (void)updateTheme
{
    self.connectDescriptionLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.uploadDescriptionLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.currentAddressLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.actualContentView.backgroundColor = PresentationTheme.current.colors.background;
    self.view.backgroundColor = PresentationTheme.current.colors.background;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.actualContentView.center = self.view.center;
}

- (NSString *)pageTitle
{
    return NSLocalizedString(@"WEBINTF_TITLE", nil);
}

- (NSUInteger)page
{
    return 1;
}

@end
