#import <Foundation/Foundation.h>

@interface AuthDataLayer : NSObject

//Envoie le login/mdp vers le serveur et recupére le token
+ (void) postCredentialsAndGetTokenWithEmail:(NSString*)email andPassword:(NSString*)password andResultHandler:(void (^)(void)) resultHandler andUnauthorizedHandler:(void (^)(void)) unauthorizedHandler andErrorHandler:(void (^)(void)) errorHandler;
//post sur le serveur
+ (void) postTokenAndLogoutWithResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;

@end
