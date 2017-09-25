//
//  AccountDatalayer.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "AccountDatalayer.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "UserInformation.h"

@implementation AccountDatalayer


+ (NSMutableArray<Account *> *)getAllUsers:(SettingsViewController *)settingsView {
    __block NSMutableArray<Account*> *accountList = [[NSMutableArray alloc] init];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[ConfigDatalayer getApiUrlUser]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            for (id key in dict) {
                [accountList addObject:[[Account alloc] initWithNSDictionnary:key]];
            }
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            // [view reloadTableView];
        });
    }];
    [dataTask resume];
    return accountList;
}

+ (void)getUserById:(SettingsViewController *)settingsView identifiant:(NSInteger)identifiant {
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Account *account = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlUser] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            account = [[Account alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            settingsView.nameUser.text = account.lastname;
            settingsView.firstnameUser.text = account.firstname;
            settingsView.emailUser.text = account.email;
            settingsView.levelUser.text = [NSString stringWithFormat:@"%i", account.level_id];
            settingsView.matriculeUser.text = account.matricule;
            settingsView.phoneUser.text = account.phone;
            settingsView.account = account;
        });
    }];
    [dataTask resume];
}

+ (void)getUserByIdForDetailIssue:(DetailIssueViewController *)detailIssueView andId:(NSInteger)identifiant {
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%ld",(long)identifiant];
    
    __block Account *account = nil;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlUser] stringByAppendingString:nb]]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSError* jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            account = [[Account alloc] initWithNSDictionnary:dict];
        }
        // On quitte le mode asynchrone pour impacter la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            detailIssueView.userFirstname.text = account.firstname;
            detailIssueView.userLastname.text = account.lastname;
            detailIssueView.userMatricule.text = account.matricule;
            detailIssueView.userEmail.text = account.email;
            detailIssueView.userPhone.text = account.phone;
            detailIssueView.userLevel.text = [NSString stringWithFormat:@"%d", account.level_id];
        });
    }];
    [dataTask resume];
}

/// Récupère l'image de l'utilisateur depuis le serveur avec son id
+ (void) getProfileImageWithUserId:(long) idUser andImageView:(UIImageView*) imageView{
    imageView.image = nil;
    NSString *imageUrl = [NSString stringWithFormat:@"%@/image/%ld.png", [ConfigDatalayer getApiUrlUser], idUser];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200) {
                // On quitte le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = [UIImage imageWithData:data];
                });
            }
        }
    }];
    [dataTask resume];
}

+ (void) putUserPasswordWithUserId:(NSNumber*) identifiant andPassword:(NSString*) password andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlUser] stringByAppendingString:nb]]];
    
    //setup dict
    [dict setValue:password forKey:@"password"];
    
    
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

+ (void) putUserDigicodeWithUserId:(NSNumber*) identifiant andDigicode:(NSString*) digicode andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSString* nb = [[NSString alloc] init];
    nb = [NSString stringWithFormat:@"/%@",identifiant];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[ConfigDatalayer getApiUrlUser] stringByAppendingString:nb]]];
    
    //setup dict
    [dict setValue:digicode forKey:@"digicode"];
    
    
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



@end

