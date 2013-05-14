//
//  OpenAppViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenAppViewController.h"
#import "CjPhoneViewController.h"
#import "CustomPopoverBackgroundView.h"
#import "CjPadViewController.h"
#import "JournalView.h"
#import "JournalPadView.h"
#import "LockedJournalViewController.h"
#import "LockedJournalPadViewController.h"
#import "AppBackgroundViewController.h"
#import "PadAppearanceViewController.h"
#import "QuartzCore/CAAnimation.h"
#import "QuartzCore/CAMediaTimingFunction.h"
#import "CEntryPhoneViewController.h"







@class CjPadViewController;
@class CjPhoneViewController;
@interface OpenAppViewController () <CjPhoneViewController,CjPadViewController,LockedViewControllerDelegate,LockedPadViewControllerDelegate,AppBackgroundViewControllerDelegate,PadAppearanceViewController>

-(void)saveJournal:(Journal*)Journal;
-(void)deleteJournal:(NSInteger)index;
-(void)dispalyIphoneJournal:(Journal*)Journal;
-(void)dispalyIpadJournal1:(Journal*)journal1 journal2:(Journal*)journal2;
-(void) displayOneAvailableJournal:(Journal*) journal;
-(void)emptyView:(UIView*)view;
-(void)setCustomBackground:(NSString*)color;
-(void)animateLeft;
- (void)animateRight;
-(void) showPop;
-(void) adjustIndecies;

@end

@implementation OpenAppViewController
@synthesize background;
@synthesize twoJournalView;
@synthesize landscapeAnchor;
@synthesize formIpad;
@synthesize addImage;
@synthesize firstAvaialbeJournal;
@synthesize secondAvaiableJournal;
@synthesize oneAvaialbeJournal;
@synthesize myView;
@synthesize addToolbarButton;
@synthesize avaialbeJournal;
@synthesize myPageControl;
@synthesize journals;
@synthesize tappedJournal;
@synthesize appearance;
@synthesize scrollPop;
@synthesize anchor;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) toolbarForPad{
    // create a toolbar to have two buttons in the right
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 133, 44.01)];
    
    [tools setBackgroundColor:[UIColor clearColor]];
    
    
    // create the array to hold the buttons, which then gets added to the toolbar
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    // create a standard "add" button
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithImage:[UIImage imageNamed:@"helpcontact.png"] landscapeImagePhone:[UIImage imageNamed:@"helpcontact.png"] style:UIBarButtonItemStylePlain target:self action:NULL ];
    bi.style = UIBarButtonItemStylePlain;
    
    [buttons addObject:bi];
    [bi release];
    
    
    
    // create a standard "refresh" button
    bi = [[UIBarButtonItem alloc]
          initWithImage:[UIImage imageNamed:@"app settings.png"] landscapeImagePhone:[UIImage imageNamed:@"app settings.png"] style:UIBarButtonItemStylePlain target:self action:NULL ];  
    [buttons addObject:bi];
    [bi release];
    
    // create a standard "refresh" button
    bi = [[UIBarButtonItem alloc]
          initWithImage:[UIImage imageNamed:@"add.png"] landscapeImagePhone:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarAdd:) ];  
    [buttons addObject:bi];
    [bi release];
    
    // stick the buttons in the toolbar
    [tools setItems:buttons animated:NO];
    
    [buttons release];
    
    // and put the toolbar in the nav bar
    self.navigationItem.rightBarButtonItems = tools.items;
    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    deviceType = [UIDevice currentDevice].model;
    //    if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ])
    //        [self toolbarForPad];
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(pop)];
//    self.navigationItem.backBarButtonItem = barBtnItem;
//    [barBtnItem release];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Pacifico" size:24.0];

    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"myjo";  
    self.navigationItem.titleView = label;      
    [label release];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"journals"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    self.journals = arr;
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    [journals removeLastObject];
    //    
    //    arr = self.journals ; // set value
    //    data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    //    [defaults setObject:data forKey:@"journals"];
    //    [defaults synchronize];
    
    [self setBackground:[defaults objectForKey:@"AppBackground"]];
    [self setCustomBackground:background];
    
    
    if (journals != nil && journals.count > 0)
    {
        [addImage setHidden:YES];
        Journal* journal = [journals objectAtIndex:0];
        currentPairJournal = 0 ;
        currentJournal = 0;
        if([deviceType isEqualToString:@"iPhone"] || [deviceType isEqualToString:@"iPhone Simulator" ])
        {
            
            [myPageControl setNumberOfPages:journals.count];
            
            JournalView* subview =  [[JournalView alloc]initWithFrame:CGRectMake(0, 0, self.avaialbeJournal.frame.size.width, self.avaialbeJournal.frame.size.height)];
            [subview.coverImage setImage:journal.coverImage];
            
            subview.journal = journal;
            subview.controller = self;
            subview.journalTitle.text = journal.title;
            if(journal.password == Nil)
                [subview.lockec setHidden:YES];
            
            [self emptyView:avaialbeJournal];
            [self.avaialbeJournal addSubview:subview];
            [subview release];
        }
        else {
            [myPageControl setNumberOfPages:((journals.count + 1) / 2)];
            if(journals.count == 1)
            {
                JournalPadView *subview = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.oneAvaialbeJournal.frame.size.width, self.oneAvaialbeJournal.frame.size.height)];
                [subview.coverImage setImage:journal.coverImage];
                
                subview.journal = journal;
                subview.controller = self;
                subview.journalTitle.text = journal.title;
                if(journal.password == Nil)
                    [subview.locked setHidden:YES];
                
                [self emptyView:oneAvaialbeJournal];
                
                [self.oneAvaialbeJournal addSubview:subview];
                [subview release];
                
                
            }else if(journals.count > 1){
                Journal* journal2 = [journals objectAtIndex:1];
                JournalPadView *subview1 = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.firstAvaialbeJournal.frame.size.width, self.firstAvaialbeJournal.frame.size.height)];
                
                
                JournalPadView *subview2 = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.secondAvaiableJournal.frame.size.width, self.secondAvaiableJournal.frame.size.height)];
                
                subview1.journal = journal;
                subview1.controller = self;
                subview2.journal = journal2;
                subview2.controller = self;
                
                [subview1.coverImage setImage:journal.coverImage];
                [subview2.coverImage setImage:journal2.coverImage];
                subview1.journalTitle.text = journal.title;
                subview2.journalTitle.text = journal2.title;
                if(journal.password == Nil)
                    [subview1.locked setHidden:YES];
                if(journal2.password == Nil)
                    [subview2.locked setHidden:YES];
                [self emptyView:firstAvaialbeJournal];
                [self emptyView:secondAvaiableJournal];
                
                
                [self.firstAvaialbeJournal addSubview:subview1];
                [self.secondAvaiableJournal addSubview:subview2];
                [subview1 release];
                [subview2 release];
                
                
            }
        }
    }else { //there are no journals
        [myPageControl setNumberOfPages:0];
        
        self.journals = [[NSMutableArray alloc] init];
        
        
        
    }
}

