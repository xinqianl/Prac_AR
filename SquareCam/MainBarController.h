//
//  MainBarController.h
//  mvc
//
//  Created by PeixinLu on 6/8/16.
//  Copyright © 2016 PeixinLu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BodyViewController.h"
#import "TwoViewController.h"
#import "SquareCamViewController.h"
@interface MainBarController : UITabBarController<UITabBarControllerDelegate>

@property BodyViewController *bodyvc;
@property TwoViewController *twovc;
@property SquareCamViewController *squarevc;

@end