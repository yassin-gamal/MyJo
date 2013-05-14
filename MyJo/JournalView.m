//
//  JournalView.m
//  MyJo
//
//  Created by Yassin Gamal on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JournalView.h"
#import "QuartzCore/CALayer.h"

@implementation JournalView
@synthesize journal;
@synthesize coverImage;
@synthesize journalTitle;
@synthesize lockec;
@synthesize controller;
@synthesize deleteIcon;
@synthesize border;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"JournalPhoneView" owner:self options:nil] objectAtIndex:0]];
    }
    
    
    
    
    coverImage.layer.cornerRadius = 10;
    coverImage.clipsToBounds = YES;
    [border setHidden:YES];
    [deleteIcon setHidden:YES];

    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"JournalPhoneView" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
}



- (void)dealloc {
    [coverImage release];
    [journalTitle release];
    [lockec release];
    [border release];
    [deleteIcon release];
    [super dealloc];
}
- (IBAction)ChooseJournal:(id)sender {
    [controller setTappedJournal:journal];
    
    if(journal.password != nil)
        [controller performSegueWithIdentifier:@"lockedJournal" sender:controller];
    else [controller performSegueWithIdentifier:@"createPhoneEntry" sender:controller];

}

- (IBAction)longTap:(id)sender {
    [deleteIcon setHidden:NO];
}

- (IBAction)deleteJournal:(id)sender {
    
    UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Delete Journal" message:@"Do you really want to delete this journal? " delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //cancel clicked ...do your action
        [deleteIcon setHidden:YES];
    }
    else if (buttonIndex == 1)
    {

        [controller deleteIphoneJournalAtIndex:journal.index];

    }
}



@end
