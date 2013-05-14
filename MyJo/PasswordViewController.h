//
//  PasswordViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordViewControllerDelegate;
@interface PasswordViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) id <PasswordViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)savePassword:(id)sender;
- (IBAction)cancelPassword:(id)sender;




@end

@protocol PasswordViewControllerDelegate <NSObject>
- (void)PasswordViewControllerDidCancel:(PasswordViewController *)controller;
- (void)PasswordViewControllerDidFinish:(PasswordViewController *)controller password:(NSString *)password;

@end