//
//  BackgroundsViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundsViewController.h"

@interface BackgroundsViewController ()

@end

@implementation BackgroundsViewController
@synthesize saveBackground;
@synthesize woodImage;
@synthesize linenImage;
@synthesize greenImage;
@synthesize sunImage;
@synthesize waterImage;
@synthesize flowerImage;
@synthesize previousIndexPath;
@synthesize wood;
@synthesize delegate;

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
    [wood setSelected:TRUE];
    [woodImage setImage:[UIImage imageNamed:@"swatch-wood-select@2x"]];
    [wood setAccessoryType:UITableViewCellAccessoryCheckmark];
    self.previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"futura" size:16.0];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"Journal background";  
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
    [super dealloc];
}
- (IBAction)saveBackground:(id)sender {
    
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.previousIndexPath];
    NSString* background = [currentCell reuseIdentifier];
    
    [[self delegate] backgroundViewControllerDidFinish:self background:background]; 
    
    
    
    
}

- (IBAction)cancelBackgroud:(id)sender {
    [[self delegate] backgroundViewControllerDidCancel:self];
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
