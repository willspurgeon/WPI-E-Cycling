//
//  boxImageController.m
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 12/8/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    //
    //detailLabel = [[UILabel alloc]init];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        [boxImage.layer setBorderColor:[UIColor blackColor].CGColor];
        [boxImage.layer setShadowColor:[UIColor blackColor].CGColor];
    } else {
        // Load resources for iOS 7 or later
        [detailPageView setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem.backBarButtonItem setTitle:@"Map"];
    
    NSLog(@"Info: %@", detailLabel.text);
    
    [detailLabel setText:[NSString stringWithFormat:@"A box can be found by %@.", [_location valueForKey:@"info"]]];
    NSLog(@"Info: %@", detailLabel.text);
    [detailLabel sizeToFit];
    
    //[boxImage setBackgroundColor:[UIColor darkTextColor]];
    [boxImage setAlpha:0.8];
    [boxImage.layer setCornerRadius:9];
    [boxImage.layer setMasksToBounds:YES];
    [boxImage.layer setBorderWidth:2];
    [boxImage.layer setShadowOpacity:.9];
    [boxImage.layer setShadowRadius:4];
    [boxImage.layer setShadowOffset:CGSizeMake(2, 2)];
    
    NSLog(@"Title %@", [_location valueForKey:@"label"]);

    [self.navigationItem setTitle: [_location valueForKey:@"label"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
