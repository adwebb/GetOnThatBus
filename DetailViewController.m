//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Andrew Webb on 1/21/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    IBOutlet UILabel *addressLabel;
    
    IBOutlet UILabel *routeLabel;
    IBOutlet UILabel *transferLabel;
    
}


@end

@implementation DetailViewController
@synthesize CTABus;

- (void)viewDidLoad
{
    [super viewDidLoad];
    addressLabel.text = CTABus[@"cta_stop_name"];
    transferLabel.text = CTABus[@"inter_modal"];
    routeLabel.text = CTABus[@"routes"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
