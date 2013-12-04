//
//  SODViewControllerViewController.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "EODViewControllerViewController.h"
#import "SODCustomTableCell.h"

@interface EODViewControllerViewController ()

@end

@implementation EODViewControllerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _confirmFlag = FALSE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundView = nil;
//    self.tableView.backgroundColor = COLOR_THEME;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrOrders count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (SODCustomTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SODCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
//        cell = [[SODCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[SODCustomTableCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.enumViewType = EOD;
    }
    
    // Configure the cell...
    NSDictionary *dict = [arrOrders objectAtIndex:indexPath.row];
    
    int colorID = 0;
    
    if (_confirmFlag) {
        if (enteredValues[indexPath.row] == [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue]) {
            colorID = 0;
        }
        else {
            if (acceptedValues[indexPath.row] == 1) {
                colorID = 2;
            }
            else {
                colorID = 1;
            }
        }
    }
    else {
        colorID = 0;
    }
    
    [cell setData:indexPath.row :colorID :NO];
    return cell;
}

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Custom Methods
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 98;
}
    
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 98)];
    viewFooter.backgroundColor = COLOR_THEME;
    
    txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 200, 44)];
    txtFieldMatID.placeholder = @" Enter Material ID";
    txtFieldMatID.backgroundColor = [UIColor whiteColor];
    txtFieldMatID.enabled = NO;
    txtFieldMatID.tag = 10001;
    [viewFooter addSubview:txtFieldMatID];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 5, 5, 75, 44);
    [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor whiteColor]];
    [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
    [viewFooter addSubview:btnAdd];
    
    UIButton *btnBarCode = [[UIButton alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 5, 5, 162, 44)];
    [btnBarCode setBackgroundImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
    [btnBarCode addTarget:self action:@selector(btnBarCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewFooter addSubview:btnBarCode];
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSubmit.frame = CGRectMake(viewFooter.frame.size.width - 130, 5, 150, 44);
    [btnSubmit addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setBackgroundColor:[UIColor whiteColor]];
    [btnSubmit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnSubmit setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [viewFooter addSubview:btnSubmit];
    
    
    UILabel *lblMat = [[UILabel alloc] initWithFrame:CGRectMake(0, 59, 100, 34)];
    lblMat.backgroundColor = [UIColor clearColor];
    lblMat.textColor = [UIColor whiteColor];
    lblMat.text = @"Material ID";
    
    [viewFooter addSubview:lblMat];
    
    UILabel *lblPlaced = [[UILabel alloc] initWithFrame:CGRectMake(580, 59, 100, 34)];
    lblPlaced.backgroundColor = [UIColor clearColor];
    lblPlaced.textColor = [UIColor whiteColor];
    lblPlaced.text = @"Pending";
    [viewFooter addSubview:lblPlaced];
    
    UILabel *lblRequired = [[UILabel alloc] initWithFrame:CGRectMake(750, 59, 100, 34)];
    lblRequired.backgroundColor = [UIColor clearColor];
    lblRequired.textColor = [UIColor whiteColor];
    lblRequired.text = @"Total";
    [viewFooter addSubview:lblRequired];
    
    return viewFooter;
}

- (void)submitButtonClicked {
    _confirmFlag = TRUE;
    [self.tableView reloadData];
}

- (void)addButtonClicked {
    
}

- (void)btnBarCodeBtnClicked {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Starting the scanner...." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL", nil];
    [alert show];
}

@end
