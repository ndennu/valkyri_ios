//
//  AccessDatalayer.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "AccessDatalayer.h"
#import "AccessViewController.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "RoomDatalayer.h"
#import "LevelDatalayer.h"
#import "UserInformation.h"

@implementation AccessDatalayer

+ (NSMutableArray<Access *> *)getAllAccess:(AccessViewController *)accessView {
    __block NSMutableArray<Access*> *accessList = [[NSMutableArray alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlAccess]]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if(!error) {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [accessList addObject:[[Access alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [accessView reloadTableView];
        });
    }];
    [dataTask resume];
    return accessList;
}

+ (void)getAccessWithId:(NSInteger)identifiant andAccessView:(DetailAccessViewController *)accessView {
    NSString *nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld", (long)identifiant];
    
    __block Access *access = nil;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlAccess] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            access = [[Access alloc] initWithNSDictionnary:dict];
            [RoomDatalayer getRoomWithIdForDetailAccess:[NSNumber numberWithInteger:access.place_id] andAccessView:accessView];
            [LevelDataLayer getLevelForDetailAccessWithId:access.level_number andWithDetailView:accessView];
            
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [accessView.hourOpenedDatePicker setDate:access.h1];
            [accessView.hourClosedDatePicker setDate:access.h2 animated:YES];
        });
    }];
    [dataTask resume];
}

+ (void)postAccessWithH1:(NSString *)h1 andWithH2:(NSString *)h2 andWithRoom:(NSString*)roomId andWithLevel:(NSString*)levelNumber andResultHandler:(void (^)(void))resultHandler andErrorHandler:(void (^)(void))errorHandler {
    
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlAccess]]];
    
    //setup dict
    [dict setValue:h1 forKey:@"h1"];
    [dict setValue:h2 forKey:@"h2"];
    [dict setValue:roomId forKey:@"place_id"];
    [dict setValue:levelNumber forKey:@"level_number"];
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
            NSLog(@"%ld", (long)httpResponse.statusCode);
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


+ (void)putAccessWithH1:(NSString *)h1 WithH2:(NSString *)h2 andWithRoom:(NSString*)roomId andWithLevel:(NSString*)levelNumber andWithId:(NSString *)identifiant andResultHandler:(void (^)(void))handler andErrorHandler:(void (^)(void))errorHandler {
    
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlAccess] stringByAppendingString:nb]]];
    
    //setup dict
    [dict setValue:h1 forKey:@"h1"];
    [dict setValue:h2 forKey:@"h2"];
    [dict setValue:roomId forKey:@"place_id"];
    [dict setValue:levelNumber forKey:@"level_number"];
    
    
    NSLog(@"%@", dict);
    
    //setup urlRequest
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[UserInformation getAuthToken] forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"%@", urlRequest);
    
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
            if(httpResponse.statusCode == 200)
            {
                // On quittse le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), handler);
            } else {
                // On quitte le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), errorHandler);
            }
        }];
        [dataTask resume];
    }
}


+ (void)deleteAccessWithId:(NSInteger)identifiant andResultHandler:(void (^)(void))handler andErrorHandler:(void (^)(void))errorHandler {
    
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@", [NSNumber numberWithInteger:identifiant]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlAccess] stringByAppendingString:nb]]];
    
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
            dispatch_async(dispatch_get_main_queue(), handler);
        } else {
            // On quitte le mode asynchrone pour impacter la vue
            dispatch_async(dispatch_get_main_queue(), errorHandler);
        }
    }];
    [dataTask resume];
}

@end
