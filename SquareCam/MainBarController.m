//
//  MainBarController.m
//  mvc
//
//  Created by PeixinLu on 6/8/16.
//  Copyright © 2016 PeixinLu. All rights reserved.
//

#import "MainBarController.h"
#import "BodyViewController.h"
#import "TwoViewController.h"
#import "SquareCamViewController.h"

@implementation MainBarController{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
   
    
    
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // Everytime when we press the "Overview" button, the time will be updated.
    if (tabBarController.selectedIndex == 0) {
        NSLog(@"111111111111111111");
        self.bodyvc =  tabBarController.viewControllers[1];
        self.bodyvc.flag = NO;
        self.twovc =  tabBarController.viewControllers[2];
        self.twovc.flag = NO;
        self.squarevc = tabBarController.viewControllers[0];
        self.squarevc.flag = YES;
    }
    
    // Everytime when we press the "Events" button, the log will be output.
    if (tabBarController.selectedIndex == 1) {
        NSLog(@"222222222222222222");
        self.bodyvc =  tabBarController.viewControllers[1];
        self.bodyvc.flag = YES;
        self.twovc =  tabBarController.viewControllers[2];
        self.twovc.flag = NO;
        self.squarevc = tabBarController.viewControllers[0];
        self.squarevc.flag = NO;
    }
    if (tabBarController.selectedIndex == 2) {
        NSLog(@"333333333333333333");
        self.bodyvc =  tabBarController.viewControllers[1];
        self.bodyvc.flag = NO;
        self.twovc =  tabBarController.viewControllers[2];
        self.twovc.flag = YES;
        self.squarevc = tabBarController.viewControllers[0];
        self.squarevc.flag = NO;
    }
}

@end