- (void)viewDidUnload
{
    [self setMyView:nil];
    [self setMyPageControl:nil];
    [myPageControl release];
    
    
    
    [self setAddToolbarButton:nil];
    [self setAddImage:nil];
    [self setAvaialbeJournal:nil];
    [self setFirstAvaialbeJournal:nil];
    [self setSecondAvaiableJournal:nil];
    [self setOneAvaialbeJournal:nil];
    [self setTwoJournalView:nil];
    [self setLandscapeAnchor:nil];
    [self setScrollPop:nil];
    [self setAnchor:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.pageControlBeingUsed
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([deviceType isEqualToString:@"iPhone"] || [deviceType isEqualToString:@"iPhone Simulator" ])
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    else
        return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    
    if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ])
    {
        
        
        if ([self formIpad] != nil)
        {
            if ([formIpad isPopoverVisible])
                [formIpad presentPopoverFromRect:anchor.frame inView:self.myView permittedArrowDirections:0 animated:YES];
        }
        
        
        [self setCustomBackground:background];
        
    }
    
    
    
}



- (void)dealloc {
    [myView release];
    [myPageControl release];
    [myPageControl release];
    
    
    [addToolbarButton release];
    [addImage release];
    [avaialbeJournal release];
    [firstAvaialbeJournal release];
    [secondAvaiableJournal release];
    [oneAvaialbeJournal release];
    [twoJournalView release];
    [landscapeAnchor release];
    [scrollPop release];
    [anchor release];
    [super dealloc];
}







