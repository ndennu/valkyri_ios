#import "AuthDataLayer.h"
#import "ConfigDatalayer.h"
#import "UserInformation.h"

@implementation AuthDataLayer


+ (void) postCredentialsAndGetTokenWithEmail:(NSString*)email andPassword:(NSString*)password andResultHandler:(void (^)(void)) resultHandler andUnauthorizedHandler:(void (^)(void)) unauthorizedHandler andErrorHandler:(void (^)(void)) errorHandler{
    
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/login", [ConfigDatalayer getApiUrlAuth]]]];
    

    //setup dict
    [dict setValue:email forKey:@"email"];
    [dict setValue:password forKey:@"password"];
    //setup urlRequest
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
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
                NSError* jsonError = nil;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                [UserInformation setConnectedUserIdWithId:[[dict objectForKey:@"userId"] intValue]];
                [UserInformation setConnectedUserLvlWithLvl:[[dict objectForKey:@"userLevelNumber"] intValue]];
                [UserInformation setAuthTokenWithNSString:[dict objectForKey:@"token"]];
                
                // On quittse le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), resultHandler);
            } else if (httpResponse.statusCode == 401) {
                dispatch_async(dispatch_get_main_queue(), unauthorizedHandler);
            } else {
                // On quitte le mode asynchrone pour impacter la vue
                dispatch_async(dispatch_get_main_queue(), errorHandler);
            }
        }];
        [dataTask resume];
    }
}

+ (void) postTokenAndLogoutWithResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler{
    
    //init var
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc]init];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/logout", [ConfigDatalayer getApiUrlAuth]]]];
    
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

@end
