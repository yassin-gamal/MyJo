//
//  PasswordViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController
@synthesize delegate;
@synthesize password;
@synthesize confirmPassword;

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
    [password setDelegate:self];
    [confirmPassword setDelegate:self];
    [password setSecureTextEntry:YES];
    [confirmPassword setSecureTextEntry:YES];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"futura" size:20];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"Password";  
    self.navigationItem.titleView = label;      
    [label release];

    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPassword:nil];
    [self setConfirmPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [password release];
    [confirmPassword release];
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)savePassword:(id)sender {
    
    if(![password.text isEqualToString:confirmPassword.text])
    { 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"Passwords verification does not match the password you entered." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    else if (password.text.length < 5 || password.text.length > 12) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"Please create a 5 - 12 character password." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    else [delegate PasswordViewControllerDidFinish:self password:password.text];
}

- (IBAction)cancelPassword:(id)sender {
    [delegate PasswordViewControllerDidCancel:self];
}


@end
