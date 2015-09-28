//
//  Tweet.m
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"EEE MMM D HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString:createdAtString];
        self.retweets = dictionary[@"retweet_count"];
        self.favorites = dictionary[@"favorite_count"];
        self.tweetId = dictionary[@"id"];
    }
    return self;
}


+(NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