- (IBAction)tapAddImage:(id)sender {
    
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                              delegate:self 
                                     cancelButtonTitle:@"Cancel" 
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Add New Jounal", @"MyJo backup", nil];
    
    actionSheet.tag = 0;
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    //    [actionSheet showInView:addImage];
    [actionSheet showFromRect:CGRectMake(addImage.frame.size.width / 120.0, 0 ,addImage.frame.size.width, addImage.frame.size.width) inView:addImage animated:YES];
    [actionSheet release];
    
}

- (IBAction)toolbarAdd:(id)sender {
    if (appearance != nil)
        if([self.appearance isPopoverVisible])
        {
            [appearance dismissPopoverAnimated:NO];
            appearance = nil;
        }
    
    if (actionSheet != nil){
        [actionSheet dismissWithClickedButtonIndex:[actionSheet cancelButtonIndex] animated:NO];
        actionSheet = nil;
    }
    
    
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                              delegate:self 
                                     cancelButtonTitle:@"Cancel" 
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Add New Jounal", @"MyJo backup", nil];
    
    actionSheet.tag = 0;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
    
}


- (IBAction)manageApp:(id)sender {
    
    
    if (appearance != nil)
        if([self.appearance isPopoverVisible])
        {
            [self dismissModalViewControllerAnimated:YES];
            appearance = nil;
        }
    
    
    if (actionSheet != nil){
        [actionSheet dismissWithClickedButtonIndex:[actionSheet cancelButtonIndex] animated:NO];
        actionSheet = nil;
    }
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                              delegate:self 
                                     cancelButtonTitle:@"Cancel" 
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Appearance", @"Sync", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = 1;
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
    [actionSheet release];
    
}



-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"formIpad"]){
        formIpad = [(UIStoryboardPopoverSegue *)segue popoverController];
        
        formIpad.delegate = (id <UIPopoverControllerDelegate>)self;
        
        CjPadViewController *controller = (CjPadViewController *)[segue destinationViewController];
        controller.cjDelegate = self;
        
        formIpad.popoverBackgroundViewClass = [CustomPopoverBackgroundView class];
        //        [formIpad setPopoverContentSize:CGSizeMake(600  , 681)];
        [formIpad setPopoverLayoutMargins:UIEdgeInsetsMake(0, 0, -20, 0 )];
        
        
        
    }else  if ([[segue identifier] isEqualToString:@"formIphone"]) {
        CjPhoneViewController *controller = (CjPhoneViewController *)[segue destinationViewController];
        
        controller.delegate = self;
    }  
    else  if ([[segue identifier] isEqualToString:@"lockedJournal"]) {
        LockedJournalViewController *controller = (LockedJournalViewController *)[segue destinationViewController];
        controller.journal = tappedJournal;
        controller.delegate = self;
        [controller setSenderController:self];
    }
    else  if ([[segue identifier] isEqualToString:@"lockedPasswordPad"]) {
        LockedJournalPadViewController *controller = (LockedJournalPadViewController *)[segue destinationViewController];
        controller.journal = tappedJournal;
       
//        controller 
        controller.delegate = self;
    }else  if ([[segue identifier] isEqualToString:@"appBackground"]) {
        AppBackgroundViewController *controller = (AppBackgroundViewController *)[segue destinationViewController];
        controller.currentBackground = background;
        //         [controller prepareViewController];
        controller.delegate = self;
    }else  if ([[segue identifier] isEqualToString:@"padAppearance"]) {
        PadAppearanceViewController *controller = (PadAppearanceViewController *)[segue destinationViewController];
        controller.currentBackground = background;
        [controller prepareViewController];
        appearance = [(UIStoryboardPopoverSegue *)segue popoverController];
        controller.backDelegate = self;
        
    }else if([[segue identifier] isEqualToString:@"createPhoneEntry"])
    {
        CEntryPhoneViewController *controller = (CEntryPhoneViewController *) [segue destinationViewController];
        controller.journal = tappedJournal;
        
    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet1 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(actionSheet1.tag == 0)
    {
        switch (buttonIndex) 
        {
            case 0: // New Journal
                if([deviceType isEqualToString:@"iPhone"] || [deviceType isEqualToString:@"iPhone Simulator" ]) {
                    [self performSegueWithIdentifier:@"formIphone" sender:self];                
                }
                else if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ]) {
                    [self performSegueWithIdentifier:@"formIpad" sender:self];  
                    //                    [self showPop];
                }
                
                break;
            case 1: // Backup Journal
                
                break;
            case 2: // cancel
            default:
                break;
        }
        
    }
    else if (actionSheet1.tag == 1)
    {
        switch (buttonIndex) 
        {
            case 0: // Appeareance 
                if([deviceType isEqualToString:@"iPhone"] || [deviceType isEqualToString:@"iPhone Simulator" ]) {
                    [self performSegueWithIdentifier:@"appBackground" sender:self];                
                }
                else if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ]) {
                    [self performSegueWithIdentifier:@"padAppearance" sender:self];
                    
                    
                }
                break;
            case 1: // sync
                
                break;
            case 2: // cancel
            default:
                break;
        }
        
    }
    
    actionSheet = nil;
	
}




