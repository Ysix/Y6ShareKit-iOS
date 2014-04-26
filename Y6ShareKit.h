//
//  Y6ShareKit.h
//
//  Created by Ysix on 26/04/14.
//
//

#import <Foundation/Foundation.h>

// Need - MessageUI.framework
//      - Social.framework
//      - FacebookSDK
//      - Tweeter.framework

// iOS 6.0 and later

// the text for closing the webview presented in modal
#define CLOSE_BUTTON_TITLE @"Close"

@protocol MFMailComposeViewControllerDelegate;
@protocol MFMessageComposeViewControllerDelegate;

@interface Y6ShareKit : NSObject

/**
 *  Test if the device can send a SMS
 *
 *  @return YES if the device is able to send a SMS
 */
+ (BOOL)canSendSMS;

/**
 *  Present a modal ViewController for sending a sms
 *
 *  @param message                The default message of the sms.
 *  @param contacts               An array of strings containing the initial recipients of the message.
 *  @param messageComposeDelegate Any object that implement the MFMessageComposeViewControllerDelegate.
 *  @param vc                     The source ViewController which prensent the modal ViewController.
 *
 *  @return a booleen set to YES if the modal ViewController has been shown
 */
+ (BOOL)sendSMSwithContent:(NSString *)message toNumbers:(NSArray *)contacts andSetMessageComposeDelegate:(id <MFMessageComposeViewControllerDelegate>)messageComposeDelegate fromViewController:(UIViewController *)vc;

/**
 *  Test if the device can send a mail
 *
 *  @return YES if the device is able to send a mail
 */
+ (BOOL)canSendMail;


/**
 *  Present a modal ViewController for sending a mail
 *
 *  @param message             The default message of the mail
 *  @param contacts               An array of strings containing the initial recipients of the message.
 *  @param messageComposeDelegate Any object that implement the MFMailComposeViewControllerDelegate.
 *  @param vc                  The source ViewController which prensent the modal ViewController.
 *
 *  @return a booleen set to YES if the modal ViewController has been shown
 */
+ (BOOL)sendMailwithContent:(NSString *)message toAdresses:(NSArray *)contacts andSetMailComposeDelegate:(id <MFMailComposeViewControllerDelegate>)mailComposeDelegate fromViewController:(UIViewController *)vc;

/**
 *  Test if the device can send a tweet
 *
 *  @return YES if the device is able to send a Tweet
 */
+ (BOOL)canSendStatusOnTwitter;

/**
 *  Present a modal ViewController for sending a tweet
 *  Starting by testing if the user has set is Twitter Account in the settings app, otherwise, it will present a webview with the twitter website.
 *
 *  @param status the default text of the Tweet
 *  @param vc     The source ViewController which prensent the modal ViewController.
 */
+ (void)shareStatusOnTwitter:(NSString *)status fromViewController:(UIViewController *)vc;

/**
 *  Description
 *
 *  @param link The link you want to share
 *
 *  @return YES if the device is able to send the link on facebook
 */
+ (BOOL)canShareLinkOnFacebook:(NSString *)link;

/**
 *  Present a modal ViewController for sharing the link
 *  Starting by testing if the user has the Facebook App on his phone, otherwise if the user has set is Facebook Account in the settings app.
 *
 *  @param link The link you want to share
 *  @param vc   The source ViewController which prensent the modal ViewController.
 */
+ (void)shareLinkOnFaceBook:(NSString *)link fromViewController:(UIViewController *)vc;


@end
