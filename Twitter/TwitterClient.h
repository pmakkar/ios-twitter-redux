//
//  TwitterClient.h
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL: (NSURL *)url;
- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void) favoriteTweet: (Tweet *)tweet;
- (void) unfavoriteTweet: (Tweet *)tweet;
- (void) retweetTweet: (Tweet *)tweet;
- (void) replyToTweet: (Tweet *)tweet withString: (NSString *) replyText;
- (void) tweetWithString: (NSString *) tweetText;


@end