- (void)cJViewControllerDidCancel:(CjPhoneViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cJViewControllerDidFinish:(CjPhoneViewController *)controller journal:(Journal *)journal
{
    [self saveJournal:journal];
    currentJournal = journals.count - 1;
    if(currentJournal == 0)
        [addImage setHidden:YES];
    
    [myPageControl setNumberOfPages:journals.count];
    [myPageControl setCurrentPage:currentJournal];    
    
    
    [self dispalyIphoneJournal:journal];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveJournal:(Journal*)journal
{
    [journal setIndex:journals.count];
    [journals addObject:journal];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = self.journals ; // set value
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [defaults setObject:data forKey:@"journals"];
    [defaults synchronize];
    
}

- (void)cJPadViewControllerDidCancel:(CjPadViewController *)controller
{
    [formIpad dismissPopoverAnimated:YES];
    formIpad = nil;
}
- (void)cJPadViewControllerDidFinish:(CjPadViewController *)controller journal:(Journal *)journal
{
    [self saveJournal:journal];
    NSInteger pastSize = journals.count - 1;
    
    if(pastSize == 0)
    {
        JournalPadView *subview1 = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.oneAvaialbeJournal.frame.size.width, self.oneAvaialbeJournal.frame.size.height)];
        subview1.journal = journal;
        subview1.controller = self;
        [subview1.coverImage setImage:journal.coverImage];
        subview1.journalTitle.text = journal.title;
        if(journal.password == Nil)
            [subview1.locked setHidden:YES];
        [self emptyView:oneAvaialbeJournal];
        
        
        [self.oneAvaialbeJournal addSubview:subview1];
        
        [subview1 release];
        [addImage setHidden:YES]; 
    }
    else if(pastSize == 1)
    {
        Journal* pastJournal = [journals objectAtIndex:0];
        [self emptyView:self.oneAvaialbeJournal];
        [self dispalyIpadJournal1:pastJournal journal2:journal]; 
    }
    else if(pastSize % 2 != 0) //gonna add in the existing slot in the last page
    {
        NSInteger current = [myPageControl currentPage];
        currentPairJournal = [myPageControl numberOfPages] - 1;
        Journal *journal1 = [journals objectAtIndex:( 2 * currentPairJournal)];
        [self dispalyIpadJournal1:journal1 journal2:journal]; 
        [myPageControl setCurrentPage:currentPairJournal];
        
        
        if(current != currentPairJournal)
            [self animateLeft];
    }else {
        [myPageControl setNumberOfPages:((journals.count + 1) / 2)];
        currentPairJournal = [myPageControl numberOfPages] - 1;
        [myPageControl setCurrentPage:currentPairJournal];
        [self dispalyIpadJournal1:journal journal2:nil];
        
        [self animateLeft];
        
        
    }
    
    
    [formIpad dismissPopoverAnimated:YES];
    formIpad = nil;
}


- (BOOL) isUniqueJournalTitle:(NSString*) journalTitle
{
    return YES;
}



- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    
    return NO;
}



- (IBAction)right:(id)sender {
    
    if(currentJournal != 0)
    {
        
        currentJournal--;
        [myPageControl setCurrentPage:currentJournal];
        Journal *journal = [journals objectAtIndex:currentJournal];
        [self dispalyIphoneJournal:journal];
        
        // set up an animation for the transition between the views
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [[self.avaialbeJournal layer] addAnimation:animation forKey:@"SwipeIphoneRight"];
        
        
    }
    
}

- (IBAction)left:(id)sender {
    NSInteger size =journals.count - 1;
    if (currentJournal < size)
    {
        
        currentJournal++;
        [myPageControl setCurrentPage:currentJournal];
        Journal *journal = [journals objectAtIndex:currentJournal];
        [self dispalyIphoneJournal:journal];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [[self.avaialbeJournal layer] addAnimation:animation forKey:@"SwipeIphoneLeft"];
        
        
    }
    
}

