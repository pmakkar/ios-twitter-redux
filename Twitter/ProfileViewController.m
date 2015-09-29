//
//  ProfileViewController.m
//  Twitter
//
//  Created by Puneet Makkar on 9/25/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageVIew+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.navigationController.navigationBar.translucent = NO;
    if(self.userStatus!= nil) {
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.userStatus[@"profile_banner_url"]]];
        [self.profileImageView setImageWithURL:[NSURL URLWithString:self.userStatus[@"profile_image_url"]]];
        self.usernameLabel.text = self.userStatus[@"name"];
        self.screennameLabel.text = [@"@" stringByAppendingString:self.userStatus[@"screen_name"]];
        self.followersCount.text =  [NSString stringWithFormat:@"%@", self.userStatus[@"followers_count"]];
        self.followingCount.text = [NSString stringWithFormat:@"%@", self.userStatus[@"friends_count"]];
    } else {
        User *currentUser = [User currentUser];
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:currentUser.backgroundImageUrl]];
        [self.profileImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
        self.usernameLabel.text = currentUser.name;
        self.screennameLabel.text = currentUser.screenname;
        self.followersCount.text = [NSString stringWithFormat:@"%@", currentUser.followersCount];
        self.followingCount.text = [NSString stringWithFormat:@"%@",currentUser.followingCount];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
