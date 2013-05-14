//
//  CEntryPhoneViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CEntryPhoneViewController.h"
#import "FontViewController.h"
#import "RTEGestureRecognizer.h"

@interface CEntryPhoneViewController () <FontViewControllerDelegate>
- (void)edit;
- (void)edit2;
-(void)displayImagePickerWithSource:(UIImagePickerControllerSourceType)src;
@property NSInteger i;
@end

@implementation CEntryPhoneViewController 
@synthesize webEditor;
@synthesize keyboardButton;
@synthesize journalPage;
@synthesize journal;
@synthesize i;

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
    [keyboardButton setHidden:YES];
    
    
    [self registerForKeyboardNotifications];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGwoodiphone@2x.jpg"]];
    
    [self setCustomPageColor:journal.color];
    [self setCustomBackground:journal.background];
    
    [webEditor setBackgroundColor:[UIColor clearColor]];
    [webEditor setOpaque:NO];
    [webEditor.scrollView setScrollEnabled:YES];
    [webEditor.scrollView setBackgroundColor:[UIColor clearColor]];
    [webEditor.scrollView setOpaque:NO];
    
    for(UIView *wview in [[[webEditor subviews] objectAtIndex:0] subviews]) { 
        if([wview isKindOfClass:[UIImageView class]]) { wview.hidden = YES; } 
    }       
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"index" withExtension:@"html"];
    [webEditor loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('foreColor', false, '#000000')"]];
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontSize', false, '4')"]];
    
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontName', false, 'Open sans')"]];
    
    
    UIMenuItem *editMenuItem = [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(edit)];
    //    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:editMenuItem]];
    
    UIMenuItem *editMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Edit2" action:@selector(edit2)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:editMenuItem,editMenuItem2,nil]];
    
    
    RTEGestureRecognizer *tapInterceptor = [[RTEGestureRecognizer alloc] init];
    tapInterceptor.touchesBeganCallback = ^(NSSet *touches, UIEvent *event) {
        // Here we just get the location of the touch
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        // What we do here is to get the element that is located at the touch point to see whether or not it is an image
        NSString *javascript = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).toString()", touchPoint.x, touchPoint.y];
        NSString *elementAtPoint = [webEditor stringByEvaluatingJavaScriptFromString:javascript]; 
        
        if ([elementAtPoint rangeOfString:@"Image"].location != NSNotFound) {
            // We set the inital point of the image for use latter on when we actually move it
            initialPointOfImage = touchPoint;
            // In order to make moving the image easy we must disable scrolling otherwise the view will just scroll and prevent fully detecting movement on the image.            
            webEditor.scrollView.scrollEnabled = NO;
        } else {
            initialPointOfImage = CGPointZero;  
        }
    };
    
    
    
    tapInterceptor.touchesEndedCallback = ^(NSSet *touches, UIEvent *event) {
        // Let's get the finished touch point
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        // And move that image!
        NSString *javascript = [NSString stringWithFormat:@"moveImageAtTo(%f, %f, %f, %f)", initialPointOfImage.x, initialPointOfImage.x, touchPoint.x, touchPoint.y];
        [webEditor stringByEvaluatingJavaScriptFromString:javascript];
        
        // All done, lets re-enable scrolling
        webEditor.scrollView.scrollEnabled = YES;
    };
    
    
    [webEditor.scrollView addGestureRecognizer:tapInterceptor];
    
}

- (void)viewDidUnload
{
    [self setKeyboardButton:nil];
    [self setJournalPage:nil];
    [self setWebEditor:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    [self performSelector:@selector(removeBar) withObject:nil afterDelay:0];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    [keyboardButton setHidden:NO];
}

- (void)removeBar {
    // Locate non-UIWindow.
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIWebFormView.
    for (UIView *possibleFormView in [keyboardWindow subviews]) {       
        // iOS 5 sticks the UIWebFormView inside a UIPeripheralHostView.
        if ([[possibleFormView description] rangeOfString:@"UIPeripheralHostView"].location != NSNotFound) {
            for (UIView *subviewWhichIsPossibleFormView in [possibleFormView subviews]) {
                if ([[subviewWhichIsPossibleFormView description] rangeOfString:@"UIWebFormAccessory"].location != NSNotFound) {
                    [subviewWhichIsPossibleFormView removeFromSuperview];
                }
            }
        }
    }
    
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [keyboardButton setHidden:YES];
}

- (void)dealloc {
    [keyboardButton release];
    [journalPage release];
    [webEditor release];
    [super dealloc];
}

- (IBAction)pressFont:(id)sender {
    isEditAll = YES;
    
    
    UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:@"Text Editor" message:@"You have not selected any text. All changes made in the text editor will be applied to all text in this journal entry. \n If you would like to edit only part of your text select text first and tap \"Edit\" in the popup menu. "  delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alert show];
    
 
    
   
}

- (IBAction)dismissKeyboard:(id)sender {
    
    
    [webEditor endEditing:YES];
    
    
}

