//
//  SODPaletteViewController.m
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "SODPaletteViewController.h"
#import "SODPaletteCustomTableCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface SODPaletteViewController (){
    SODPaletteCustomTableCell *sodPalletCustomTableCell;
    AppDelegate *objDelegate;
    NSString *PalletID;
}

@end

@implementation SODPaletteViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        _confirmFlag = FALSE;
        _isEditable = TRUE;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sodPalletCustomTableCell = [[SODPaletteCustomTableCell alloc] init];
    [self initBarCode];
    self.tableView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeImage:) name:nMaterialScanCompleted object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [palletIDs count];
}

- (SODPaletteCustomTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    SODPaletteCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (!cell){
        //        cell = [[SODCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[SODPaletteCustomTableCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setExclusiveTouch:YES];
        
    }
    
   
    [cell setPalletID:indexPath.row];
    
    objDelegate = [[AppDelegate alloc]init];
    NSMutableArray *tempArray = [objDelegate getImageForPallet];
    NSNumber *isChecked =(NSNumber*)[tempArray objectAtIndex:indexPath.row];
    if([isChecked boolValue]){
        [[cell imgViewCheckbox] setImage:[UIImage imageNamed:@"check.png"]];
    }
    else
    {
       [[cell imgViewCheckbox] setImage:[UIImage imageNamed:@"uncheck.png"]];
    }
    
            
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SODPaletteCustomTableCell *cell = (SODPaletteCustomTableCell*) [tableView cellForRowAtIndexPath:indexPath];
    NSString *palletID = cell.lblPaletteId.text;
    NSLog(@"ID ::: %@", palletID);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:nPalleteDetailScreenCalled object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:nPassingPalletID object:palletID];
    
}

#pragma mark - Custom Methods
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 99;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 54)];
    viewFooter.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0];
    
    UIView *viewFooterHeadings = [[UIView alloc] initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 44)];
    viewFooterHeadings.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    [viewFooter addSubview:viewFooterHeadings];
    
    
    UIView *viewFooterSeperator = [[UIView alloc]initWithFrame:CGRectMake(10, 98, 790, 1)];
    viewFooterSeperator.backgroundColor = [UIColor whiteColor];
    [viewFooter addSubview:viewFooterSeperator];
    
    UILabel *lblPalette = [[UILabel alloc] initWithFrame:CGRectMake(30,10,100, 20)];
    [lblPalette setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblPalette.backgroundColor = [UIColor clearColor];
    [lblPalette setText:@"Pallet"];
    [viewFooterHeadings addSubview:lblPalette];
    
    UILabel *lblPaletteID = [[UILabel alloc] initWithFrame:CGRectMake(125,10,100, 20)];
    [lblPaletteID setTextColor:[UIColor colorWithRed:236.0/255.0 green:179.0/255.0 blue:93.0/255.0 alpha:1.0]];
    lblPaletteID.backgroundColor = [UIColor clearColor];
    [lblPaletteID setText:@"Pallet ID"];
    [viewFooterHeadings addSubview:lblPaletteID];
    
    txtFieldPaletteID = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 225, 44)];
    txtFieldPaletteID.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtFieldPaletteID.layer.borderWidth= 1.0f;
    [txtFieldPaletteID setTextAlignment:NSTextAlignmentCenter];
    txtFieldPaletteID.placeholder = @" Enter/Scan Pallet Number";
    txtFieldPaletteID.text = @"1456789023456950019";
    [txtFieldPaletteID setValue:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldPaletteID setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    txtFieldPaletteID.backgroundColor = [UIColor clearColor];
    txtFieldPaletteID.delegate = self;
    txtFieldPaletteID.tag = 10001;
    [viewFooter addSubview:txtFieldPaletteID];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(txtFieldPaletteID.frame.origin.x + txtFieldPaletteID.frame.size.width + 10, 5, 75, 44);
    [btnAdd addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnAdd setTitle:@"ADD" forState:UIControlStateNormal];
    btnAdd.font = [UIFont boldSystemFontOfSize:14.0];
    [viewFooter addSubview:btnAdd];
    
    UIButton *btnBarCode = [[UIButton alloc] initWithFrame:CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 10, 5, 64, 44)];
    [btnBarCode setBackgroundImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
    [btnBarCode addTarget:self action:@selector(btnBarCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewFooter addSubview:btnBarCode];
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSubmit.frame = CGRectMake(viewFooter.frame.size.width - 145, 5, 150, 44);
    [btnSubmit addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:155.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSubmit setTitle:@"CONFIRM" forState:UIControlStateNormal];
    btnSubmit.font = [UIFont boldSystemFontOfSize:14.0];
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

- (void)addButtonClicked
{
   for(int i=0; i< [palletIDs count]; i++)
   {
    
        if([txtFieldPaletteID.text isEqual:[palletIDs objectAtIndex:i]])
        {
             NSLog(@"Match Found !");
             NSMutableArray *arrTemp = [objDelegate getImageForPallet];
            [arrTemp replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
            [objDelegate setImageForPallet:arrTemp];
            
            break;
            
        }
    }
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_isEditable) return NO;
    return YES;
}


- (void)btnBarCodeBtnClicked {
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

-(void)ChangeImage:(NSNotification *)notification{
    
    PalletID = [notification object];
   // NSLog(@"Pallet ID %@", PalletID);
    
    
    //BOOL isChecked = NO;
    /* checking whether the Pallete is already scanned */
    for (int i=0; i<[palletIDs count]; i++) {
        if ([[palletIDs objectAtIndex:i] isEqualToString:PalletID]) {
            //isChecked = [[palletImageCheck objectAtIndex:i] boolValue];
            NSMutableArray *arrTemp = [objDelegate getImageForPallet];
            [arrTemp replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
            [objDelegate setImageForPallet:arrTemp];
            break;
        }
    }
    [self.tableView reloadData];
}


@end
