//
//  DemoSignInService.h
//  RAC-Introduction
//
//  Created by Tasvir H Rohila on 08/09/15.
//  Copyright (c) 2015 Tasvir H Rohila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SignInResponse)(BOOL);

@interface DemoSignInService : NSObject

- (void)performSignIn:(NSString *)username password:(NSString *)password complete:(SignInResponse)completeBlock;

@end
