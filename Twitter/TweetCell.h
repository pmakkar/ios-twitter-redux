//
//  TweetCell.h
//  Twitter
//
//  Created by Puneet Makkar on 9/23/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

-(void)setTweet:(Tweet *)tweet;

@end
