//
//  Y6ShareKit.h
//
//  Created by Ysix on 26/04/14.
//
//

#import <Foundation/Foundation.h>

@class UIViewController;

// Need - MessageUI.framework
//      - Social.framework
//      - Twitter.framework

// iOS 6.0 and later

// the text for closing the webview presented in modal
#define CLOSE_BUTTON_TITLE @"Close"
// TODO: replace the text by an icon

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
 *  @param subject             The default subject of the mail
 *  @param message             The default message of the mail
 *  @param contacts               An array of strings containing the initial recipients of the message.
 *  @param messageComposeDelegate Any object that implement the MFMailComposeViewControllerDelegate.
 *  @param vc                  The source ViewController which prensent the modal ViewController.
 *
 *  @return a booleen set to YES if the modal ViewController has been shown
 */
+ (BOOL)sendMailwithSubject:(NSString *)subject content:(NSString *)message toAdresses:(NSArray *)contacts andSetMailComposeDelegate:(id)mailComposeDelegate fromViewController:(UIViewController *)vc;

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
 *  @param text The text you want to share
 *  @param link The link you want to share
 *
 *  @return YES if the device is able to send the text and link on facebook
 */
+ (BOOL)canShareTextOnFaceBook:(NSString *)text withLink:(NSString *)link;

/**
 *  Present a modal ViewController for sharing the text and link
 *  Starting by testing if the user has the Facebook App on his phone, otherwise if the user has set is Facebook Account in the settings app.
 *
 *  @param text The text you want to share
 *  @param link The link you want to share
 *  @param vc   The source ViewController which prensent the modal ViewController.
 */
+ (void)shareTextOnFaceBook:(NSString *)text withLink:(NSString *)link fromViewController:(UIViewController *)vc;


@end
