//
//  SODViewControllerViewController.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "SODViewControllerViewController.h"
#import "SODCustomTableCell.h"

@interface SODViewControllerViewController ()

@end

@implementation SODViewControllerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _confirmFlag = FALSE;
        _isEditable = TRUE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundView = nil;
//    self.tableView.backgroundColor = COLOR_THEME;
    
    _materialsViewController = [[MaterialsViewController alloc] initWithStyle:UITableViewStylePlain];
    _materialsViewController.parentDelegate = self;
    _popOverController = [[UIPopoverController alloc] initWithContentViewController:_materialsViewController];
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
        cell.enumViewType = SOD;
    }
    
    if (!_isEditable) {
        cell.txtFieldActualCount.enabled = NO;
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
    
    [cell setData:indexPath.row :colorID];
    return cell;
}

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
    return 54;
}
    
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 54)];
    viewFooter.backgroundColor = COLOR_THEME;
    
    UITextField *txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 200, 44)];
    txtFieldMatID.placeholder = @" Enter Material ID";
    txtFieldMatID.backgroundColor = [UIColor whiteColor];
    txtFieldMatID.delegate = self;
    txtFieldMatID.tag = 10001;
    [viewFooter addSubview:txtFieldMatID];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 5, 5, 75, 44);
    [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor whiteColor]];
    [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
    [viewFooter addSubview:btnAdd];
    
    UIImageView *imgViewBarCode = [[UIImageView alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 5, 5, 162, 44)];
    imgViewBarCode.image = [UIImage imageNamed:@"barcode.png"];
    [viewFooter addSubview:imgViewBarCode];
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSubmit.frame = CGRectMake(viewFooter.frame.size.width - 130, 5, 150, 44);
    [btnSubmit addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setBackgroundColor:[UIColor whiteColor]];
    [btnSubmit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnSubmit setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [viewFooter addSubview:btnSubmit];
    
    return viewFooter;
}
    
- (void)submitButtonClicked {
    _confirmFlag = TRUE;
    
    int flag = 0;
    for (int i=0; i<[arrOrders count]; i++) {
        NSDictionary *dict = [arrOrders objectAtIndex:i];
        if (enteredValues[i] != [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue] && acceptedValues[i] != 1) {
            flag = 1;
        }
    }
    
    if (flag == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check the discrepancies." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You may proceed to the next section." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        _isEditable = FALSE;
        [alert show];
    }
    [self.tableView reloadData];
}

- (void)addButtonClicked {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_isEditable) return NO;
        
    if (textField.tag == 10001) {
        CGRect rectP = textField.frame;
        _popOverController.popoverContentSize = CGSizeMake(200, 200);
        [_popOverController presentPopoverFromRect:rectP inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        return NO;
    }
    return YES;
}

- (void)materialSelected:(NSString *)strMaterialID {
    [_popOverController dismissPopoverAnimated:YES];
    if (![strMaterialID isEqualToString:@""]) {
        for (int i = 0; i < [arrOrders count]; i++) {
            NSDictionary *dict = [arrOrders objectAtIndex:i];
            if ([strMaterialID isEqualToString:[dict valueForKey:JSONTAG_MAT_NO]]) {
                enteredValues[i] += 1;
                [self.tableView reloadData];
                return;
            }
        }
    }
}
@end
