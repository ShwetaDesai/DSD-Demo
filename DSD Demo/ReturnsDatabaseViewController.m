//
//  ReturnsDatabaseViewController.m
//  DSD Demo
//
//  Created by Shahil Shah on 05/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "ReturnsDatabaseViewController.h"
#define COUNT_RETURNS_ITEMS     4
@interface ReturnsDatabaseViewController ()

@end

@implementation ReturnsDatabaseViewController
@synthesize parentDelegate = _parentDelegate;

NSString *arrReturnItems_[COUNT_RETURNS_ITEMS] = {@"Cooked Oil", @"Extra/Unused", @"Damaged", @"Empty"};

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
    return COUNT_RETURNS_ITEMS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = arrReturnItems_[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_parentDelegate returnsItemSelected:arrReturnItems_[indexPath.row]];
}
@end
