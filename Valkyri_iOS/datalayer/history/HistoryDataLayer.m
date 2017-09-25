//
//  HistoryDataLayer.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "HistoryDataLayer.h"
#import "History.h"
#import "IssueViewController.h"
#import "DetailIssueViewController.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "RoomDatalayer.h"
#import "AccountDatalayer.h"

@implementation HistoryDataLayer


+ (NSMutableArray<History *> *)getAllHistory:(IssueViewController *) view {
    __block NSMutableArray<History*> *historyList = [[NSMutableArray alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlHistory]]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if(!error) {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [historyList addObject:[[History alloc] initWithNSDictionnar:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [view reloadTableView];
        });
    }];
    [dataTask resume];
    return historyList;
}

+ (void)getHistoryById:(NSInteger)identifiant andDetailView:(DetailIssueViewController *)detailIssueView {
    NSString *nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld", (long)identifiant];
    
    __block History *history = nil;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlHistory] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            history = [[History alloc] initWithNSDictionnar:dict];

            [RoomDatalayer getRoomWithIdForDetailIssue:[NSNumber numberWithInt:history.place_id] andIssueView:detailIssueView];
            [AccountDatalayer getUserByIdForDetailIssue:detailIssueView andId:history.user_id];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailIssueView.eventDate.text = [Tools getDateStringFromNSDate:history.createdAt];
            detailIssueView.eventTime.text = [Tools getTimeStringFromNSDate:history.createdAt];
            detailIssueView.authorizationStatus.text = [Tools getAuthorizationStatusStringForBoolean:history.authorize];
        });
    }];
    [dataTask resume];
}


@end
