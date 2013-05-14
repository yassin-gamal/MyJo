//
//  CjPhoneViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
#import "Validator.h"


@protocol CjPhoneViewController;
@interface CjPhoneViewController : UITableViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
  
}

@property (retain, nonatomic) IBOutlet UIButton *coverImage;
- (IBAction)chooseCover:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *journalTitle;
@property (strong , atomic) Journal *journal;
@property (strong , atomic) NSString *password;
@property (strong , atomic) UIImage *journalCover;
@property (strong , atomic)  Validator *validator;
@property (strong, nonatomic) id <CjPhoneViewController> delegate;
@property (strong , atomic) NSString *defaultColor;
@property (strong , atomic) NSString *defaultBackground;


@property (retain, nonatomic) IBOutlet UILabel *journalTitleLabel;


@property (retain, nonatomic) IBOutlet UILabel *coverImageDescription;
@property (retain, nonatomic) IBOutlet UISwitch *passwordSwitch;

- (IBAction)switchTriggered:(id)sender;
- (IBAction)doSave:(id)sender;
- (IBAction)doCancel:(id)sender;


@end




@protocol CjPhoneViewController <NSObject>
- (void)cJViewControllerDidCancel:(CjPhoneViewController *)controller;
- (void)cJViewControllerDidFinish:(CjPhoneViewController *)controller journal:(Journal *)journal;
- (BOOL) isUniqueJournalTitle:(NSString*) journalTitle;


@end