- (IBAction)doIt:(id)sender {
    NSString *html =     [webEditor stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    
    NSLog(@"%@",html);
    
}

-(void)setCustomBackground:(NSString*)color
{
    if(color == nil || [color isEqualToString:@"wood"])
    {
        journal.background = @"wood";
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGwoodiphone@2x.jpg"]];
        
    }else if([color isEqualToString:@"green"])
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGGreeniphone@2x.png"]];
        
    }else if([color isEqualToString:@"sun"])
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGsunburstiphone@2x.png"]];
    }
    else if([color isEqualToString:@"water"])
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGWateriPhone.png"]];
        
    }else if([color isEqualToString:@"flower"])
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGfloraliphone@2x.png"]];
        
    }
    else if([color isEqualToString:@"linen"])
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGlinneniphone@2x.jpg"]];
        
    }
    
}


-(void)setCustomPageColor:(NSString*)color
{
    if(color == nil || [color isEqualToString:@"white"])
    {
        journal.background = @"white";
        [self.journalPage setImage:[UIImage imageNamed:@"pagewhiteiphone@2x.png"]];
        
        
    }else if([color isEqualToString:@"yellow"])
    {
        [self.journalPage setImage:[UIImage imageNamed:@"pageyellowiphone@2x.png"]];
        
    }else if([color isEqualToString:@"creme"])
    {
        [self.journalPage setImage:[UIImage imageNamed:@"pagecremeiphone@2x.png"]];
    }
    else if([color isEqualToString:@"grey"])
    {
        
        [self.journalPage setImage:[UIImage imageNamed:@"pagegreyishwhiteiphone@2x.png"]];
        
    }
    
}

- (void)edit {
    isEditAll = NO;
    //    [webEditor stringByEvaluatingJavaScriptFromString:@"selectAllContent();" ];
    
    [webEditor stringByEvaluatingJavaScriptFromString:@"saveSelection();" ];
    [self performSegueWithIdentifier:@"fontPhone" sender:self];  
    
}

- (void)edit2 {
    
    [webEditor stringByEvaluatingJavaScriptFromString:@"doIt();" ];
}


-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"fontPhone"]) {
        FontViewController *controller = (FontViewController *)[segue destinationViewController];
        controller.isAll = isEditAll;
        controller.delegate = self;
    }
}

- (void)fontViewControllerDidFinish:(FontViewController *)controller fontName:(NSString *)fontName fontSize:(NSInteger) fontSize fontColor:(NSString*) fontColor  isBold:(BOOL) isBold isItalic:(BOOL) isitalic
{
    [webEditor stringByEvaluatingJavaScriptFromString:@"restoreSelection();" ];
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('foreColor', false, '%@')", fontColor]];
    
   
    
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontName', false, '%@')", fontName]];
    int actualFontSize = (fontSize / 2) - 4;
     [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('fontSize', false, '%d')", actualFontSize]];
    if(isBold)
        [webEditor stringByEvaluatingJavaScriptFromString:@"doBold();"]; 
    else
        [webEditor stringByEvaluatingJavaScriptFromString:@"doUnBold();"]; 
    if(isitalic)
        [webEditor stringByEvaluatingJavaScriptFromString:@"doItalic();"];        
    else
        [webEditor stringByEvaluatingJavaScriptFromString:@"doUnItalic();"];        
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //cancel clicked ...do your action
    }
    else if (buttonIndex == 1)
    {
        [webEditor stringByEvaluatingJavaScriptFromString:@"selectAllContent();" ];
        [webEditor stringByEvaluatingJavaScriptFromString:@"saveSelection();" ];
        [self performSegueWithIdentifier:@"fontPhone" sender:self];
    }
}


- (IBAction)insertPhoto:(id)sender {
    actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                               delegate:self 
                                      cancelButtonTitle:@"Cancel" 
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Camera",@"Photo Library", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    actionSheet.tag = 0;
    [actionSheet showInView:self.view];
    [actionSheet release];
    
//     [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"doIt();"]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet1 didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
	if (actionSheet1.tag == 0) 
    {
		// action sheet for "Select Image Source"
		switch (buttonIndex) 
        {
			case 0: // camera
				[self displayImagePickerWithSource:UIImagePickerControllerSourceTypeCamera];
				break;
			case 1: // photo library
				[self displayImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
				break;
			case 2: // cancel
			default:
				break;
		}
	} 
}

-(void) displayImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType;
{
    // sanity check to make sure we have the sourceType for the current device
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"saveSelection();"]];
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
        [imagePicker setAllowsEditing:NO];

		
        // present the UIImagePickerController as a modal view
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Obtain the path to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"photo%i.png", i]];
    
    // Extract image from the picker and save it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        image 
         image = [self resizeImage:image newSize:CGSizeMake(75, 100)];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:imagePath atomically:YES];

    }

    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreSelection();"]];
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getFocus();"]];
    
    [webEditor stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertImage', false, '%@')", imagePath]];
         

    [self dismissModalViewControllerAnimated:YES];
    i++;
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
