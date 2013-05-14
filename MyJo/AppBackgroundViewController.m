//
//  AppBackgroundViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppBackgroundViewController.h"

@interface AppBackgroundViewController ()

@end

@implementation AppBackgroundViewController
@synthesize saveBackground;
@synthesize woodImage;
@synthesize linenImage;
@synthesize greenImage;
@synthesize sunImage;
@synthesize waterImage;
@synthesize flowerImage;
@synthesize previousIndexPath;
@synthesize wood;
@synthesize linen;
@synthesize green;
@synthesize sun;
@synthesize water;
@synthesize flower;
@synthesize delegate;
@synthesize currentBackground;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareViewController];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"futura" size:16.0];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"Background";  
    self.navigationItem.titleView = label;      
    [label release];
    
}

- (void)viewDidUnload
{
    [self setWood:nil];
    [self setSaveBackground:nil];
    [self setWoodImage:nil];
    [self setLinenImage:nil];
    [self setGreenImage:nil];
    [self setSunImage:nil];
    [self setWaterImage:nil];
    [self setFlowerImage:nil];
    [self setLinen:nil];
    [self setGreen:nil];
    [self setSun:nil];
    [self setWater:nil];
    [self setFlower:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.previousIndexPath == indexPath) return;
    
    UITableViewCell *previousCell;
    UITableViewCell *currentCell;
    
    if(self.previousIndexPath)
    {
        previousCell =  [tableView cellForRowAtIndexPath:previousIndexPath];
        [previousCell setAccessoryType:UITableViewCellAccessoryNone];
        [self deselectCell:previousCell];
    }
    
    currentCell =  [tableView cellForRowAtIndexPath:indexPath];
    [currentCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [self selectCell:currentCell];
    
    self.previousIndexPath = indexPath;
}


- (void)dealloc {
    [wood release];
    [saveBackground release];
    [woodImage release];
    [linenImage release];
    [greenImage release];
    [sunImage release];
    [waterImage release];
    [flowerImage release];
    [linen release];
    [green release];
    [sun release];
    [water release];
    [flower release];
    [super dealloc];
}
- (IBAction)saveBackground:(id)sender {
    
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.previousIndexPath];
    NSString* background = [currentCell reuseIdentifier];
    
    [[self delegate] appBackgroundViewControllerDidFinish:self background:background]; 
    
    
    
}

- (IBAction)cancelBackgroud:(id)sender {
    [[self delegate] appBackgroundViewControllerDidCancel:self];
}

- (void) selectCell:(UITableViewCell *) cell;
{
    NSString* color1 = [cell reuseIdentifier];
    if ([color1 isEqualToString:@"wood"])
    {
        [woodImage setImage:[UIImage imageNamed:@"swatch-wood-select@2x"]];
    }else if ([color1 isEqualToString:@"linen"])
    {
        [linenImage setImage:[UIImage imageNamed:@"swatch-linnen-select@2x"]];
    }else if ([color1 isEqualToString:@"green"])
    {
        [greenImage setImage:[UIImage imageNamed:@"swatch-green-select@2x"]];
    }else if ([color1 isEqualToString:@"sun"])
    {
        [sunImage setImage:[UIImage imageNamed:@"swatch-suburst-select@2x"]];
    }else if ([color1 isEqualToString:@"flower"])
    {
        [flowerImage setImage:[UIImage imageNamed:@"swatch-floral-select@2x"]];
    }else if ([color1 isEqualToString:@"water"])
    {
        [waterImage setImage:[UIImage imageNamed:@"swatch-water-select@2x"]];
    }
    
}




-(void)prepareViewController {
    
    if([currentBackground isEqualToString:@"wood"])
    {
        [wood setSelected:TRUE];
        [woodImage setImage:[UIImage imageNamed:@"swatch-wood-select@2x"]];
        [wood setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else if([currentBackground isEqualToString:@"linen"])
    {
        [linen setSelected:TRUE];
        [linenImage setImage:[UIImage imageNamed:@"swatch-linnen-select@2x"]];
        [linen setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    else if([currentBackground isEqualToString:@"water"])
    {
        [water setSelected:TRUE];
        [waterImage setImage:[UIImage imageNamed:@"swatch-water-select@2x"]];
        [water setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    }
    else if([currentBackground isEqualToString:@"flower"])
    {
        [flower setSelected:TRUE];
      [flowerImage setImage:[UIImage imageNamed:@"swatch-floral-select@2x"]];
        [flower setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];

    }
    else if([currentBackground isEqualToString:@"sun"])
    {
        [sun setSelected:TRUE];
         [sunImage setImage:[UIImage imageNamed:@"swatch-suburst-select@2x"]];
        [sun setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    }
    else if([currentBackground isEqualToString:@"green"])
    {
        [green setSelected:TRUE];
        [greenImage setImage:[UIImage imageNamed:@"swatch-green-select@2x"]];
        [green setAccessoryType:UITableViewCellAccessoryCheckmark];
        self.previousIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    }
    
}


- (void) deselectCell:(UITableViewCell *) cell{
    
    
    NSString* color1 = [cell reuseIdentifier];
    if ([color1 isEqualToString:@"wood"])
    {
        [woodImage setImage:[UIImage imageNamed:@"swatch-wood@2x"]];
    }else if ([color1 isEqualToString:@"linen"])
    {
        [linenImage setImage:[UIImage imageNamed:@"swatch-linnen@2x"]];
    }else if ([color1 isEqualToString:@"green"])
    {
        [greenImage setImage:[UIImage imageNamed:@"swatch-Green@2x"]];
    }else if ([color1 isEqualToString:@"sun"])
    {
        [sunImage setImage:[UIImage imageNamed:@"swatch-sunburst@2x"]];
    }else if ([color1 isEqualToString:@"flower"])
    {
        [flowerImage setImage:[UIImage imageNamed:@"swatch-floral@2x"]];
    }else if ([color1 isEqualToString:@"water"])
    {
        [waterImage setImage:[UIImage imageNamed:@"swatch-water@2x"]];
    }
    
}


@end
