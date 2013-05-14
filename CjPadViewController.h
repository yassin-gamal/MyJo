//
//  CjPadViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
#import "Validator.h"


@protocol CjPadViewController;

@interface CjPadViewController : UIViewController  <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIPopoverControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIPopoverController *popoverController;
    NSString* defaultColor;
    NSString* defaultBackground;
    BOOL hasPassword;
    
}

@property (strong , atomic) Journal *journal;

@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UIButton *coverImage;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (retain, nonatomic) IBOutlet UITextField *journalTitle;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UITextField *confirmPass;

@property (strong, nonatomic) id <CjPadViewController> cjDelegate;
@property (strong , atomic) NSString *passwordValue;
@property (strong , atomic) UIImage *journalCover;

@property (retain, nonatomic) IBOutlet UIScrollView *myScroll;
//colors
@property (retain, nonatomic) IBOutlet UIButton *white;
@property (retain, nonatomic) IBOutlet UIButton *creme;
@property (retain, nonatomic) IBOutlet UIButton *grey;
@property (retain, nonatomic) IBOutlet UIButton *yellow;
@property (retain, nonatomic) IBOutlet UIButton *lastColor;

//backgrounds
@property (retain, nonatomic) IBOutlet UIButton *wood;
@property (retain, nonatomic) IBOutlet UIButton *linen;
@property (retain, nonatomic) IBOutlet UIButton *green;
@property (retain, nonatomic) IBOutlet UIButton *sun;
@property (retain, nonatomic) IBOutlet UIButton *water;
@property (retain, nonatomic) IBOutlet UIButton *flower;
@property (retain, nonatomic) IBOutlet UIButton *lastBackground;

@property (strong , atomic)  Validator *validator;




- (IBAction)chooseCover:(id)sender;
- (IBAction)clearCover:(id)sender;
- (IBAction)pressWhite:(id)sender;
- (IBAction)pressCreme:(id)sender;
- (IBAction)pressGrey:(id)sender;
- (IBAction)pressYellow:(id)sender;


- (IBAction)wood:(id)sender;
- (IBAction)linen:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)sun:(id)sender;
- (IBAction)water:(id)sender;
- (IBAction)floral:(id)sender;


//toolbar

- (IBAction)doSave:(id)sender;
- (IBAction)doCancel:(id)sender;


@end


@protocol CjPadViewController <NSObject>
- (void)cJPadViewControllerDidCancel:(CjPadViewController *)controller;
- (void)cJPadViewControllerDidFinish:(CjPadViewController *)controller journal:(Journal *)journal;
- (BOOL) isUniqueJournalTitle:(NSString*) journalTitle;
@end