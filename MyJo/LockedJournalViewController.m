//
//  LockedJournalViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LockedJournalViewController.h"

@interface LockedJournalViewController ()

@end

@implementation LockedJournalViewController
@synthesize journal;
@synthesize lockedPassword;
@synthesize  delegate;
@synthesize senderController;

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
    [self.lockedPassword setDelegate:self];
//    self.navigationItem 
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [lockedPassword release];
    [super dealloc];
}
- (IBAction)cancel:(id)sender {
    [delegate lockedViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    
    
    if ([self.lockedPassword.text isEqualToString:journal.password])
        [delegate lockedViewControllerDidFinish:self withJournal:journal];

    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Password" message:@"the password you typed is wrong, please try again" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
        [alert show];
    }
    
}
@end
