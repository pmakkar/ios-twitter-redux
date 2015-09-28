//
//  TweetCell.m
//  Twitter
//
//  Created by Puneet Makkar on 9/23/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

//#import "NSDate+TimeAgo.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

-(void) setTweet: (Tweet *) tweet {
    
    User *author = tweet.author;
    
    NSLog(@"image url%@",author.profileImageUrl);
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:author.profileImageUrl]];
    self.usernameLabel.text = author.screenname;
    self.screenNameLabel.text = author.name;
    self.tweetLabel.text = tweet.text;
    [self.tweetLabel sizeToFit];
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
