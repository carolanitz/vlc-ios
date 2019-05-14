/*****************************************************************************
 * VLCFirstStepsiTunesSyncViewController
 * VLC for iOS
 *****************************************************************************
 * Copyright (c) 2013-2014 VideoLAN. All rights reserved.
 * $Id$
 *
 * Authors: Felix Paul Kühne <fkuehne # videolan.org>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

#import "VLCFirstStepsiTunesSyncViewController.h"
#import "VLC-Swift.h"

@implementation VLCFirstStepsiTunesSyncViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *model = [[UIDevice currentDevice] model];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        self.descriptionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"FIRST_STEPS_ITUNES_DETAILS", nil), model, model];
    else
        self.descriptionLabel.text = [[NSString stringWithFormat:NSLocalizedString(@"FIRST_STEPS_ITUNES_DETAILS", nil), model, model] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:kVLCThemeDidChangeNotification object:nil];
    [self updateTheme];
}

- (void)updateTheme
{
    self.descriptionLabel.textColor = PresentationTheme.current.colors.cellTextColor;
    self.actualContentView.backgroundColor = PresentationTheme.current.colors.background;
    self.view.backgroundColor = PresentationTheme.current.colors.background;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.actualContentView.center = self.view.center;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.actualContentView.center = self.view.center;
}

- (NSString *)pageTitle
{
    return NSLocalizedString(@"FIRST_STEPS_ITUNES", nil);
}

- (NSUInteger)page
{
    return 0;
}

@end
