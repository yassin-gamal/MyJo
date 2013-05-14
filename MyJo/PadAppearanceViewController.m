//
//  PadAppearanceViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PadAppearanceViewController.h"

@interface PadAppearanceViewController ()

@end

@implementation PadAppearanceViewController


@synthesize backDelegate;

@synthesize wood;
@synthesize linen;
@synthesize green;
@synthesize sun;
@synthesize water;
@synthesize flower;
@synthesize lastBackground;
@synthesize currentBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [wood setImage:[UIImage imageNamed:@"swatch-wood-select-pad.png"] forState:UIControlStateSelected];
    [linen setImage:[UIImage imageNamed:@"BGlinnen70-select@2x.png"] forState:UIControlStateSelected];
    [green setImage:[UIImage imageNamed:@"swatch-green-select105.png"] forState:UIControlStateSelected];
    [sun setImage:[UIImage imageNamed:@"swatch-suburst-select105.png"] forState:UIControlStateSelected];
    [water setImage:[UIImage imageNamed:@"swatch-water-select105.png"] forState:UIControlStateSelected];
    [flower setImage:[UIImage imageNamed:@"swatch-floral-select105.png"] forState:UIControlStateSelected];
    
       
       

}

- (void)viewDidUnload
{
   
    [self setWood:nil];
    [self setLinen:nil];
    [self setGreen:nil];
    [self setSun:nil];
    [self setWater:nil];
    [self setFlower:nil];

    [super viewDidUnload];

    // Release any retained subviews of the main view.
}


- (void)dealloc {
   
    [wood release];
    [linen release];
    [green release];
    [sun release];
    [water release];
    [flower release];

    [super dealloc];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)wood:(id)sender {
    [lastBackground setSelected:FALSE];
    [wood setSelected:YES];
    lastBackground = wood;

}  

- (IBAction)linen:(id)sender {
    [lastBackground setSelected:FALSE];
    [linen setSelected:YES];
    lastBackground = linen;

}

-  (IBAction)green:(id)sender {
    [lastBackground setSelected:FALSE];
    [green setSelected:YES];
    lastBackground = green;

}

- (IBAction)sun:(id)sender {
    [lastBackground setSelected:FALSE];
    [sun setSelected:YES];
    lastBackground = sun;

}

- (IBAction)water:(id)sender {
    [lastBackground setSelected:FALSE];
    [water setSelected:YES];
    lastBackground = water;

}

- (IBAction)floral:(id)sender {
    [lastBackground setSelected:FALSE];
    [flower setSelected:YES];
    lastBackground = flower;

}

- (IBAction)done:(id)sender {
    [backDelegate padAppearanceViewControlleDidFinish:self background:lastBackground.titleLabel.text];
}

- (IBAction)cancel:(id)sender {
    [backDelegate padAppearanceViewControlleDidCancel:self];
    
}


-(void)prepareViewController {
    if([currentBackground isEqualToString:@"wood"])
    {
        [wood setSelected:YES];
        lastBackground = wood;
    }
    else if([currentBackground isEqualToString:@"linen"])
    {
        [linen setSelected:YES];
        lastBackground = linen;
    }
    else if([currentBackground isEqualToString:@"water"])
    {
        [water setSelected:YES];
        lastBackground = water;
    }
    else if([currentBackground isEqualToString:@"flower"])
    {
        [flower setSelected:YES];
        lastBackground = flower;
    }
    else if([currentBackground isEqualToString:@"sun"])
    {
        [sun setSelected:YES];
        lastBackground = sun;
    }
    else if([currentBackground isEqualToString:@"green"])
    {
        [green setSelected:YES];
        lastBackground = green;
    }

}


@end
