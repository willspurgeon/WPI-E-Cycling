//
//  ComposeMessageViewController.h
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 12/9/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ComposeMessageViewController : UIViewController <UITextViewDelegate, NSURLConnectionDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *messageView;
@property (strong, nonatomic) NSMutableData *data;

- (IBAction)cancel:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
