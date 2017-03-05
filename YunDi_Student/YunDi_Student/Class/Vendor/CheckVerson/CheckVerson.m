//
//  CheckVerson.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "CheckVerson.h"

static const NSString * appstoreUrl = @"";

@interface CheckVerson ()


@end
@implementation CheckVerson


- (BOOL) checkAppVersonWithAppStore{

    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    
    NSString *URL = @"http://itunes.apple.com/lookup?id=915748094";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:URL]];
    
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = nil;
    
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableLeaves error:&error];
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    
    BOOL isNew;
    
    if ([infoArray count]) {
        
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        
        isNew =  [self version:currentVersion lessthan:lastVersion];
        
        
//        if (isNew) {
//            
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有更新啦！要不要试试更赞的level up版✪ω✪" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"前往更新", nil];
//            
//            alert.tag = 10000;
//            
//            [alert show];
//            
//        }
//        
    }
    
    return isNew;

    
}

- (BOOL)version:(NSString *)oldver lessthan:(NSString *)newver //系统api
{
    if ([oldver compare:newver options:NSNumericSearch] == NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//
//{
//    
//    if (alertView.tag==10000) {
//        
//        if (buttonIndex==1) {
//            
//            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/qu-ri-ben-rang-ni-ri-ben-lu/id915748094?mt=8"];
//            
//            [[UIApplication sharedApplication]openURL:url];
//            
//        }
//        
//    }
//    
//}


@end
