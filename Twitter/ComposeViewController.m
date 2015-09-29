//
//  ComposeViewController.m
//  Twitter
//
//  Created by Puneet Makkar on 9/24/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//


#import "ComposeViewController.h"
#import "UIImageVIew+AFNetworking.h"
#import "User.h"
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UITextField *tweetText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tweetText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    UIBarButtonItem *rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    UIBarButtonItem *rightBarLabelItem = [[UIBarButtonItem alloc] initWithTitle:@"140" style:UIBarButtonItemStylePlain target:self action:nil];
    rightBarLabelItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightBarButtonItem, rightBarLabelItem, nil];
    
    User *currentUser = [User currentUser];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    
    self.usernameLabel.text = currentUser.screenname;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tweetText becomeFirstResponder];
}




-(void)textFieldDidChange
{
    NSLog(@"num chars: %lu", (unsigned long)self.tweetText.text.length);
    
    UIBarButtonItem *rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    UIBarButtonItem *rightBarLabelItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%lu", (140 - self.tweetText.text.length)] style:UIBarButtonItemStylePlain target:self action:nil];
    rightBarLabelItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightBarButtonItem, rightBarLabelItem, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTweet {
    [[TwitterClient sharedInstance] tweetWithString:self.tweetText.text];
    [self.navigationController popViewControllerAnimated:YES];

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
