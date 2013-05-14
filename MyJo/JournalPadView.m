//
//  JournalPadView.m
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JournalPadView.h"
#import "QuartzCore/CALayer.h"

@implementation JournalPadView
@synthesize coverImage;
@synthesize journalTitle;
@synthesize locked;
@synthesize journal;
@synthesize controller;
@synthesize border;
@synthesize deleteIcon;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"JournalPadView" owner:self options:nil] objectAtIndex:0]];
    }
    
    
    coverImage.layer.cornerRadius = 10;
    coverImage.clipsToBounds = YES;
    [border setHidden:YES];
    [deleteIcon setHidden:YES];
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [coverImage release];
    [journalTitle release];
    [locked release];
    [border release];
    [deleteIcon release];
    [super dealloc];
}
- (IBAction)chooseJournal:(id)sender {
     [controller setTappedJournal:journal];
        if(journal.password != nil)
     [controller performSegueWithIdentifier:@"lockedPasswordPad" sender:controller];
    
}

- (IBAction)longTap:(id)sender {
    [deleteIcon setHidden:NO];

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
        
        [controller deleteIpadJournalAtIndex:journal.index];
        
    }
}

-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"lockedPasswordPad"]) {

        
    }
}


- (IBAction)deleteJournal:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Delete Journal" message:@"Do you really want to delete this journal? " delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}
@end



