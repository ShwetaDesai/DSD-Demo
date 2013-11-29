//
//  SODPaletteViewController.m
//  DSD Demo
//
//  Created by Radhika Bhangaonkar on 28/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "SODPaletteViewController.h"
#import "SODPaletteCustomTableCell.h"


@interface SODPaletteViewController ()

@end

@implementation SODPaletteViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [arrOrders count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}


#pragma mark - Custom Methods
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 54;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 54)];
    viewFooter.backgroundColor = COLOR_THEME;
    
    txtFieldPaletteID = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 200, 44)];
    txtFieldPaletteID.placeholder = @" Enter Palette ID";
    txtFieldPaletteID.backgroundColor = [UIColor whiteColor];
    txtFieldPaletteID.delegate = self;
    txtFieldPaletteID.tag = 10001;
    [viewFooter addSubview:txtFieldPaletteID];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(txtFieldPaletteID.frame.origin.x + txtFieldPaletteID.frame.size.width + 5, 5, 75, 44);
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

- (SODPaletteCustomTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SODPaletteCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        //        cell = [[SODCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[SODPaletteCustomTableCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setExclusiveTouch:YES];
        
    }    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    sodViewController = [[SODViewControllerViewController alloc] initWithStyle:UITableViewStylePlain];
    sodViewController.view.frame = CGRectMake(x_Pos, y_Pos, tableWidth, 650);
    [self.navigationController pushViewController:sodViewController animated:YES];
    
}


- (void)submitButtonClicked {
   
}

- (void)addButtonClicked {
    

}

- (void)btnBarCodeBtnClicked {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Starting the scanner...." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL", nil];
    [alert show];
}


@end
