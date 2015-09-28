//
//  User.h
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *screenname;
@property (nonatomic,strong) NSString *profileImageUrl;
@property (nonatomic,strong) NSString *tagline;

-(id)initWithDictionary:(NSDictionary *)dictionary;

+(User *)currentUser;
+(void)setCurrentUser:(User *) user;
+(void)logout;

@end
