//
//  CEntryPhoneViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Journal.h"

@interface CEntryPhoneViewController : UIViewController <UITextViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
     BOOL isEditAll;
    UIActionSheet *actionSheet;
    CGPoint initialPointOfImage;
}

- (IBAction)insertPhoto:(id)sender;

@property(strong,atomic) Journal *journal;
@property (retain, nonatomic) IBOutlet UIButton *keyboardButton;
@property (retain, nonatomic) IBOutlet UIWebView *webEditor;
@property (retain, nonatomic) IBOutlet UIImageView *journalPage;

- (IBAction)pressFont:(id)sender;


- (IBAction)dismissKeyboard:(id)sender;


- (IBAction)doIt:(id)sender;

-(void)setCustomBackground:(NSString*)color;
-(void)setCustomPageColor:(NSString*)color;




@end
