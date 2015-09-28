//
//  LoginViewController.m
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//


#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // Modally present the tweets view
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]];
            [self presentViewController:nvc animated:YES completion:nil];
            [User currentUser];
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end