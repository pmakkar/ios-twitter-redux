//
//  TweetViewController.m
//  Twitter
//
//  Created by Puneet Makkar on 9/23/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"


@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (assign, nonatomic) BOOL favorited;
@property (assign, nonatomic) BOOL retweeted;

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.author.profileImageUrl]];
    
    self.usernameLabel.text = self.tweet.author.name;
    self.screennameLabel.text = self.tweet.author.screenname;
    
    self.tweetLabel.text = self.tweet.text;
    [self.tweetLabel sizeToFit];
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    
    self.favoriteLabel.text = [NSString stringWithFormat:@"%@", self.tweet.favorites];
    self.retweetLabel.text = [NSString stringWithFormat:@"%@", self.tweet.retweets];
    
    self.favorited = NO;
    self.retweeted = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onFavorite:(id)sender {
    UIButton *favorite = (UIButton *)sender;
    
    if (!self.favorited) {
        [[TwitterClient sharedInstance] favoriteTweet:self.tweet];
        
        [favorite setImage:[UIImage imageNamed:@"favon"] forState:UIControlStateNormal];
        self.tweet.favorites = [NSNumber numberWithInt:[self.tweet.favorites intValue] + 1];
        
        self.favoriteLabel.text = [NSString stringWithFormat:@"%@", self.tweet.favorites];
        self.favorited = YES;
        
    } else {
        [[TwitterClient sharedInstance] unfavoriteTweet:self.tweet];
        
        [favorite setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        self.tweet.favorites = [NSNumber numberWithInt:[self.tweet.favorites intValue] - 1];
        
        self.favoriteLabel.text = [NSString stringWithFormat:@"%@", self.tweet.favorites];
        self.favorited = NO;
    }
    
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweetTweet:self.tweet];
    
    UIButton *retweet = (UIButton *)sender;
    
    if (!self.retweeted) {
        [[TwitterClient sharedInstance] favoriteTweet:self.tweet];
        
        [retweet setImage:[UIImage imageNamed:@"retweeton"] forState:UIControlStateNormal];
        self.tweet.retweets = [NSNumber numberWithInt:[self.tweet.retweets intValue] + 1];
        
        self.retweetLabel.text = [NSString stringWithFormat:@"%@", self.tweet.retweets];
        self.retweeted = YES;
        
    } else {
        
        [retweet setImage:[UIImage imageNamed:@"retweet"] forState:UIControlStateNormal];
        self.tweet.retweets = [NSNumber numberWithInt:[self.tweet.retweets intValue] - 1];
        
        self.retweetLabel.text = [NSString stringWithFormat:@"%@", self.tweet.retweets];
        self.retweeted = NO;
    }
    
}

- (IBAction)onReply:(id)sender {
    [[TwitterClient sharedInstance] replyToTweet:self.tweet withString:@"Reply Text!"];
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
