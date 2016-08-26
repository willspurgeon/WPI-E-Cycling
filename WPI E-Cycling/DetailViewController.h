//
//  DetailViewController.h
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 12/8/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{

 IBOutlet UILabel *detailLabel;
 __weak IBOutlet UINavigationBar *detailPageBar;
 IBOutlet UIView *detailPageView;
 __weak IBOutlet UIImageView *boxImage;
}

@property(nonatomic, strong)NSDictionary *location;

@end
