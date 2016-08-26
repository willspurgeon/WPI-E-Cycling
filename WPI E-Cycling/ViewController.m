//
//  ViewController.m
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 11/9/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController (){
    UIButton *selectedPin;
}
    

@end

@implementation ViewController

- (IBAction)tapped:(UITapGestureRecognizer*)sender {
    CGPoint tapLocation = [sender locationInView:_image];
    NSLog(@"X: %f, Y: %f", tapLocation.x, tapLocation.y);
    [detailView setHidden:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailPush"]) {
        
        // Get destination view
        DetailViewController *vc = [segue destinationViewController];
        
        NSDictionary *selectedLocation = [locations objectAtIndex:[selectedPin tag]];
        
        // Pass the information to your destination view
        vc.location = selectedLocation;
    }
}

- (IBAction)pushDetailPage:(UIButton*)sender{
    NSLog(@"Detail");
    [self performSegueWithIdentifier:@"detailPush" sender:self];
}

- (IBAction)openRecyclingWeb:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.wpi.edu/about/sustainability.html"]];
}

- (IBAction)openWPIWeb:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.wpi.edu/about/index.html"]];
}

- (IBAction)contactDev:(id)sender {
    
}

- (void)showDetailWindow:(UIButton*)sender
{
    NSDictionary *selectedLocation = [locations objectAtIndex:[sender tag]];
    selectedPin = sender;
    
    NSLog(@"%f", [sender convertPoint:sender.bounds.origin toView:nil].x);
    
    //[detailButton setBounds:CGRectMake(detailButton.bounds.origin.x, detailButton.bounds.origin.y, 29/scrollView.zoomScale, (31/scrollView.zoomScale))];
    
    [detailView setFrame:CGRectMake([sender convertPoint:sender.bounds.origin toView:nil].x-35, [sender convertPoint:sender.bounds.origin toView:nil].y-80, 180, 50)];
    
    [buildingLabel setText:[selectedLocation objectForKey:@"label"]];
    NSLog(@"%@", [selectedLocation objectForKey:@"label"]);
    [buildingLabel setTextColor:[UIColor whiteColor]];
    [buildingLabel sizeToFit];
    
    [detailView addSubview:buildingLabel];
    [detailView bringSubviewToFront:buildingLabel];
    [detailView setHidden:NO];
    [self.view bringSubviewToFront:detailView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    detailView =  [[[NSBundle mainBundle] loadNibNamed:@"detailView" owner:self options:nil]objectAtIndex:0];
    
    //[detailView setFrame:CGRectMake(0, 0, 180, 50)];
    
    //detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    //buildingLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 14, 57, 21)];
    
    [detailView setHidden:YES];
    [detailView setBackgroundColor:[UIColor darkTextColor]];
    [detailView setAlpha:0.8];
    [detailView.layer setCornerRadius:5];
    [detailView.layer setMasksToBounds:NO];
    [detailView.layer setBorderWidth:0.4];
    [detailView.layer setShadowOpacity:.9];
    [detailView.layer setShadowRadius:4];
    [detailView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [detailView.layer setShadowColor:[UIColor blackColor].CGColor];
    [detailView.layer setShadowOffset:CGSizeMake(2, 2)];
    
    [buildingLabel setContentMode:UIViewAutoresizingFlexibleWidth];
    [buildingLabel setTextColor:[UIColor whiteColor]];
    [buildingLabel setBackgroundColor:[UIColor clearColor]];
    [buildingLabel sizeToFit];
    
    //UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //[detailButton setFrame:CGRectMake(180, 10, 29, 31)];
    [detailButton addTarget:self action:@selector(pushDetailPage:) forControlEvents:UIControlEventTouchDown];
    
    [detailView addSubview:buildingLabel];
    [detailView addSubview:detailButton];
    
    [self.view addSubview:detailView];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Locations" ofType:@"plist"];
    
    locations = [[NSArray alloc] initWithContentsOfFile:path];
    
    pinButtons = [[NSMutableArray alloc]init];
    
    
    for (NSDictionary *location in locations) {
        UIImage *pinImage = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"]];
        UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [pinButton setTag:[locations indexOfObject:location]];
        [pinButton setFrame:CGRectMake([[location valueForKey:@"x"]floatValue]-10, [[location valueForKey:@"y"]floatValue]-25,30, 24.9)];
        //[pinButton setBounds:CGRectMake(0, 0, pinImage.size.width/20, pinImage.size.height/20)];
        //W: 30, H: 24.9
        //NSLog(@"Base: %f", pinButton.frame.size.height);
        [pinButton setImage:pinImage forState:UIControlStateNormal];
        //[pinButton setBounds:CGRectMake(0, 0, pinImage.size.width/10, pinImage.size.height/10)];
        [pinButton addTarget:self action:@selector(showDetailWindow:) forControlEvents:UIControlEventTouchDown];
        //[pinButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        //[pinButton setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        [pinButtons addObject:pinButton];
        
        [_image addSubview: pinButton];
        
    }
    [_image setFrame:CGRectMake(0, 0, _image.image.size.width, _image.image.size.height)];
    
    NSLog(@"Width: %f", _image.frame.size.width);
    NSLog(@"Height: %f", _image.frame.size.height);
    
    [_image setContentMode:UIViewContentModeCenter];
    
    scrollView.contentSize = _image.bounds.size;
    NSLog(@"Width: %f", scrollView.contentSize.width);
    NSLog(@"Height: %f", scrollView.contentSize.height);
    scrollView.clipsToBounds = YES;
    [scrollView setMaximumZoomScale:1.0];
    [scrollView setMinimumZoomScale:0.5];
    [scrollView setZoomScale:1];
    [scrollView setContentOffset:CGPointMake(370, 330)];
    
    [self.view sendSubviewToBack:scrollView];
    [self.view bringSubviewToFront:appInfoButton];
    
    [scrollView setScrollEnabled:YES];

    
}

- (void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        [appInfoNAvBar setBarStyle:UIBarPositionTop];
    } else {
        // Load resources for iOS 7 or later
        [appInfoNAvBar setBarStyle:UIBarPositionTopAttached];
        [WPIButton.titleLabel setTextColor:[UIColor redColor]];
        [WPIRecyclingButton.titleLabel setTextColor:[UIColor redColor]];
        NSLog(@"Coloring");
    }
    [super viewWillAppear:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [detailView setFrame:CGRectMake([selectedPin convertPoint:selectedPin.bounds.origin toView:nil].x-35, [selectedPin convertPoint:selectedPin.bounds.origin toView:nil].y-80, detailView.bounds.size.width, detailView.bounds.size.height)];
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}

-(void)scrollViewDidZoom:(UIScrollView *)currentScrollView{
    for (UIButton *pin in pinButtons) {
        [pin setBounds:CGRectMake(pin.bounds.origin.x, pin.bounds.origin.y, (30.0000)/currentScrollView.zoomScale, (24.90000/currentScrollView.zoomScale))];
    }
    [detailView setFrame:CGRectMake([selectedPin convertPoint:selectedPin.bounds.origin toView:nil].x-35, [selectedPin convertPoint:selectedPin.bounds.origin toView:nil].y-80, detailView.bounds.size.width, detailView.bounds.size.height)];
    NSLog(@"Zoom %f", [currentScrollView zoomScale]);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _image;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
