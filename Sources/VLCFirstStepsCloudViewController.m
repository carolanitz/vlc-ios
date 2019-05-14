/*****************************************************************************
 * VLCFirstStepsCloudViewController
 * VLC for iOS
 *****************************************************************************
 * Copyright (c) 2013-2014 VideoLAN. All rights reserved.
 * $Id$
 *
 * Authors: Felix Paul Kühne <fkuehne # videolan.org>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

#import "VLCFirstStepsCloudViewController.h"
#import "VLC-Swift.h"

@implementation VLCFirstStepsCloudViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.uploadDescriptionLabel.text = NSLocalizedString(@"FIRST_STEPS_CLOUD_UPLOAD_DETAILS", nil);
    self.accessDescriptionLabel.text = NSLocalizedString(@"FIRST_STEPS_CLOUD_ACCESS_DETAILS", nil);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:kVLCThemeDidChangeNotification object:nil];
    [self updateTheme];
}

- (void)updateTheme
{
    self.accessDescriptionLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.uploadDescriptionLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.actualContentView.backgroundColor = PresentationTheme.current.colors.background;
    self.view.backgroundColor = PresentationTheme.current.colors.background;
}

- (NSString *)pageTitle
{
    return NSLocalizedString(@"FIRST_STEPS_CLOUDS", nil);
}

- (NSUInteger)page
{
    return 2;
}

@end
