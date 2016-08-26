//
//  ViewController.h
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 11/9/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>{
    //UIImageView *image;
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *pinButtons;
    NSArray *locations;
    UIView *detailView;
    __weak IBOutlet UIButton *appInfoButton;

    IBOutlet UIButton *detailButton;
    IBOutlet UILabel *buildingLabel;
    
    IBOutlet UIButton *WPIButton;
    IBOutlet UIButton *WPIRecyclingButton;
    
    __weak IBOutlet UINavigationBar *appInfoNAvBar;
    IBOutlet UIView *appInfoPage;
}

    

//@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UIImageView *image;

- (IBAction)pushDetailPage:(UIButton*)sender;
- (IBAction)openRecyclingWeb:(id)sender;
- (IBAction)openWPIWeb:(id)sender;
- (IBAction)contactDev:(id)sender;

@end
