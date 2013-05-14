//
//  LockedJournalPadViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LockedJournalPadViewController.h"

@interface LockedJournalPadViewController ()

@end

@implementation LockedJournalPadViewController
@synthesize  delegate;
@synthesize lockedPassword;
@synthesize journal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [lockedPassword setSecureTextEntry:YES];
    [lockedPassword setDelegate:self];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLockedPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:journal.title message:journal.password delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
    [alert show];
    
    return YES;
}

- (void)dealloc {
    [lockedPassword release];
    [super dealloc];
}
- (IBAction)cancel:(id)sender {
    [delegate didCancel:self];
}






@end
