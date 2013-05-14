//
//  OpenAppViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"


@interface OpenAppViewController : UIViewController <UIScrollViewDelegate,UIActionSheetDelegate,UIPopoverControllerDelegate , UIAlertViewDelegate>
{
    UIScrollView* myView;
    UIPageControl *myPageControl;

    UIActionSheet *actionSheet;
    NSString *deviceType;
    
    NSInteger currentJournal;
    NSInteger currentPairJournal;
}

@property (retain, nonatomic) IBOutlet UIView *myView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *addToolbarButton;
@property(strong,nonatomic)  UIPopoverController *formIpad;
@property(retain,nonatomic)  UIPopoverController *appearance;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollPop;

@property (retain, nonatomic) IBOutlet UIView *anchor;

@property (retain, nonatomic) IBOutlet UIView *avaialbeJournal;
@property (retain, nonatomic) IBOutlet UIPageControl *myPageControl;
@property (nonatomic, retain) NSMutableArray *journals;
- (IBAction)tapAddImage:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *addImage;

@property (retain, nonatomic) IBOutlet UIView *firstAvaialbeJournal;
@property (retain, nonatomic) IBOutlet UIView *secondAvaiableJournal;

@property (retain, nonatomic) IBOutlet UIView *oneAvaialbeJournal;
@property (strong, atomic) Journal* tappedJournal;
@property (strong, atomic) NSString* background;

@property (retain, nonatomic) IBOutlet UIView *twoJournalView;
@property (retain, nonatomic) IBOutlet UIView *landscapeAnchor;



- (IBAction)toolbarAdd:(id)sender;
- (void) toolbarForPad;
- (IBAction)manageApp:(id)sender;


//- (IBAction)changePage:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)changePage:(id)sender;
- (IBAction)rightIpad:(id)sender;
- (IBAction)leftIpad:(id)sender;


-(void) deleteIphoneJournalAtIndex:(NSInteger) index;
-(void) deleteIpadJournalAtIndex:(NSInteger) index;


@end
