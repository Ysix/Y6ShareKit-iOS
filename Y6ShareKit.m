//
//  Y6ShareKit.m
//
//  Created by Ysix on 26/04/14.
//
//

#import "Y6ShareKit.h"
//#import <FacebookSDK/FacebookSDK.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/TWTweetComposeViewController.h>
#import <Social/Social.h>

@implementation Y6ShareKit

+ (void)openModalViewControllerWithWebSite:(NSString *)urlString andTitle:(NSString *)title onViewController:(UIViewController *)vc
{
    UIViewController *modalVC = [[UIViewController alloc] init];
    
    // config Toolbar
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
    UIToolbar* barreOutilsTop= [UIToolbar new];
    [barreOutilsTop sizeToFit];
    barreOutilsTop.frame = CGRectMake(0, 0, vc.view.frame.size.width, 35);
 
    UIBarButtonItem *bouton1 =  [[UIBarButtonItem alloc] initWithTitle:CLOSE_BUTTON_TITLE style:UIBarButtonItemStyleBordered target:vc action:@selector(dismissModalViewControllerAnimated:)];
	UIBarButtonItem *espaceFlexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    NSArray *elements = [NSArray arrayWithObjects:toolBarTitle, espaceFlexible, bouton1,nil];

    [barreOutilsTop setItems:elements animated:NO];
	[modalVC.view addSubview:barreOutilsTop];
    
    
    // Config WebView
    
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [webView setScalesPageToFit:YES];
    [webView setFrame:CGRectMake(0, 35, vc.view.frame.size.width, vc.view.frame.size.height - 35)];
    [modalVC.view addSubview:webView];
    
    [vc presentViewController:modalVC animated:YES completion:nil];
}


+ (BOOL)canSendSMS
{
    return [MFMessageComposeViewController canSendText];
}

+ (BOOL)sendSMSwithContent:(NSString *)message toNumbers:(NSArray *)contacts andSetMessageComposeDelegate:(id<MFMessageComposeViewControllerDelegate>)messageComposeDelegate fromViewController:(UIViewController *)vc
{
    if ([MFMessageComposeViewController canSendText])
    {
        
        MFMessageComposeViewController *smsVC = [[MFMessageComposeViewController alloc] init];
        
        [smsVC setBody:message];
        if (contacts && [contacts count] > 0)
            [smsVC setRecipients:contacts];
        if (messageComposeDelegate)
            [smsVC setMessageComposeDelegate:messageComposeDelegate];
        
        [vc presentViewController:smsVC animated:YES completion:nil];
        return YES;
    }
    return NO;
}

+ (BOOL)canSendMail
{
    return [MFMailComposeViewController canSendMail];
}

// TODO: add parameter to set the subject of the mail too

+ (BOOL)sendMailwithContent:(NSString *)message toAdresses:(NSArray *)contacts andSetMailComposeDelegate:(id)mailComposeDelegate fromViewController:(UIViewController *)vc
{
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        
        [mailVC setMessageBody:message isHTML:NO];
        if (contacts && [contacts count] > 0)
            [mailVC setToRecipients:contacts];

		[mailVC setSubject:@"Application Startup Assembly"];
        if (mailComposeDelegate)
        {
            [mailVC setMailComposeDelegate:mailComposeDelegate];
        }
        
        [vc presentViewController:mailVC animated:YES completion:nil];
        return YES;
    }
    return NO;
}

+ (BOOL)canSendStatusOnTwitter
{
    return YES;
}

// TODO: add parameters to share more things (pictures, link, ...)

+ (void)shareStatusOnTwitter:(NSString *)status fromViewController:(UIViewController *)vc
{
// TODO: Use the social framework, Tweeter framework is deprecated
    
    if (NSClassFromString(@"TWTweetComposeViewController") && [TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *TWcvc = [[TWTweetComposeViewController alloc] init];
        
        [TWcvc setInitialText:status];

        TWcvc.completionHandler = ^(TWTweetComposeViewControllerResult res) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        [vc presentViewController:TWcvc animated:YES completion:nil];
    }
    else
    {
        [self openModalViewControllerWithWebSite:[[NSString stringWithFormat:@"https://twitter.com/intent/tweet?source=webclient&text=%@", status] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] andTitle:@"Twitter" onViewController:vc];
    }
}

+ (BOOL)canShareTextOnFaceBook:(NSString *)text withLink:(NSString *)link
{
	// implement in category for facebook sdk

//    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
//    params.link = [NSURL URLWithString:link];
//    
//    if ([FBDialogs canPresentShareDialogWithParams:params])
//        return YES;

    if ((NSClassFromString(@"SLComposeViewController") && [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]))
        return YES;
    
    return NO;
}

// TODO: add parameters to share more things (pictures, status, ...)

+ (void)shareTextOnFaceBook:(NSString *)text withLink:(NSString *)link fromViewController:(UIViewController *)vc
{

	// implement in category for facebook sdk

//    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
//    params.link = [NSURL URLWithString:link];

//    if ([FBDialogs canPresentShareDialogWithParams:params])
//    {
//        [FBDialogs presentShareDialogWithParams:params clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//            
//// TODO: handle the error
//            
//        }];
//    }
//    else
	if (NSClassFromString(@"SLComposeViewController") && [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *cvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [cvc setInitialText:text];
		if (link)
			[cvc addURL:[NSURL URLWithString:link]];
        cvc.completionHandler = ^(SLComposeViewControllerResult res) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        [vc presentViewController:cvc animated:YES completion:nil];

    }
}

@end
