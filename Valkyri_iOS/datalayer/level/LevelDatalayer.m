//
//  LevelDataLayer.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "LevelDatalayer.h"
#import "LevelViewController.h"
#import "Level.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "DetailIssueViewController.h"
#import "DetailRoomViewController.h"
#import "DetailAccessViewController.h"
#import "UserInformation.h"

@implementation LevelDataLayer



//[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", baseApiUrl]]];

/// Récupère tous les levels depuis le webservice
+(NSMutableArray<Level*>*) getAllLevelsWithLevelView:(LevelViewController *) view {
    __block NSMutableArray<Level*> *levelsList = [[NSMutableArray alloc] init];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlLevel]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [levelsList addObject:[[Level alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [view reloadTableView];
        });
    }];
    [dataTask resume];
    return levelsList;
}

/// Récupère tous les levels depuis le webservice
+(NSMutableArray<Level*> *) getAllLevelsWithDetailAccessView:(DetailAccessViewController *) view {
    __block NSMutableArray<Level*> *levelsList = [[NSMutableArray alloc] init];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlLevel]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [levelsList addObject:[[Level alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.levelDataPicker reloadAllComponents];
        });
    }];
    [dataTask resume];
    return levelsList;
}

+ (void) getLevelById:(LevelDetails*) view identifiant:(NSInteger) identifiant {
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Level *level = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            level = [[Level alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            view.level = level;
            view.levelNameTxtField.text = level.name;
            view.levelNumberTextField.text = [NSString stringWithFormat:@"%d", level.number];
        });
    }];
    [dataTask resume];
}


+ (void) getLevelForRoomWithId:(NSInteger) identifiant andIssueDetailView:(DetailIssueViewController*) view{
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Level *level = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            level = [[Level alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            view.roomLevel.text = level.name;
        });
    }];
    [dataTask resume];
}

+ (void) getLevelForAccountWithId:(NSInteger) identifiant andIssueDetailView:(DetailIssueViewController*) view{
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Level *level = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            level = [[Level alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            view.userLevel.text = level.name;
        });
    }];
    [dataTask resume];
}

+ (void)getLevelForDetailRoomWithId:(NSNumber*)identifiant andWithDetailView:(DetailRoomViewController *)detailRoomView{
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    
    __block Level *level = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            level = [[Level alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailRoomView.PlaceLevelNumberTextfield.text = [NSString stringWithFormat:@"%d",level.number];
        });
    }];
    [dataTask resume];
}

+ (void)getLevelForDetailAccessWithId:(NSInteger)identifiant andWithDetailView:(DetailAccessViewController *)detailAccessView{
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Level *level = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            level = [[Level alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailAccessView.selectedLevelNumber = level.number;
            [detailAccessView reloadLevelPickerViewWithLevelName:level.name];
        });
    }];
    [dataTask resume];
}

+ (void) postLevelWithNumber:(NSString*)number andWithName:(NSString*)name andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
 
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlLevel]]];
    
    //setup dict
    [dict setValue:name forKey:@"name"];
    [dict setValue:number forKey:@"number"];
    //setup urlRequest
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[UserInformation getAuthToken] forHTTPHeaderField:@"Authorization"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@" error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:data];
    
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 201)
            {
                // On quittse le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), resultHandler);
            } else {
                // On quitte le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), errorHandler);
            }
        }];
        [dataTask resume];
    }
}

+ (void) putLevelWithNumber:(NSString*)number WithName:(NSString*)name andWithId:(NSString*)identifiant andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];

    //setup dict
    [dict setValue:name forKey:@"name"];
    [dict setValue:number forKey:@"number"];
    
    
    
    //setup urlRequest
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[UserInformation getAuthToken] forHTTPHeaderField:@"Authorization"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@" error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:data];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 201)
            {
                // On quittse le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), resultHandler);
            } else {
                // On quitte le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), errorHandler);
            }
        }];
        [dataTask resume];
    }
}

+ (void) deleteLevelWithId:(NSInteger)identifiant andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@", [NSNumber numberWithInteger:identifiant]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlLevel] stringByAppendingString:nb]]];
    
    //setup urlRequest
    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[UserInformation getAuthToken] forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 201)
        {
            // On quittse le mode asynchrone pour impacter la vue
            dispatch_async(dispatch_get_main_queue(), resultHandler);
        } else {
            // On quitte le mode asynchrone pour impacter la vue
            dispatch_async(dispatch_get_main_queue(), errorHandler);
        }
    }];
    [dataTask resume];
}

@end
