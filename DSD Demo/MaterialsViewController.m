//
//  MaterialsViewController.m
//  DSD Demo
//
//  Created by Shahil Shah on 04/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "MaterialsViewController.h"
#define COUNT_MATERIALS     10
@interface MaterialsViewController ()

@end

@implementation MaterialsViewController
@synthesize parentDelegate = _parentDelegate;

NSString *arrMaterials[COUNT_MATERIALS] = {@"380003", @"380004", @"380136", @"400760", @"401512", @"401760", @"404271", @"510555", @"524321", @"600020"};

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
    // Return the number of rows in the section.
    return COUNT_MATERIALS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = arrMaterials[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row > 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The selected product does not match any products from the Orders list. Please select some other product." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_parentDelegate materialSelected:@""];
    }
    else {
        [_parentDelegate materialSelected:arrMaterials[indexPath.row]];
    }
}
@end;;
