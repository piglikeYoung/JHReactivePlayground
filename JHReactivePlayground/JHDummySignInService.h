//
//  JHDummySignInService.h
//  JHReactivePlayground
//
//  Created by piglikeyoung on 15/9/7.
//  Copyright (c) 2015年 pikeYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JHSignInResponse)(BOOL);

@interface JHDummySignInService : NSObject

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(JHSignInResponse)completeBlock;

@end
