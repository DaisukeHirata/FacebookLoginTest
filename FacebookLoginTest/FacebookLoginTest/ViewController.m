//
//  ViewController.m
//  FacebookLoginTest
//
//  Created by Daisuke Hirata on 5/17/15.
//  Copyright (c) 2015 Daisuke Hirata. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController () <FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    self.loginButton.delegate = self;
    
    self.tokenLabel.numberOfLines = 0;
    [self.tokenLabel sizeToFit];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error
{
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    
    if (!error) {
        if (!result.isCancelled) {
            // success
            NSLog(@"login %@", accessToken.tokenString);
            self.tokenLabel.text = accessToken.tokenString;
        } else {
            // canceled
            NSLog(@"login canceled");
        }
    } else {
        // error
        NSLog(@"login error");
    }
    
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"logout");
    self.tokenLabel.text = @"";
}

@end
