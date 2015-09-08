//
//  DemoSignInService.m
//  RAC-Introduction
//
//  Created by Tasvir H Rohila on 08/09/15.
//  Copyright (c) 2015 Tasvir H Rohila. All rights reserved.
//

#import "DemoSignInService.h"
#import "ReactiveCocoa.h"

@implementation DemoSignInService


- (void)performSignIn:(NSString *)username password:(NSString *)password complete:(SignInResponse)completeBlock
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
        completeBlock(success);
    });
}

@end
