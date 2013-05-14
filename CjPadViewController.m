//
//  CjPadViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CjPadViewController.h"
#import "QuartzCore/CALayer.h"

@interface CjPadViewController ()
-(void)displayImagePickerWithSource:(UIImagePickerControllerSourceType)src;
-(BOOL) checkJournalTitle;
-(BOOL) checkPassword;
-(BOOL) checkConfirmPassword;
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize ;
@end

@implementation CjPadViewController
@synthesize passwordValue;
@synthesize journalCover;
@synthesize myScroll;
@synthesize cjDelegate;
@synthesize journal;
@synthesize wood;
@synthesize linen;
@synthesize green;
@synthesize sun;
@synthesize water;
@synthesize flower;
@synthesize toolbar;
@synthesize coverImage;
@synthesize popoverController;
@synthesize journalTitle;
@synthesize password;
@synthesize confirmPass;
@synthesize white;
@synthesize creme;
@synthesize grey;
@synthesize yellow;
@synthesize lastColor;
@synthesize lastBackground;
@synthesize validator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [password setSecureTextEntry:YES];
    [confirmPass setSecureTextEntry:YES];
    validator = [[Validator alloc]init];
    
    [self  registerForKeyboardNotifications];
    
    defaultColor = @"white";
    defaultBackground = @"wood";
    defaultColor = @"white";
    defaultBackground = @"wood";
    journalCover = [coverImage  imageForState:UIControlStateNormal];
    hasPassword = NO;
    
    
    journalTitle.delegate = self;
    password.delegate = self;
    confirmPass.delegate = self;
    
    coverImage.layer.cornerRadius = 10;
    coverImage.clipsToBounds = YES;

    
    [white setImage:[UIImage imageNamed:@"swatch-white-select.png"] forState:UIControlStateSelected];
    [grey setImage:[UIImage imageNamed:@"swatch-greyish-select.png"] forState:UIControlStateSelected];
    [yellow setImage:[UIImage imageNamed:@"swatch-yellowish-select.png"] forState:UIControlStateSelected];
    [creme setImage:[UIImage imageNamed:@"swatch-creme-select.png"] forState:UIControlStateSelected];
    
    
    [wood setImage:[UIImage imageNamed:@"BGwood70-select.png"] forState:UIControlStateSelected];
    [linen setImage:[UIImage imageNamed:@"BGlinnen70-select.png"] forState:UIControlStateSelected];
    [green setImage:[UIImage imageNamed:@"BGgreen70-select.png"] forState:UIControlStateSelected];
    [sun setImage:[UIImage imageNamed:@"BGsuburst70-select.png"] forState:UIControlStateSelected];
    [water setImage:[UIImage imageNamed:@"BGwater70-select.png"] forState:UIControlStateSelected];
    [flower setImage:[UIImage imageNamed:@"BGfloral70-select.png"] forState:UIControlStateSelected];
    
    [white setSelected:YES];
    lastColor = white;
    
    [wood setSelected:YES];
    lastBackground = wood;
    
}

