//
//  ViewController.m
//  RAC-Introduction
//
//  Created by Tasvir H Rohila on 08/09/15.
//  Copyright (c) 2015 Tasvir H Rohila. All rights reserved.
//

#import "ViewController.h"
#import "DemoSignInService.h"
#import "ReactiveCocoa.h"

@interface ViewController ()

@property (strong, nonatomic) DemoSignInService *signInService;

@property (weak, nonatomic) IBOutlet UITextField *usernameText; //"user"
@property (weak, nonatomic) IBOutlet UITextField *passwordText; //"password"
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.signInService = [DemoSignInService new];
    
    // initially hide the failure message
    self.signInFailLabel.hidden = YES;

    //code applies a map transform to the rac_textSignal from each text field. The output is a boolean value boxed as a NSNumber
    RACSignal *validUsernameSignal = [self.usernameText.rac_textSignal
                                      map:^id(NSString *userName) {
                                          return @([self isValidUsername:userName]);
                                      }];
    
    RACSignal *validPasswordSignal = [self.passwordText.rac_textSignal
                                      map:^id(NSString *password) {
                                          return @([self isValidPassword:password]);
                                      }];

    //Combining the 2 signals
    RACSignal *signupActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                      reduce:^id(NSNumber *userValid, NSNumber *passValid) {
                          return @([userValid boolValue] && [passValid boolValue]);
                      }];

    //This will wire it up to the enabled property on the button based on signal from RAC subscribeNext
    [signupActiveSignal subscribeNext:^(NSNumber *valActive) {
        self.signInButton.enabled = [valActive boolValue];
    }];
    
    //handle events you need to use another of the methods that ReactiveCocoa adds to UIKit, rac_signalForControlEvents.
    //add a doNext: step to the pipeline immediately after button touch event creation. Notice that the doNext: block does not return a value, because it’s a side-effect; it leaves the event itself unchanged.
    //map is used to transform the button touch signal into the sign-in signal. The subscriber simply logs the result.
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]
       doNext:^(id x) {
           self.signInButton.enabled = NO;
           self.signInFailLabel.hidden = YES;
       }]
      flattenMap:^id(id x) {
          return [self signInSignal];
      }]
     subscribeNext:^(NSNumber *signInNumber) {
         BOOL signInStatus = [signInNumber boolValue];
         self.signInFailLabel.hidden = signInStatus;
         if (signInStatus) {
             UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Sign in Success!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];

         }
         NSLog(@"DidTouch signin button");
     }];

}


- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

//The method creates a signal that signs in with the current username and password.
-(RACSignal *) signInSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService
         performSignIn:self.usernameText.text
         password:self.passwordText.text complete:^(BOOL success) {
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
