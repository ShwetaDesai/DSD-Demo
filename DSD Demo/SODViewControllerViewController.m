//
//  SODViewControllerViewController.m
//  NewProject
//
//  Created by ITIM Quinnox on 30/10/13.
//  Copyright (c) 2013 q-systems@quinnox.com. All rights reserved.
//

#import "SODViewControllerViewController.h"
#import "SODCustomTableCell.h"

@interface SODViewControllerViewController () {
    NSString *palletID;
    NSMutableArray *arrMaterialsFinal;
}

@end

@implementation SODViewControllerViewController
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
    
    txtFieldMatID = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 200, 44)];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check the discrepancies." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You may proceed to the next section." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        _isEditable = FALSE;
        [alert show];
    }
    [self.tableView reloadData];
}

- (void)addButtonClicked {
    for (int i = 0; i < [arrOrders count]; i++) {
        NSDictionary *dict = [arrOrders objectAtIndex:i];
        if ([txtFieldMatID.text isEqualToString:[dict valueForKey:JSONTAG_MAT_NO]]) {
            enteredValues[i] += 1;
            [self.tableView reloadData];
            return;
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The selected product does not match any products from the Orders list. Please select some other product." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_isEditable) return NO;
        
//    if (textField.tag == 10001) {
//        CGRect rectP = textField.frame;
//        _popOverController.popoverContentSize = CGSizeMake(200, 200);
//        [_popOverController presentPopoverFromRect:rectP inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        return NO;
//    }
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

- (void)btnBarCodeBtnClicked {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Starting the scanner...." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL", nil];
    //    [alert show];
    [self.view.layer addSublayer:_prevLayer];
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil) {
            //NOTE : Use the Barcode Value
        }
        else {
            //NOTE : No barcode detected
        }
    }
    
    [_session stopRunning];
    [_prevLayer removeFromSuperlayer];
}

- (void)initBarCode {
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}


-(void)displayPalletID:(NSNotification *)notification
{
    palletID = [notification object];
    NSLog(@"Pallet ID %@", palletID);
    
    [self setUpData];
}

-(void)setUpData{
    
    // NSLog(@"Order array : %@", arrOrders);
    
    arrMaterialsFinal = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [arrOrders count]; i++) {
        NSDictionary *dict = [arrOrders objectAtIndex:i];
        if ([palletID isEqualToString:[dict valueForKey:JSONTAG_PALLET_NO]])
        {
            [arrMaterialsFinal addObject:[arrOrders objectAtIndex:i]];
            //NSLog(@"Material Array %@", arrMaterialsFinal);
        }
    }
    
}
@end
