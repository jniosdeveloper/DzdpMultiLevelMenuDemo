//
//  AppDelegate.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
    [self getConfig];
    
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    

    return YES;
}
- (void)getConfig {
    [self getHostUrl];
}
- (void)getHostUrl {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"当前的HOST_URL:%@",info[@"HOST_URL"]);
}



@end
