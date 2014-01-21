//
//  TableViewController.m
//  GetOnThatBus
//
//  Created by Andrew Webb on 1/21/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* busTableView;
}
@end

@implementation TableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CTABusReuseID"];
    cell.textLabel.text = CTABUSES[indexPath.row][@"cta_stop_name"];
    cell.detailTextLabel.text = CTABUSES[indexPath.row][@"routes"];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  CTABUSES.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath = [busTableView indexPathForCell:sender];
    DetailViewController* dvc = segue.destinationViewController;
    dvc.title = CTABUSES[indexPath.row][@"cta_stop_name"];
    dvc.CTABus = CTABUSES[indexPath.row];
}
@end
