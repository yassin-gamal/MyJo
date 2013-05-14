//
//  ColorsViewController.m
//  MyJo
//
//  Created by Yassin Gamal on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@end

@implementation ColorsViewController
@synthesize delegate = _delegate;
@synthesize white;
@synthesize whiteImage;
@synthesize cremeImage;
@synthesize greyImage;
@synthesize yellowImage;
@synthesize previousIndexPath;

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
    [white setSelected:TRUE];
    [white setAccessoryType:UITableViewCellAccessoryCheckmark];
    [whiteImage setImage:[UIImage imageNamed:@"phoneswatch-white-select@2x"]];
    self.previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"futura" size:16.0];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor =[UIColor whiteColor];
    label.text=@"Journal Page Color";  
    self.navigationItem.titleView = label;      
    [label release];
    
    
    
    //    self.tableView 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setWhite:nil];
    [self setWhiteImage:nil];
    [self setCremeImage:nil];
    [self setGreyImage:nil];
    [self setYellowImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
    currentCell =  [tableView cellForRowAtIndexPath:indexPath];
    if([currentCell reuseIdentifier] != NULL )
    {
        if(self.previousIndexPath)
        {
            previousCell =  [tableView cellForRowAtIndexPath:previousIndexPath];
            [previousCell setAccessoryType:UITableViewCellAccessoryNone];
            
            [self deselectCell:previousCell];
        }
        
        
        [currentCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        [self selectCell:currentCell];
        self.previousIndexPath = indexPath;
    }
    
    
}

- (IBAction)saveColor:(id)sender {
   
        UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.previousIndexPath];
        NSString* color = [currentCell reuseIdentifier];
        
        [[self delegate] colorsViewControllerDidFinish:self color: color]; 
        
    
    
}

- (IBAction)cancelColor:(id)sender {
    [[self delegate] colorsViewControllerDidCancel:self];
}

- (void) selectCell:(UITableViewCell *) cell;
{
    NSString* color1 = [cell reuseIdentifier];
    if ([color1 isEqualToString:@"white"])
    {
        [whiteImage setImage:[UIImage imageNamed:@"phoneswatch-white-select@2x"]];
    }else if ([color1 isEqualToString:@"yellow"])
    {
        [yellowImage setImage:[UIImage imageNamed:@"phoneswatch-yellowish-select@2x"]];
    }else if ([color1 isEqualToString:@"grey"])
    {
        [greyImage setImage:[UIImage imageNamed:@"phoneswatch-greyish-select@2x"]];
    }else if ([color1 isEqualToString:@"creme"])
    {
        [cremeImage setImage:[UIImage imageNamed:@"phoneswatch-creme-select@2x"]];
    }
    
}
- (void) deselectCell:(UITableViewCell *) cell{
    
    NSString* color1 = [cell reuseIdentifier];
    
    
    if ([color1 isEqualToString:@"white"])
    {
        [whiteImage setImage:[UIImage imageNamed:@"phoneswatch-white@2x"]];
    }else if ([color1 isEqualToString:@"yellow"])
    {
        [yellowImage setImage:[UIImage imageNamed:@"phoneswatch-yellowish@2x"]];
    }else if ([color1 isEqualToString:@"grey"])
    {
        [greyImage setImage:[UIImage imageNamed:@"phoneswatch-greyish@2x"]];
    }else if ([color1 isEqualToString:@"creme"])
    {
        [cremeImage setImage:[UIImage imageNamed:@"phoneswatch-creme@2x"]];
    }
    
}
- (void)dealloc {
    [white release];
    [whiteImage release];
    [cremeImage release];
    [greyImage release];
    [yellowImage release];
    [super dealloc];
}
@end
