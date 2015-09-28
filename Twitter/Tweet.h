//
//  Tweet.h
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSDate *createdAt;
@property (nonatomic,strong) User *author;

@property (nonatomic, strong) NSNumber *retweets;
@property (nonatomic, strong) NSNumber *favorites;
@property (nonatomic, strong) NSNumber *tweetId;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)tweetsWithArray:(NSArray *)array;


@end
