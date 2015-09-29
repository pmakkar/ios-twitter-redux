//
//  TweetsViewController.m
//  Twitter
//
//  Created by Puneet Makkar on 9/22/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"


@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate,TweetCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableMenuView;
@property (nonatomic, strong) NSArray *tableMenuData;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSMutableArray *tweets;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, assign) BOOL menuOpened;
@property (nonatomic, strong) NSString *navigationTitle;
@end

@implementation TweetsViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.tableMenuView setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableMenuView.delegate = self;
    self.tableMenuView.dataSource = self;
    self.tableMenuData = [NSArray arrayWithObjects:@"Profile", @"Home", @"Mentions", @"Log Out",nil];
    [self.tableMenuView setFrame:CGRectMake(-self.tableMenuView.frame.size.width, self.tableMenuView.frame.origin.y, self.tableMenuView.frame.size.width, self.tableMenuView.frame.size.height)];
    [self.tableMenuView reloadData];
    
    self.navigationItem.title = @"Home";
    
    UIBarButtonItem *leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.menuOpened = false;
    
    UIBarButtonItem *rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tweets = [[NSMutableArray alloc] init];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.reloading = NO;
    
    [self reload];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
}

-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)recognizer{
    NSLog(@"Swiped Left");
    [self closeMenu];
}
-(void)handleSwipeRight:(UISwipeGestureRecognizer*)recognizer{
    NSLog(@"Swiped Right");
    [self openMenu];
}

-(void)openMenu {
    if (self.menuOpened == true) {
        [self closeMenu];
        return;
    }
    [self.tableMenuView setFrame:CGRectMake(-self.tableMenuView.frame.size.width, self.tableMenuView.frame.origin.y, self.tableMenuView.frame.size.width, self.tableMenuView.frame.size.height)];
    [self.tableMenuView setHidden:NO];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         [self.tableView setFrame:CGRectMake(self.tableMenuView.frame.size.width, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
                         [self.tableMenuView setFrame:CGRectMake(0, self.tableMenuView.frame.origin.y, self.tableMenuView.frame.size.width, self.tableMenuView.frame.size.height)];
                         
                     }
     ];
    self.menuOpened = true;
}

-(void)closeMenu {
    [UIView animateWithDuration:.25
                     animations:^{
                         [self.tableView setFrame:CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
                         [self.tableMenuView setFrame:CGRectMake(-self.tableMenuView.frame.size.width, self.tableMenuView.frame.origin.y, self.tableMenuView.frame.size.width, self.tableMenuView.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         [self.tableMenuView setHidden:YES];
                     }
     ];
    self.menuOpened = false;
}

- (void)reload {
    [self reloadWithOffset:[NSNumber numberWithInt:0] :@"Home"];
}

- (void)reloadWithOffset:(NSNumber *)offset :(NSString *)navigationTitle {
    // self.reloading = YES;
    // Do any additional setup after loading the view from its nib.
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"count"] = offset;
    
     if ([navigationTitle isEqualToString:@"Mention"]) {
         
         [[TwitterClient sharedInstance] mentionTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
             self.tweets = [NSMutableArray arrayWithArray:tweets];
             [self.refreshControl endRefreshing];
             [self.tableView reloadData];
             self.navigationItem.title = @"Mentions";
         }];
     }
     else {
         [[TwitterClient sharedInstance] homeTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
             self.tweets = [NSMutableArray arrayWithArray:tweets];
             [self.refreshControl endRefreshing];
             [self.tableView reloadData];
             self.navigationItem.title = @"Home";
         }];
         
     }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTweet:self.tweets[indexPath.row]];
        return cell;
    }
    else {
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        cell.textLabel.text = [self.tableMenuData objectAtIndex:indexPath.row];
        cell.textLabel.backgroundColor = [UIColor grayColor];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.tweets.count;
    } else {
        return self.tableMenuData.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
        Tweet *tweet = self.tweets[indexPath.row];
        TweetViewController *tvc = [[TweetViewController alloc] init];
        tvc.tweet = tweet;
        [self.navigationController pushViewController:tvc animated:YES];
    } else {
        if ([self.tableMenuData[indexPath.row] isEqualToString:@"Log Out"]) {
            [self onLogOut];
        }
        else if([self.tableMenuData[indexPath.row] isEqualToString:@"Home"]) {
            [self closeMenu];
            [self reloadWithOffset:[NSNumber numberWithInt:0] :@"Home"];
        }
        else if([self.tableMenuData[indexPath.row] isEqualToString:@"Profile"]) {
            [self closeMenu];
            ProfileViewController *tvc = [[ProfileViewController alloc] init];
            tvc.userStatus = nil;
            [self.navigationController pushViewController:tvc animated:YES];
        }
        else if([self.tableMenuData[indexPath.row] isEqualToString:@"Mentions"]) {
            [self closeMenu];
            [self reloadWithOffset:[NSNumber numberWithInt:0] :@"Mention"];
        }
    }
}

#pragma mark - Tweet cell delegate methods
- (void) tweetCell:(TweetCell *)cell didImageClick:(BOOL)value {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    Tweet *tweet = self.tweets[indexPath.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: tweet.author.screenname forKey: @"screen_name"];
    
    
    [[TwitterClient sharedInstance] getUserStatus:params completion:^(NSDictionary *userStatus, NSError *error) {
        ProfileViewController *pvc = [[ProfileViewController alloc] init];
        pvc.userStatus = userStatus;
        [self.navigationController pushViewController:pvc animated:YES];
        }];
    
    NSLog(@"Image clicked");
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        return 115;
    } else {
        return 40;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onLogOut {
    NSLog(@"used logging out...");
    [User logout];
}

- (void) onCompose {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - (self.tableView.frame.size.height - 5);
    if ((actualPosition >= contentHeight) && !self.reloading) {
        NSLog(@"reload more data");
        [self reloadWithOffset:[NSNumber numberWithLong:(self.tweets.count + 20)]];
    }
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
