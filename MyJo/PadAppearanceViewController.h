//
//  PadAppearanceViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PadAppearanceViewController;
@interface PadAppearanceViewController : UIViewController
//backgrounds
@property (retain, nonatomic) IBOutlet UIButton *wood;
@property (retain, nonatomic) IBOutlet UIButton *linen;
@property (retain, nonatomic) IBOutlet UIButton *green;
@property (retain, nonatomic) IBOutlet UIButton *sun;
@property (retain, nonatomic) IBOutlet UIButton *water;
@property (retain, nonatomic) IBOutlet UIButton *flower;
@property (retain, nonatomic) IBOutlet UIButton *lastBackground;
@property (strong, nonatomic) id <PadAppearanceViewController> backDelegate;
@property (strong, nonatomic) NSString *currentBackground;
- (IBAction)wood:(id)sender;
- (IBAction)linen:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)sun:(id)sender;
- (IBAction)water:(id)sender;
- (IBAction)floral:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

-(void)prepareViewController ;
@end




@protocol PadAppearanceViewController <NSObject>
- (void)padAppearanceViewControlleDidCancel:(PadAppearanceViewController *)controller;
- (void)padAppearanceViewControlleDidFinish:(PadAppearanceViewController *)controller background:(NSString *)background;

@end