- (IBAction)changePage:(id)sender {
    if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ])
    {
        
        NSInteger limitJustforShow = [myPageControl numberOfPages] - 1;
        currentPairJournal = [myPageControl currentPage];
        Journal *journal1 = [journals objectAtIndex:( 2 * currentPairJournal)];
        Journal *journal2 = nil;
        if( currentPairJournal <  limitJustforShow || ((journals.count % 2) == 0  && currentPairJournal == limitJustforShow))
            journal2 =[journals objectAtIndex:( 2 * currentPairJournal) + 1];
        
        [self dispalyIpadJournal1:journal1 journal2:journal2];
        
        
    }else{
        
        currentJournal = [myPageControl currentPage];
        Journal *journal = [journals objectAtIndex:currentJournal];
        [self dispalyIphoneJournal:journal];
    }
    
}

- (IBAction)rightIpad:(id)sender {
    if(currentPairJournal > 0)
    {
        currentPairJournal -- ;
        [myPageControl setCurrentPage:currentPairJournal];
        Journal *journal1 = [journals objectAtIndex:( 2 * currentPairJournal)];
        Journal *journal2 = [journals objectAtIndex:( 2 * currentPairJournal) + 1];
        [self dispalyIpadJournal1:journal1 journal2:journal2];
        
        
        [self animateRight];
        
        
    }
    
}

- (IBAction)leftIpad:(id)sender {
    NSInteger limitJustforShow = [myPageControl numberOfPages] - 1;
    if(currentPairJournal < limitJustforShow)
    {
        currentPairJournal++;
        [myPageControl setCurrentPage:currentPairJournal];
        
        
        Journal *journal1 = [journals objectAtIndex:( 2 * currentPairJournal)];
        Journal *journal2 = nil;
        if( currentPairJournal <  limitJustforShow || ((journals.count % 2) == 0  && currentPairJournal == limitJustforShow))
            journal2 =[journals objectAtIndex:( 2 * currentPairJournal) + 1];
        
        [self dispalyIpadJournal1:journal1 journal2:journal2];
        
        
        [self animateLeft];
        
        
    }
}


-(void)dispalyIphoneJournal:(Journal*)journal
{
    JournalView* subview =  [[JournalView alloc]initWithFrame:CGRectMake(0, 0, self.avaialbeJournal.frame.size.width, self.avaialbeJournal.frame.size.height)];
    
    subview.journal = journal;
    subview.controller = self;
    [subview.coverImage setImage:journal.coverImage];
    subview.journalTitle.text = journal.title;
    if(journal.password == Nil)
        [subview.lockec setHidden:YES];
    
    
    [self emptyView:avaialbeJournal];
    [self.avaialbeJournal addSubview:subview];
    
    
    
    [subview release];
    
}

-(void)dispalyIpadJournal1:(Journal*)journal1 journal2:(Journal*)journal2
{
    
    [self emptyView:secondAvaiableJournal];
    if(journal1 != nil)
    {
        JournalPadView *subview1 = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.firstAvaialbeJournal.frame.size.width, self.firstAvaialbeJournal.frame.size.height)];
        
        subview1.journal = journal1;
        subview1.controller = self;
        [subview1.coverImage setImage:journal1.coverImage];
        subview1.journalTitle.text = journal1.title;
        if(journal1.password == Nil)
            [subview1.locked setHidden:YES];
        [self emptyView:firstAvaialbeJournal];
        [self emptyView:firstAvaialbeJournal];
        
        [self.firstAvaialbeJournal addSubview:subview1];
        
        [subview1 release];
    }
    if(journal2 != nil)
    {
        JournalPadView *subview2 = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.secondAvaiableJournal.frame.size.width, self.secondAvaiableJournal.frame.size.height)];
        
        subview2.journal = journal2;
        subview2.controller = self;
        [subview2.coverImage setImage:journal2.coverImage];
        subview2.journalTitle.text = journal2.title;
        
        if(journal2.password == Nil)
            [subview2.locked setHidden:YES];
        
        [self.secondAvaiableJournal addSubview:subview2];
        
        [subview2 release];
    }
    
}
-(void)emptyView:(UIView*)vieww
{
    for (UIView *view in vieww.subviews) {
        [view removeFromSuperview];
    }
}


