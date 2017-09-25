#import "RoomDatalayer.h"
#import "RoomViewController.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "LevelDatalayer.h"
#import "DetailIssueViewController.h"
#import "DetailAccessViewController.h"
#import "DetailRoomViewController.h"
#import "Room.h"
#import "UserInformation.h"

@implementation RoomDatalayer

+ (NSMutableArray<Room *> *)getAllRoom:(RoomViewController *)roomView {

    __block NSMutableArray<Room*> *roomList = [[NSMutableArray alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlPlace]]];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if(!error) {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [roomList addObject:[[Room alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [roomView reloadTableView];
        });
    }];
    [dataTask resume];
    return roomList;
}

+ (void)getRoomWithId:(NSNumber*)identifiant andRoomView:(DetailRoomViewController *)roomView {
  
        NSString *nb = [[NSString alloc] init];
        nb = [NSString stringWithFormat:@"/%d", [identifiant intValue]];
        
    __block Room *room = nil;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlPlace] stringByAppendingString:nb]]];
    
        NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error){
                NSError* jsonError = nil;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                room = [[Room alloc] initWithNSDictionnary:dict];
                
                
            }
            // On quitte le mode asynchrone pour impacter la vue
            dispatch_async(dispatch_get_main_queue(), ^{
                
                roomView.room = room;
                roomView.PlaceNumberTextfield.text = [NSString stringWithFormat:@"%d", room.number];
                roomView.PlaceLevelNumberTextfield.text = [NSString stringWithFormat:@"%d", room.level_id];
            });
        }];
        [dataTask resume];
}

+ (void)getRoomWithIdForDetailIssue:(NSNumber*)identifiant andIssueView:(DetailIssueViewController *)detailIssueView {
    
    NSString *nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld", (long)identifiant];
    
    __block Room *room = nil;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlPlace] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            room = [[Room alloc] initWithNSDictionnary:dict];
            
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailIssueView.roomNumber.text = [NSString stringWithFormat:@"%d", room.number];
            detailIssueView.roomLevel.text = [NSString stringWithFormat:@"%d", room.level_id];
        });
    }];
    [dataTask resume];
}

+ (NSMutableArray<Room*> *)getAllRoomWithAccessDetailView:(DetailAccessViewController *) view {
    __block NSMutableArray<Room*> *roomList = [[NSMutableArray alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlPlace]]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if(!error) {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [roomList addObject:[[Room alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.roomDataPicker reloadAllComponents];
        });
    }];
    [dataTask resume];
    return roomList;
}


+ (void)getRoomWithIdForDetailAccess:(NSNumber*)identifiant andAccessView:(DetailAccessViewController *)detailAccessView {
    
    NSString *nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@", identifiant];
    
    __block Room *room = nil;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlPlace] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            room = [[Room alloc] initWithNSDictionnary:dict];
            
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailAccessView.selectedPlaceId = room.id;
            [detailAccessView reloadRoomPickerViewWithRoomNumber:room.number];
        });
    }];
    
    [dataTask resume];
}

+ (void) postRoomWithNumber:(NSNumber*)number andWithLevelNumber:(NSNumber*)levelNumber andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlPlace]]];
 
    
    //setup dict
    [dict setValue:number forKey:@"number"];
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

+ (void) putRoomWithNumber:(NSNumber*)number WithlevelNumber:(NSNumber*)levelNumber andWithId:(NSNumber*)identifiant andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{

    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlPlace] stringByAppendingString:nb]]];

    //setup dict
    [dict setValue:number forKey:@"number"];
    [dict setValue:levelNumber forKey:@"level_number"];
    
    
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

+ (void) deleteRoomWithId:(NSNumber*)identifiant andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@", identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlPlace] stringByAppendingString:nb]]];
    
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
