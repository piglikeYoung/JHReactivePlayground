//
//  JHViewController.m
//  JHReactivePlayground
//
//  Created by piglikeyoung on 15/9/7.
//  Copyright (c) 2015年 pikeYoung. All rights reserved.
//

#import "JHViewController.h"
#import "JHDummySignInService.h"
#import "ReactiveCocoa.h"

@interface JHViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UILabel *invalidCreLabel;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;

@property (nonatomic, strong) JHDummySignInService *signInService;

@end

@implementation JHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signInService = [JHDummySignInService new];
    
    // 创建信号
    RACSignal *validUsernameSignal = [self.userNameTextfield.rac_textSignal
                                      // 类型转换
                                      map:^id(NSString *text) {
                                          return @([self isValidUsername:text]);
                                      }];
    // 创建信号
    RACSignal *validPasswordSignal = [self.pwdTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @([self isValidPassword:text]);
                                      }];
    
    // 根据条件设置背景颜色
    RAC(self.pwdTextField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *pwdValid) {
        return [pwdValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.userNameTextfield, backgroundColor) = [validUsernameSignal map:^id(NSNumber *userNameValid) {
        return [userNameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    // 信号合成
    RACSignal *signUpActiveSignal = [RACSignal
                                     combineLatest:@[validUsernameSignal, validPasswordSignal]
                                     reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        self.signInBtn.enabled = [signupActive boolValue];
    }];
    
    // 按钮点击信号
    [[[[self.signInBtn
        rac_signalForControlEvents:UIControlEventTouchUpInside]
       // 副作用，发送信号的时候所执行的操作
       doNext:^(id x) {
           self.signInBtn.enabled = NO;
           self.invalidCreLabel.hidden = YES;
       }]
      // 信号转换
      flattenMap:^id(id x) {
          return [self signInSignal];
      }]
     subscribeNext:^(NSNumber *signedIn) {
         self.signInBtn.enabled = YES;
         BOOL success = [signedIn boolValue];
         self.invalidCreLabel.hidden = success;
         if (success) {
             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
         }
     }];
}


// 创建信号
- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
        [self.signInService
         signInWithUsername:self.userNameTextfield.text
         password:self.pwdTextField.text
         complete:^(BOOL success){
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}


- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}



@end
