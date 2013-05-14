//
//  LockedJournalPadViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
@protocol LockedPadViewControllerDelegate;


@interface LockedJournalPadViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *lockedPassword;
@property (strong, nonatomic) id <LockedPadViewControllerDelegate> delegate;
@property (retain, nonatomic)  Journal  *journal;
- (IBAction)cancel:(id)sender;

@end




@protocol LockedPadViewControllerDelegate <NSObject>
- (void) didCancel:(LockedJournalPadViewController *)controller;
@end

