//
//  CjPhoneViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CjPhoneViewController.h"
#import "PasswordViewController.h"
#import "ColorsViewController.h"
#import "BackgroundsViewController.h"
#import "QuartzCore/CALayer.h"

@interface CjPhoneViewController () <PasswordViewControllerDelegate,ColorsViewControllerDelegate,BackgroundViewControllerDelegate>
-(void)displayImagePickerWithSource:(UIImagePickerControllerSourceType)src;
-(BOOL) checkJournalTitle;
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize ;
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize ;
@end



@implementation CjPhoneViewController
@synthesize defaultColor;
@synthesize defaultBackground;
@synthesize delegate;
@synthesize journalTitle;
@synthesize coverImage;
@synthesize journal;
@synthesize journalTitleLabel;
@synthesize coverImageDescription;
@synthesize passwordSwitch;
@synthesize validator;
@synthesize password;
@synthesize journalCover;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.journalTitle setDelegate:self];
    
    self.defaultColor = @"white";
    self.defaultBackground = @"wood";
    journalCover = [coverImage  imageForState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"helvetica-Neue" size:21];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"Create journal";  
    self.navigationItem.titleView = label;      
    [label release];
    
    validator = [[Validator alloc]init];
    
    coverImage.layer.cornerRadius = 10;
    coverImage.clipsToBounds = YES;
    
}

- (void)viewDidUnload
{
    
    [self setCoverImage:nil];
    [self setJournalTitle:nil];
    [self setJournalTitleLabel:nil];
    [self setCoverImageDescription:nil];
    [self setPasswordSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void) displayImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType;
{
    // sanity check to make sure we have the sourceType for the current device
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        // create a new UIImagePickerController with appropriate sourceType (i.e. Camera or Photo Library)
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
        //		imagePicker.view.frame = CGRectMake(0, 0, 180, 180);
        // 3.0/3.1 allowsEditing compatibility for API change
		NSString *key = @"allowsEditing";
		if ([imagePicker respondsToSelector:@selector(setAllowsImageEditing:)]) {
			key = @"allowsImageEditing";
		}
		[imagePicker setValue:[NSNumber numberWithBool:YES] forKey:key];
		
        // present the UIImagePickerController as a modal view
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // dismiss the modal image picker view
    [self dismissModalViewControllerAnimated:YES];
	
    // create a unique ID to use as the image key
	CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef	newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
    // store the image in the ImageCache with the key
	UIImage *croppedImage = [[info objectForKey:UIImagePickerControllerEditedImage] retain];
    
    
    //Compress image
    //    croppedImage = [self scaleImage:img toSize:CGSizeMake(612.0,612.0)];
    //    croppedImage 
    
    //assume that the image is loaded in landscape mode from disk
    //    UIImage * PortraitImage = croppedImage;
    //    UIImage * LandscapeImage = [[UIImage alloc] initWithCGImage: PortraitImage.CGImage
    //                                                         scale: 1.0
    //                                                   orientation: UIImageOrientationLeft];
       croppedImage = [self resizeImage:croppedImage newSize:CGSizeMake(180, 180)];
    [coverImage setImage:croppedImage forState:UIControlStateNormal];

    journalCover = croppedImage;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"passwordForm"]) {
        PasswordViewController *passwordController = (PasswordViewController *)[segue destinationViewController];
        passwordController.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"colorForm"]) {
        ColorsViewController *controller = (ColorsViewController *)[segue destinationViewController];
        controller.delegate = self;
        
    }else  if ([[segue identifier] isEqualToString:@"backgroundForm"]) {
        BackgroundsViewController *controller = (BackgroundsViewController *)[segue destinationViewController];
        controller.delegate = self;
        
    }
    
    
}

- (void)dealloc {
    
    [coverImage release];
    [journalTitle release];
    [journalTitleLabel release];
    [coverImageDescription release];
    [passwordSwitch release];
    [super dealloc];
}
- (IBAction)chooseCover:(id)sender {
    [self displayImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {  
    [self checkJournalTitle];
    
    
}

- (IBAction)switchTriggered:(id)sender {
    if ([passwordSwitch isOn])
        [self performSegueWithIdentifier:@"passwordForm" sender:self];
}

- (IBAction)doSave:(id)sender {
    if([self checkJournalTitle])
    {
        if([passwordSwitch isOn])
            journal = [[Journal alloc]initWithTitle:journalTitle.text password:password color:defaultColor background:defaultBackground cover:journalCover];
        else 
            journal = [[Journal alloc]initWithTitle:journalTitle.text color:defaultColor background:defaultBackground cover:journalCover];
        [delegate cJViewControllerDidFinish:self journal:journal];
    };
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
        [delegate cJViewControllerDidCancel:self];
    }
}



- (void)PasswordViewControllerDidCancel:(PasswordViewController *)controller
{
    
    [self.navigationController popToViewController:self animated:YES];
    [passwordSwitch setOn:NO animated:YES];
    
}
- (void)PasswordViewControllerDidFinish:(PasswordViewController *)controller password:(NSString *)password1
{
    
    [self.navigationController popToViewController:self animated:YES];
    self.password = password1;
    
}
- (void)backgroundViewControllerDidCancel:(BackgroundsViewController *)controller
{
    [self.navigationController popToViewController:self animated:YES];
}
- (void)backgroundViewControllerDidFinish:(BackgroundsViewController *)controller background:(NSString *)color
{
    self.defaultBackground = color;
    [self.navigationController popToViewController:self animated:YES];
}

- (void)colorsViewControllerDidCancel:(ColorsViewController *)controller
{
    [self.navigationController popToViewController:self animated:YES];
}
- (void)colorsViewControllerDidFinish:(ColorsViewController *)controller color:(NSString *)color
{
    self.defaultColor = color;
    [self.navigationController popToViewController:self animated:YES];
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
@end
