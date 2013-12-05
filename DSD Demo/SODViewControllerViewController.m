//
//  SODViewControllerViewController.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "SODViewControllerViewController.h"
#import "SODCustomTableCell.h"

@interface SODViewControllerViewController (){
    
    
    NSMutableArray *arrMaterialsFinal;
    NSMutableArray *arrMaterialFinalIndex;
}

@end

@implementation SODViewControllerViewController
@synthesize palletID;
NSString *arrMaterials1[5] = {@"380003", @"380004", @"380136", @"400760", @"401760"};

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

-(void)setUpData{
    
    NSLog(@"Pallet ID in setupdata : %@", palletID);
    
    arrMaterialsFinal = [[NSMutableArray alloc]init];
    arrMaterialFinalIndex = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [arrOrders count]; i++) {
        NSDictionary *dict = [arrOrders objectAtIndex:i];
        NSLog(@"Value from json : %@", [dict valueForKey:JSONTAG_PALLET_NO]);
        if ([palletID isEqualToString:[dict valueForKey:JSONTAG_PALLET_NO]])
        {
            [arrMaterialsFinal addObject:[arrOrders objectAtIndex:i]];
            [arrMaterialFinalIndex addObject:[NSNumber numberWithInt:i]];
            NSLog(@"Material Array %@", arrMaterialsFinal);
            
        }
    }
    [self.tableView reloadData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayPalletID:) name:nPassingPalletID object:nil];
    
    //    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    
    _materialsViewController = [[MaterialsViewController alloc] initWithStyle:UITableViewStylePlain];
    _materialsViewController.parentDelegate = self;
    _popOverController = [[UIPopoverController alloc] initWithContentViewController:_materialsViewController];
    
    [self setUpData];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return YES;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrMaterialsFinal count];
    NSLog(@"count of array %d", [arrMaterialsFinal count]);
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0]];
}

