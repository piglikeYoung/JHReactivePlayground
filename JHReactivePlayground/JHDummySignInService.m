//
//  JHDummySignInService.m
//  JHReactivePlayground
//
//  Created by piglikeyoung on 15/9/7.
//  Copyright (c) 2015年 pikeYoung. All rights reserved.
//

#import "JHDummySignInService.h"

@interface JHDummySignInService ()

@end

@implementation JHDummySignInService

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(JHSignInResponse)completeBlock {

    BOOL success = [username isEqualToString:@"yjhisa"] && [password isEqualToString:@"123456"];

    completeBlock(success);
}

@end
