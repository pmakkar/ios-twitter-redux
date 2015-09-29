//
//  TweetCell.h
//  Twitter
//
//  Created by Puneet Makkar on 9/23/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>
- (void) tweetCell:(TweetCell *)cell didImageClick:(BOOL)value;
@end

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (nonatomic, assign) BOOL imageClicked;

-(void)setTweet:(Tweet *)tweet;

@end