- (void)viewDidUnload
{
    [self setCoverImage:nil];
    [self setJournalTitle:nil];
    [self setPassword:nil];
    [self setConfirmPass:nil];
    [self setWhite:nil];
    [self setCreme:nil];
    [self setGrey:nil];
    [self setYellow:nil];
    [self setWood:nil];
    [self setLinen:nil];
    [self setGreen:nil];
    [self setSun:nil];
    [self setWater:nil];
    [self setFlower:nil];
    [self setToolbar:nil];
    [self setMyScroll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [coverImage release];
    [journalTitle release];
    [password release];
    [confirmPass release];
    [white release];
    [creme release];
    [grey release];
    [yellow release];
    [wood release];
    [linen release];
    [green release];
    [sun release];
    [water release];
    [flower release];
    [toolbar release];
    [myScroll release];
    [super dealloc];
}



-(void) displayImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType;
{
	UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    [imagePicker setAllowsEditing:YES];
    //    imagePicker setm
    
    //    imagePicker.allowsEditing = YES;
    // 3.0/3.1 allowsEditing compatibility for API change
    
    
    self.popoverController = [[UIPopoverController alloc]
                              initWithContentViewController:imagePicker];
    
    
    
    
    popoverController.delegate = self;
    
    [self.popoverController presentPopoverFromRect:CGRectMake(75, 30, 100, 100) inView:coverImage permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    [imagePicker release];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// dismiss the modal image picker view
    [self.popoverController dismissPopoverAnimated:YES];
    
	
	// create a unique ID to use as the image key
	CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef	newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
	// store the image in the ImageCache with the key
	UIImage *croppedImage = [[info objectForKey:UIImagePickerControllerEditedImage] retain];
    
    croppedImage = [self resizeImage:croppedImage newSize:CGSizeMake(180, 180)];
    

    [coverImage setImage:croppedImage forState:UIControlStateNormal];
    
    journalCover = croppedImage;
}


- (IBAction)chooseCover:(id)sender {
    [self displayImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

- (IBAction)clearCover:(id)sender {
    [coverImage setImage:[UIImage imageNamed:@"photo160.png"] forState:UIControlStateNormal];
}

- (IBAction)pressWhite:(id)sender {
    [lastColor setSelected:FALSE];
    [white setSelected:YES];
    lastColor = white;
    defaultColor = @"white";
    
}

- (IBAction)pressCreme:(id)sender {
    [lastColor setSelected:FALSE];
    [creme setSelected:YES];
    lastColor = creme;
    defaultColor = @"creme";
}

- (IBAction)pressGrey:(id)sender {
    [lastColor setSelected:FALSE];
    [grey setSelected:YES];
    lastColor = grey;
    defaultColor = @"grey";
}

- (IBAction)pressYellow:(id)sender {
    [lastColor setSelected:FALSE];
    [yellow setSelected:YES];
    lastColor = yellow;
    defaultColor = @"yellow";
}

- (IBAction)wood:(id)sender {
    [lastBackground setSelected:FALSE];
    [wood setSelected:YES];
    lastBackground = wood;
    defaultBackground = @"wood";
}  

- (IBAction)linen:(id)sender {
    [lastBackground setSelected:FALSE];
    [linen setSelected:YES];
    lastBackground = linen;
    defaultBackground = @"linen";
}

-  (IBAction)green:(id)sender {
    [lastBackground setSelected:FALSE];
    [green setSelected:YES];
    lastBackground = green;
    defaultBackground = @"green";
}

- (IBAction)sun:(id)sender {
    [lastBackground setSelected:FALSE];
    [sun setSelected:YES];
    lastBackground = sun;
    defaultBackground = @"sun";
}

- (IBAction)water:(id)sender {
    [lastBackground setSelected:FALSE];
    [water setSelected:YES];
    lastBackground = water;
    defaultBackground = @"water";
}

- (IBAction)floral:(id)sender {
    [lastBackground setSelected:FALSE];
    [flower setSelected:YES];
    lastBackground = flower;
    defaultBackground = @"flower";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {  
    
    if(textField == journalTitle)
        [self checkJournalTitle];
    else if (textField == password)
        [self checkPassword];
    else if (textField == confirmPass)
        [self checkConfirmPassword];
    
    
}


- (void) textFieldDidBeginEditing:(UITextField *)textField {  
    [self.myScroll setScrollEnabled:YES];
    [self.myScroll setScrollsToTop:NO];
    
}



-(BOOL) checkJournalTitle {
    if([validator isBlankTitle:journalTitle.text])
    {
        UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Invalid Journal title" message:@"Please enter a max. 18 positions title." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    else if([validator isLongTitle:journalTitle.text])
    {
        UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Invalid Journal title" message:@"The journal title is too long. Please enter a max. 18 positions title." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
    
}

-(BOOL) checkPassword {
    if ((password.text.length < 5 && password.text.length > 0)|| password.text.length > 12) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"Please create a 5 - 12 character password." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
        return NO;
    }
    
    return YES;
    
}
-(BOOL) checkConfirmPassword {
    if(![password.text isEqualToString:confirmPass.text])
    { 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"Passwords verification does not match the password you entered." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
        return NO;
        
    }    return YES;
    
}

- (IBAction)doSave:(id)sender {
    
    if([self checkJournalTitle])
    {
        if(![password.text isEqualToString:@""] || ![confirmPass.text isEqualToString:@""])
        {
            if([self checkPassword] && [self checkConfirmPassword])
            {
                journal = [[Journal alloc]initWithTitle:journalTitle.text password:password.text color:defaultColor background:defaultBackground cover:journalCover];
                
                [cjDelegate cJPadViewControllerDidFinish:self journal:journal];
            }
            
        }
        else 
        {
            journal = [[Journal alloc]initWithTitle:journalTitle.text color:defaultColor background:defaultBackground cover:journalCover];
            
            
            [cjDelegate cJPadViewControllerDidFinish:self journal:journal];
        }
        
    }
}

- (IBAction)doCancel:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Cancel create journal" message:@"Do you really want to cancel? Tap NO to continue creating your new journal. Tap YES to cancel, your settings will not be saved." delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //cancel clicked ...do your action
    }
    else if (buttonIndex == 1)
    {
        [cjDelegate cJPadViewControllerDidCancel:self];
    }
}


- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);  
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();    
    
    return newImage;
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height  - 300, 0.0);
    self.myScroll.contentInset = contentInsets;
    self.myScroll.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//        [self.myScroll setContentOffset:scrollPoint animated:YES];
//    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myScroll.contentInset = contentInsets;
    self.myScroll.scrollIndicatorInsets = contentInsets;
}

@end