- (void)lockedViewControllerDidCancel:(LockedJournalViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)lockedViewControllerDidFinish:(LockedJournalViewController *)controller withJournal:(Journal*)journal
{
    [self dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"createPhoneEntry" sender:self];
}



- (void) didCancel:(LockedJournalPadViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)appBackgroundViewControllerDidCancel:(AppBackgroundViewController *)controller
{
    [self.navigationController popToViewController:self animated:YES];
}
- (void)appBackgroundViewControllerDidFinish:(AppBackgroundViewController *)controller background:(NSString *)color
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:color forKey:@"AppBackground"];
    [defaults synchronize];
    
    
    [self setBackground: color];
    [self setCustomBackground:color];
    
    
    [self.navigationController popToViewController:self animated:YES];
}



-(void)setCustomBackground:(NSString*)color
{
    if([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator" ])
    {
        if(color == nil || [color isEqualToString:@"wood"])
        {
            background = @"wood";
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGWood.png"]];
            
        }else if([color isEqualToString:@"green"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGGreen.png"]];
            
        }else if([color isEqualToString:@"sun"])
        {
            UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
            if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||  interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGsunburstLandscape.png"]];
                
            }
            else
                myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGsunburstPortrait.png"]];
        }
        else if([color isEqualToString:@"water"])
        {
            UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
            if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||  interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGWaterLandscape.png"]];
                
            }
            else
                myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGWaterPortrait.png"]];
            
        }else if([color isEqualToString:@"flower"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGfloral.png"]];
            
        }
        else if([color isEqualToString:@"linen"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGlinnen.jpg"]];
            
        }
        
        
    }else {
        if(color == nil || [color isEqualToString:@"wood"])
        {
            background = @"wood";
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGwoodiphone@2x.jpg"]];
            
        }else if([color isEqualToString:@"green"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGGreeniphone@2x.png"]];
            
        }else if([color isEqualToString:@"sun"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGsunburstiphone@2x.png"]];
        }
        else if([color isEqualToString:@"water"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGWateriPhone.png"]];
            
        }else if([color isEqualToString:@"flower"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGfloraliphone@2x.png"]];
            
        }
        else if([color isEqualToString:@"linen"])
        {
            myView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BGlinneniphone@2x.jpg"]];
            
        }
        
        
    }
}


- (void)padAppearanceViewControlleDidCancel:(PadAppearanceViewController *)controller
{
    [self.appearance dismissPopoverAnimated:YES]; 
    appearance = nil;
    
    
    
}
- (void)padAppearanceViewControlleDidFinish:(PadAppearanceViewController *)controller background:(NSString *)background1
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:background1 forKey:@"AppBackground"];
    [defaults synchronize];
    
    [self setBackground: background1];
    [self setCustomBackground:background1];
    [self.appearance dismissPopoverAnimated:YES]; 
    appearance = nil;
}


- (void) animateLeft
{
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    
    //    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    NSString *subtypeDirection;
    
    //
    //    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
    //        subtypeDirection = kCATransitionFromBottom;
    //    }
    //    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    //        subtypeDirection = kCATransitionFromTop;
    //    }
    //    else {
    //        subtypeDirection = kCATransitionFromRight;
    //    }
    
    subtypeDirection = kCATransitionFromRight;
    [animation setSubtype:subtypeDirection];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.twoJournalView layer] addAnimation:animation forKey:@"SwipeIpadLeft"];
    
}

- (void) animateRight
{
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    
    //    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    NSString *subtypeDirection;
    //    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
    //        subtypeDirection = kCATransitionFromTop;
    //    }
    //    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    //        subtypeDirection = kCATransitionFromBottom;
    //    }
    //    else {
    //        subtypeDirection = kCATransitionFromLeft;
    //    }
    
    subtypeDirection = kCATransitionFromLeft;
    [animation setSubtype:subtypeDirection];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.twoJournalView  layer] addAnimation:animation forKey:@"SwipeIpadRight"];
}

- (void) showPop
{
    CjPadViewController * myNib = [[CjPadViewController alloc] initWithNibName: @"formIpad" bundle: nil];
    
    
    
    
    
    self.formIpad = [[UIPopoverController alloc] initWithContentViewController: myNib];
    self.formIpad.delegate = self;
    
    
    [self.formIpad setPopoverContentSize: CGSizeMake(600 , 681)];
    [formIpad setPopoverLayoutMargins:UIEdgeInsetsMake(0, 0, -20, 0)];
    formIpad.popoverBackgroundViewClass = [CustomPopoverBackgroundView class];
    
    [formIpad presentPopoverFromRect:self.anchor.frame inView:self.myView permittedArrowDirections:0 animated:YES];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //cancel clicked ...do your action
    }
    else if (buttonIndex == 1)
    {
        //        [cjDelegate cJPadViewControllerDidCancel:self];
    }
}


