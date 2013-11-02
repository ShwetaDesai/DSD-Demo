//
//  DropDownOptionsViewController.m
//  DSD Demo
//
//  Created by Shahil Shah on 02/11/13.
//  Copyright (c) 2013 Quinnox. All rights reserved.
//

#import "DropDownOptionsViewController.h"

@interface DropDownOptionsViewController ()

@end

@implementation DropDownOptionsViewController
@synthesize parentDelegate = _parentDelegate, index = _index;

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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Satisfactory";
    }
    else {
        cell.textLabel.text = @"Not Satisfactory";
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [_parentDelegate optionSelected:@"Satisfactory" textFieldTag:_index];
    }
    else {
        return [_parentDelegate optionSelected:@"Not Satisfactory" textFieldTag:_index];
    }
}
@end