- (SODCustomTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SODCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        
        cell = [[SODCustomTableCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setExclusiveTouch:YES];
        cell.enumViewType = SOD;
        
    }
    
    if (!_isEditable) {
        cell.txtFieldActualCount.enabled = NO;
    }
    // Configure the cell...
    NSDictionary *dict = [arrMaterialsFinal objectAtIndex:indexPath.row];
    
    int colorID = 0;
    
//    if (isChecked) {
//        NSLog(@"isChecked true");
//        enteredValues[indexPath.row] = [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue];
//    }
    
    BOOL isChecked = NO;
    /* checking whether the Pallete is already scanned */
    for (int i=0; i<[palletIDs count]; i++) {
        if ([[palletIDs objectAtIndex:i] isEqualToString:palletID]) {
            isChecked = [[palletImageCheck objectAtIndex:i] boolValue];
            break;
        }
    }

    if (_confirmFlag) {
        if (enteredValues[indexPath.row] == [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue] || isChecked) {
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
    
    //[cell setData:indexPath.row :colorID isCheckedValue:isChecked];
    NSNumber *index = (NSNumber*)[arrMaterialFinalIndex objectAtIndex:indexPath.row];
    [cell setData:[index intValue] :colorID :isChecked];
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
    return 164;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 44)];
    viewFooter.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    
    UIView *viewFooterHeadings = [[UIView alloc] initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 120)];
    viewFooterHeadings.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0];
    [viewFooter addSubview:viewFooterHeadings];
    //colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0
    
    UIView *viewFooterTableHeadings = [[UIView alloc] initWithFrame:CGRectMake(0, 77, self.view.frame.size.width, 43)];
    viewFooterTableHeadings.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    [viewFooterHeadings addSubview:viewFooterTableHeadings];
    
    UIView *viewFooterSeperator = [[UIView alloc]initWithFrame:CGRectMake(10, 120, 790, 1)];
    viewFooterSeperator.backgroundColor = [UIColor blackColor];
    [viewFooterHeadings addSubview:viewFooterSeperator];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnBack.frame = CGRectMake(10 , 15, 62, 23);
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]]];
    [btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewFooter addSubview:btnBack];
    
    
    UILabel *lblPaletteDetail = [[UILabel alloc] initWithFrame:CGRectMake(450,15,150, 20)];
    [lblPaletteDetail setTextColor:[UIColor colorWithRed:244.0/255.0 green:215.0/255.0 blue:160.0/255.0 alpha:1.0]];
    lblPaletteDetail.backgroundColor = [UIColor clearColor];
    [lblPaletteDetail setText:@"Detailed Mode :"];
    [viewFooter addSubview:lblPaletteDetail];
    
    UILabel *lblPaletteDetailID = [[UILabel alloc] initWithFrame:CGRectMake(575,15,200, 20)];
    [lblPaletteDetailID setTextColor:[UIColor colorWithRed:244.0/255.0 green:215.0/255.0 blue:160.0/255.0 alpha:1.0]];
    lblPaletteDetailID.backgroundColor = [UIColor clearColor];
    [lblPaletteDetailID setText:palletID];
    [viewFooter addSubview:lblPaletteDetailID];
    
    
    UILabel *lblMaterial = [[UILabel alloc] initWithFrame:CGRectMake(10,90,100, 20)];
    [lblMaterial setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblMaterial.backgroundColor = [UIColor clearColor];
    [lblMaterial setText:@"Material"];
    [viewFooterHeadings addSubview:lblMaterial];
    
    UILabel *lblActualQuantity = [[UILabel alloc] initWithFrame:CGRectMake(300,90,300, 20)];
    [lblActualQuantity setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblActualQuantity.backgroundColor = [UIColor clearColor];
    [lblActualQuantity setText:@"Actual Quantity"];
    [viewFooterHeadings addSubview:lblActualQuantity];
    
    UILabel *lblExpectedQuantity = [[UILabel alloc] initWithFrame:CGRectMake(600,90,300, 20)];
    [lblExpectedQuantity setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblExpectedQuantity.backgroundColor = [UIColor clearColor];
    [lblExpectedQuantity setText:@"Expected Quantity"];
    [viewFooterHeadings addSubview:lblExpectedQuantity];
    
    
    txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(10, 15, 230, 44)];
    txtFieldMatID.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtFieldMatID.layer.borderWidth= 1.0f;
    [txtFieldMatID setTextAlignment:NSTextAlignmentCenter];
    txtFieldMatID.placeholder = @" Enter/Scan Material Number";
    [txtFieldMatID setValue:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldMatID setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    txtFieldMatID.backgroundColor = [UIColor clearColor];
    txtFieldMatID.delegate = self;
    txtFieldMatID.tag = 10001;
    [viewFooterHeadings addSubview:txtFieldMatID];
    
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(txtFieldMatID.frame.origin.x + txtFieldMatID.frame.size.width + 10, 15, 75, 44);
    [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
    [viewFooterHeadings addSubview:btnAdd];
    
    
    UIButton *btnBarCode = [[UIButton alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 10, 15, 64, 44)];
    [btnBarCode setBackgroundImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
    [btnBarCode addTarget:self action:@selector(barCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewFooterHeadings addSubview:btnBarCode];
    
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSubmit.frame = CGRectMake(viewFooter.frame.size.width - 145, 15, 150, 44);
    [btnSubmit addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSubmit setTitle:@"CONFIRM" forState:UIControlStateNormal];
    
    [viewFooterHeadings addSubview:btnSubmit];
    
    return viewFooter;
}

-(void)backButtonClicked{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nBackButtonPressed object:nil];
    
}

- (void)submitButtonClicked {
    _confirmFlag = TRUE;
    
    BOOL isChecked = NO;
    /* checking whether the Pallete is already scanned */
    for (int i=0; i<[palletIDs count]; i++) {
        if ([[palletIDs objectAtIndex:i] isEqualToString:palletID]) {
            isChecked = [[palletImageCheck objectAtIndex:i] boolValue];
            break;
        }
    }
    
    int flag = 0;
    for (int i=0; i<[arrMaterialFinalIndex count]; i++) {
//        NSDictionary *dict = [arrMaterialsFinal objectAtIndex:i];
        NSDictionary *dict = [arrOrders objectAtIndex:[[arrMaterialFinalIndex objectAtIndex:i] intValue]];
        NSLog(@"Count %d",[[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue]);
        NSLog(@"Entered Value %d", [[dict valueForKey:JSONTAG_USER_ENTERED] intValue]);
        //        if (enteredValues[[[arrMaterialFinalIndex objectAtIndex:i] intValue]] != [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue] && acceptedValues[[[arrMaterialFinalIndex objectAtIndex:i] intValue]] != 1) {

      if ([[dict valueForKey:JSONTAG_USER_ENTERED] intValue] != [[dict valueForKey:JSONTAG_EXTFLD4_COUNT] intValue] && acceptedValues[[[arrMaterialFinalIndex objectAtIndex:i] intValue]] != 1){
            flag = 1;
        }
    }
    
    
    if (flag == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check the discrepancies." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You may proceed to the next section." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        _isEditable = FALSE;
//        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:nMaterialScanCompleted object:palletID];
        [[NSNotificationCenter defaultCenter] postNotificationName:nNavigateBackToPalletScreen object:nil];
    }
    [self.tableView reloadData];
}

- (void)addButtonClicked {
    for (int i = 0; i < [arrMaterialFinalIndex count]; i++) {
//        NSDictionary *dict = [arrMaterialsFinal objectAtIndex:i];
        NSDictionary *dict = [[arrOrders objectAtIndex:[[arrMaterialFinalIndex objectAtIndex:i] intValue]] mutableCopy];
        NSLog(@"dict :: %@", dict);
        if ([txtFieldMatID.text isEqualToString:[dict valueForKey:JSONTAG_MAT_NO]]) {
//            enteredValues[[[arrMaterialFinalIndex objectAtIndex:i] intValue]] += 1;
            int userEntered = [[dict valueForKey:JSONTAG_USER_ENTERED] intValue];
            userEntered++;
            [dict setValue:[NSString stringWithFormat:@"%d", userEntered] forKey:JSONTAG_USER_ENTERED];
            [arrOrders replaceObjectAtIndex:[[arrMaterialFinalIndex objectAtIndex:i] intValue] withObject:dict];

            [self.tableView reloadData];
            return;
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The selected product does not match any products from the Orders list. Please select some other product." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_isEditable) return NO;

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

- (void)barCodeBtnClicked{
    //initialize the reader and provide some config instructions
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    [reader.scanner setSymbology: ZBAR_I25
                          config: ZBAR_CFG_ENABLE
                              to: 1];
    reader.readerView.zoom = 1.0; // define camera zoom property
    
    //show the scanning/camera mode
    [self presentModalViewController:reader animated:YES];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info {
    
    //this contains your result from the scan
    id results = [info objectForKey: ZBarReaderControllerResults];
    
    //create a symbol object to attach the response data to
    ZBarSymbol *symbol = nil;
    
    //add the symbol properties from the result
    //so you can access it
    for(symbol in results){
        
        //symbol.data holds the value
        NSString *upcString = symbol.data;
        
        //print to the console
        NSLog(@"the value of the scanned UPC is: %@",upcString);
        
        NSMutableString *message = [[NSMutableString alloc]init];
        
        
        [message appendString:[NSString stringWithFormat:@"%@ ",
                               upcString]];
        
        NSLog(@"Barcode is : %@", message);
        
        [self addMaterialBarcodeScanning:upcString];
        
        //Create UIAlertView alert
        //        UIAlertView  *alert = [[UIAlertView alloc]
        //                               initWithTitle:@"Product Barcode" message: message delegate:self
        //                               cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        //
        //        [alert show];
        //        //After some time
        //        [alert dismissWithClickedButtonIndex:0 animated:TRUE];
        
        //make the reader view go away
        [reader dismissModalViewControllerAnimated: YES];
    }
    
}

-(void)displayPalletID:(NSNotification *)notification
{
    palletID = [notification object];
    NSLog(@"Pallet ID %@", palletID);
    
    [self setUpData];
}

-(void)addMaterialBarcodeScanning:(NSMutableString*)strBarcode{
    
    for (int i = 0; i < [arrMaterialFinalIndex count]; i++) {
        //        NSDictionary *dict = [arrMaterialsFinal objectAtIndex:i];
        NSDictionary *dict = [[arrOrders objectAtIndex:[[arrMaterialFinalIndex objectAtIndex:i] intValue]] mutableCopy];
        NSLog(@"dict :: %@", dict);
        if ([strBarcode isEqualToString:[dict valueForKey:JSONTAG_MAT_NO]]) {
            //            enteredValues[[[arrMaterialFinalIndex objectAtIndex:i] intValue]] += 1;
            int userEntered = [[dict valueForKey:JSONTAG_USER_ENTERED] intValue];
            userEntered++;
            [dict setValue:[NSString stringWithFormat:@"%d", userEntered] forKey:JSONTAG_USER_ENTERED];
            [arrOrders replaceObjectAtIndex:[[arrMaterialFinalIndex objectAtIndex:i] intValue] withObject:dict];
            
            [self.tableView reloadData];
            return;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The selected product does not match any products from the Orders list. Please select some other product." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
