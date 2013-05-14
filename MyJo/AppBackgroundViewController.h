//
//  AppBackgroundViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppBackgroundViewControllerDelegate;
@interface AppBackgroundViewController : UITableViewController



{
    NSIndexPath * previousIndexPath;
}

@property (strong,nonatomic) NSIndexPath * previousIndexPath;
@property (retain, nonatomic) IBOutlet UITableViewCell *wood;
@property (retain, nonatomic) IBOutlet UITableViewCell *linen;
@property (retain, nonatomic) IBOutlet UITableViewCell *green;
@property (retain, nonatomic) IBOutlet UITableViewCell *sun;
@property (retain, nonatomic) IBOutlet UITableViewCell *water;
@property (retain, nonatomic) IBOutlet UITableViewCell *flower;

@property (strong, nonatomic) id <AppBackgroundViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveBackground;


@property (retain, nonatomic) IBOutlet UIImageView *woodImage;

@property (retain, nonatomic) IBOutlet UIImageView *linenImage;


@property (retain, nonatomic) IBOutlet UIImageView *greenImage;
@property (retain, nonatomic) IBOutlet UIImageView *sunImage;

@property (retain, nonatomic) IBOutlet UIImageView *waterImage;
@property (retain, nonatomic) IBOutlet UIImageView *flowerImage;
@property (strong, nonatomic) NSString *currentBackground;

- (IBAction)saveBackground:(id)sender;
- (IBAction)cancelBackgroud:(id)sender;
- (void) selectCell:(UITableViewCell *) color;
- (void) deselectCell:(UITableViewCell *) color;

-(void)prepareViewController ;


@end



@protocol AppBackgroundViewControllerDelegate <NSObject>
- (void)appBackgroundViewControllerDidCancel:(AppBackgroundViewController *)controller;
- (void)appBackgroundViewControllerDidFinish:(AppBackgroundViewController *)controller background:(NSString *)color;


@end
