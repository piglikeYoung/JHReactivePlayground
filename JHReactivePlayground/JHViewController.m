//
//  JHViewController.m
//  JHReactivePlayground
//
//  Created by piglikeyoung on 15/9/7.
//  Copyright (c) 2015年 pikeYoung. All rights reserved.
//

#import "JHViewController.h"
#import "JHDummySignInService.h"

@interface JHViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UILabel *invalidCreLabel;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;

@property (nonatomic, assign) BOOL usernameIsValid;
@property (nonatomic, assign) BOOL passwordIsValid;
@property (nonatomic, strong) JHDummySignInService *signInService;

@end

@implementation JHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化控件状态
    [self updateUIState];

    self.signInService = [[JHDummySignInService alloc] init];
    
    // 监听值的改变
    [self.userNameTextfield addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)updateUIState {
    self.userNameTextfield.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.pwdTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.signInBtn.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

- (void)usernameTextFieldChanged {
    self.usernameIsValid = [self isValidUsername:self.userNameTextfield.text];
    [self updateUIState];
}

- (void)passwordTextFieldChanged {
    self.passwordIsValid = [self isValidPassword:self.pwdTextField.text];
    [self updateUIState];
}

- (IBAction)signClick:(id)sender {
    
    self.signInBtn.enabled = NO;
    self.invalidCreLabel.hidden = YES;
    
    // sign in
    [self.signInService signInWithUsername:self.userNameTextfield.text
                                  password:self.pwdTextField.text
                                  complete:^(BOOL success) {
                                      self.signInBtn.enabled = YES;
                                      self.invalidCreLabel.hidden = success;
                                      if (success) {
                                          [self performSegueWithIdentifier:@"signInSuccess" sender:self];
                                      }
                                  }];
}


@end
