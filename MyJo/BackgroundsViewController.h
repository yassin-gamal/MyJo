//
//  BackgroundsViewController.h
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackgroundViewControllerDelegate ; 
@interface BackgroundsViewController : UITableViewController
{
    NSIndexPath * previousIndexPath;
}

@property (strong,nonatomic) NSIndexPath * previousIndexPath;
@property (retain, nonatomic) IBOutlet UITableViewCell *wood;
@property (strong, nonatomic) id <BackgroundViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *saveBackground;


@property (retain, nonatomic) IBOutlet UIImageView *woodImage;

@property (retain, nonatomic) IBOutlet UIImageView *linenImage;


@property (retain, nonatomic) IBOutlet UIImageView *greenImage;
@property (retain, nonatomic) IBOutlet UIImageView *sunImage;

@property (retain, nonatomic) IBOutlet UIImageView *waterImage;
@property (retain, nonatomic) IBOutlet UIImageView *flowerImage;

- (IBAction)saveBackground:(id)sender;
- (IBAction)cancelBackgroud:(id)sender;
- (void) selectCell:(UITableViewCell *) color;
- (void) deselectCell:(UITableViewCell *) color;


@end

@protocol BackgroundViewControllerDelegate <NSObject>
- (void)backgroundViewControllerDidCancel:(BackgroundsViewController *)controller;
- (void)backgroundViewControllerDidFinish:(BackgroundsViewController *)controller background:(NSString *)color;


@end