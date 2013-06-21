//
//  SHViewController.m
//  SHOmniAuthLinkedInExample
//
//  Created by Seivan Heidari on 3/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHViewController.h"
#import "SHOmniAuthLinkedIn.h"
#import "UIActionSheet+BlocksKit.h"
#import "NSArray+BlocksKit.h"
@interface SHViewController ()
-(void)performLinkedInAuth;
@end

@implementation SHViewController

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self performLinkedInAuth];
}

-(void)performLinkedInAuth; {
  [SHOmniAuthLinkedIn performLoginWithListOfAccounts:^(NSArray *accounts, SHOmniAuthAccountPickerHandler pickAccountBlock) { UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick linkedin account"];
    [accounts each:^(id<account> account) {
      [actionSheet addButtonWithTitle:account.username handler:^{
        pickAccountBlock(account);
      }];
    }];
    
    NSString * buttonTitle = nil;
    if(accounts.count > 0)
      buttonTitle = @"Add account";
    else
      buttonTitle = @"Connect with LinkedIn";
    
    [actionSheet addButtonWithTitle:buttonTitle handler:^{
      pickAccountBlock(nil);
    }];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    
    
    
  } onComplete:^(id<account> account, id response, NSError *error, BOOL isSuccess) {
    NSLog(@"%@", response);
   dispatch_async(dispatch_get_main_queue(), ^{
     [self performLinkedInAuth];
   });
  }];

}

@end