-(void) deleteIphoneJournalAtIndex:(NSInteger) index
{
    [self deleteJournal:index];
    NSInteger pastSize = [journals count] + 1;
    Journal* journal;
    [myPageControl setNumberOfPages:journals.count];
    if(pastSize == 1)
    {
        [self emptyView:avaialbeJournal];
        [addImage setHidden:NO];
        
        
    }else if(index == pastSize - 1)
    {
        journal = [journals objectAtIndex:(index - 1)];
        currentJournal = index - 1;
        [myPageControl setCurrentPage:currentJournal];
        [self dispalyIphoneJournal:journal];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [[self.avaialbeJournal layer] addAnimation:animation forKey:@"SwipeIphoneRight"];
        
    }else 
    {
        journal = [journals objectAtIndex:(index)];
        currentJournal = index ;
        [myPageControl setCurrentPage :currentJournal];
        [self dispalyIphoneJournal:journal];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [[self.avaialbeJournal layer] addAnimation:animation forKey:@"SwipeIphoneLeft"];
    }
    
}

-(void) deleteIpadJournalAtIndex:(NSInteger) index
{
    [self deleteJournal:index];
    NSInteger pastSize = [journals count] + 1;
    Journal* journal;
    [myPageControl setNumberOfPages:((journals.count + 1) / 2)];
    
    if(pastSize == 1)
    {
        [self emptyView:oneAvaialbeJournal];
        [addImage setHidden:NO];        
    }else if(pastSize == 2)
    {
        [self emptyView:firstAvaialbeJournal];
        [self emptyView:secondAvaiableJournal];
   
        journal = [journals objectAtIndex:0];
        [self displayOneAvailableJournal:journal];

    }else if ((index == pastSize - 1) && (index % 2) != 0)
    {
        [self emptyView:secondAvaiableJournal];   
        
    }else if ((index == pastSize - 1) && (index % 2) == 0)
    {
        currentPairJournal -- ;
        [myPageControl setCurrentPage:currentPairJournal];
        Journal *journal1 = [journals objectAtIndex:( 2 * currentPairJournal)];
        Journal *journal2 = [journals objectAtIndex:( 2 * currentPairJournal) + 1];
        [self dispalyIpadJournal1:journal1 journal2:journal2];
        
        
        [self animateRight];
        
    }else if ((index % 2) != 0)
    {
        journal = [journals objectAtIndex:(index)];
        [self dispalyIpadJournal1:nil journal2:journal];
        
    }else if ((index % 2) == 0)
    {
        Journal *journal1 = [journals objectAtIndex:(index)];
        Journal *journal2 = nil;
        if((index + 1)  < [journals count])
            journal2 = [journals objectAtIndex:(index) + 1];
        [self dispalyIpadJournal1:journal1 journal2:journal2];

        
    }
    
    
    
}

-(void)deleteJournal:(NSInteger)index1
{
    [journals removeObjectAtIndex:index1];
    [self adjustIndecies];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = self.journals ; // set value
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [defaults setObject:data forKey:@"journals"];
    [defaults synchronize];
    
    
    
}

-(void) adjustIndecies
{
    for (int i = 0; i < [journals count]; i++) {
        Journal * journal = [journals objectAtIndex:i];
        [journal setIndex:i];
    }
}


-(void) displayOneAvailableJournal:(Journal *)journal
{
    JournalPadView *subview = [[JournalPadView alloc]initWithFrame:CGRectMake(0, 0, self.oneAvaialbeJournal.frame.size.width, self.oneAvaialbeJournal.frame.size.height)];
    [subview.coverImage setImage:journal.coverImage];
    
    subview.journal = journal;
    subview.controller = self;
    subview.journalTitle.text = journal.title;
    if(journal.password == Nil)
        [subview.locked setHidden:YES];
    
    [self emptyView:oneAvaialbeJournal];
    
    [self.oneAvaialbeJournal addSubview:subview];
    [subview release];

}
@end
