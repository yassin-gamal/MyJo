//
//  LockedJournalViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"
#import "OpenAppViewController.h"

@protocol LockedViewControllerDelegate;

@interface LockedJournalViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *lockedPassword;
@property (strong ,nonatomic) id <LockedViewControllerDelegate> delegate; 
@property (retain, nonatomic)  Journal  *journal;
@property (retain, nonatomic)  OpenAppViewController  *senderController;



- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end



@protocol LockedViewControllerDelegate <NSObject>
- (void)lockedViewControllerDidCancel:(LockedJournalViewController *)controller;
- (void)lockedViewControllerDidFinish:(LockedJournalViewController *)controller withJournal:(Journal*)journal;

@end



