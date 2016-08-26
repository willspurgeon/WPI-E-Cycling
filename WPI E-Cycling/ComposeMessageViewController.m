//
//  ComposeMessageViewController.m
//  WPI E-Cycling
//
//  Created by Will Spurgeon on 12/9/12.
//  Copyright (c) 2012 Will Spurgeon. All rights reserved.
//

#import "ComposeMessageViewController.h"

@interface ComposeMessageViewController ()

@end

@implementation ComposeMessageViewController

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([[_messageView text]isEqualToString:@"Touch to type message."]) {
        _messageView.text = @"";
        _messageView.textColor = [UIColor blackColor];
        [_messageView setFrame:CGRectMake(0, 50, 320, self.view.bounds.size.height - 265)];
        [_messageView setContentSize:CGSizeMake(320, self.view.bounds.size.height)];
        return YES;
    }else{
        NSLog(@"Begin edit");
        _messageView.textColor = [UIColor blackColor];
        [_messageView setFrame:CGRectMake(0, 50, 320, self.view.bounds.size.height - 265)];
        [_messageView setContentSize:CGSizeMake(320, self.view.bounds.size.height)];
        NSLog(@"Bounds: %f", self.view.bounds.size.height);
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(_messageView.text.length == 0){
        _messageView.textColor = [UIColor lightGrayColor];
        _messageView.text = @"Touch to type message.";
        [_messageView setFrame:CGRectMake(0, 50, 320, self.view.bounds.size.height + 265)];
        [_messageView resignFirstResponder];
    }
}


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
    
	[_messageView setText:@"Touch to type message."];
    [_messageView setTextColor:[UIColor lightGrayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
    NSLog(@"Data: %@",  [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding]);
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (IBAction)sendMessage:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.spurgeonworld.com/will/submitWPIAppMessage.php"];
    NSString *post = [NSString stringWithFormat:@"message=%@", _messageView.text];
    
    NSData* postVariables = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postVariables length]];
    [request setURL:url];
    [request setTimeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postVariables];
    _data = [[NSMutableData alloc]init];
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:TRUE];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(connection)
    {
        _data = [NSMutableData data];
    }
    else
    {
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
        UIAlertView *failure = [[UIAlertView alloc]init];
        [failure setTitle:@"Delivery Failure"];
        [failure setMessage:@"Your message could not be submitted for some reason. Please try again."];
        [failure dismissWithClickedButtonIndex:0 animated:YES];
        [failure addButtonWithTitle:@"Close"];
        [failure show];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
    UIAlertView *failure = [[UIAlertView alloc]init];
    [failure setTitle:@"Delivery Failure"];
    [failure setMessage:@"Your message could not be submitted for some reason. Please try again."];
    [failure dismissWithClickedButtonIndex:0 animated:YES];
    [failure addButtonWithTitle:@"Close"];
    [failure show];
    
}
@end
