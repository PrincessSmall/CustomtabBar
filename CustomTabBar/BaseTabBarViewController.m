//
//  BaseTabBarViewController.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/17.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"

#import "LMTabBar.h"
#import "LMTabBarItem.h"

#import <lottie-ios/Lottie/LOTAnimationView.h>

static CGFloat LMTabBarHeight = 48.0;

@interface BaseTabBarViewController ()<LMTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) LMTabBar *customTabBar;

@property (nonatomic, copy) NSArray *lmViewControllers;

@property (nonatomic, strong) LOTAnimationView *animationViewA;
@property (nonatomic, strong) LOTAnimationView *animationViewB;
@property (nonatomic, strong) LOTAnimationView *animationViewC;
@property (nonatomic, strong) LOTAnimationView *animationViewD;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    [self setupChildVC];
    self.delegate = self;
    // Do any additional setup after loading the view.
}
 

#pragma mark ----setupChildVC

- (void)setupChildVC {

    AViewController *avc = [[AViewController alloc]init];
    BViewController *bvc = [[BViewController alloc]init];
    CViewController *cvc = [[CViewController alloc]init];
    DViewController *dvc = [[DViewController alloc]init];
    
    self.lmViewControllers = @[avc,bvc,cvc,dvc];
    [self setupCustomTabBarItems];
}

/// 设置自定义的tabBar
- (void)setupCustomTabBarItems {
    self.tabBar.hidden = YES;
    
    //创建items数组
    NSArray *animationJsonNameArray = @[@"fangzi",@"huiyuan",@"dingdan",@"wode"];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < self.lmViewControllers.count; i++) {
        LMTabBarItem *item = [[LMTabBarItem alloc]init];
        item.animationJsonName = animationJsonNameArray[i];
        [items addObject:item];
        item.tag = i;
    }
    self.customTabBar.LMItems = [items copy];
    
    [self.view addSubview:self.customTabBar];
    self.customTabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - LMTabBarHeight, CGRectGetWidth(self.view.frame), LMTabBarHeight);
}


#pragma mark ----UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"tabBarController:didSelectViewController");
}


#pragma mark - LMTabBarDelegate

- (void)tabBar:(LMTabBar *)tab didSelectItem:(LMTabBarItem *)item atIndex:(NSInteger)index {
    for (int i = 0; i < tab.LMItems.count; i++) {
        if (i != index) {
             LMTabBarItem *tabBarItem = tab.LMItems[i];
                   for (UIView *view in tabBarItem.subviews) {
                       if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {
                          LOTAnimationView *animationView = (LOTAnimationView *)view;
                           if (animationView.animationProgress != 0 ) {
                             [animationView stop];
                           }
                       }
                   }
        }
    }
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {
            LOTAnimationView *animationView = (LOTAnimationView *)view;
            if (animationView.animationProgress == 0 ){
                [animationView  playToProgress:0.5f withCompletion:^(BOOL animationFinished) {
                    
                }];
            }
        }
    }
    self.selectedIndex = index;
}

- (void)animationItemWithItem:(LMTabBarItem *)item {
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {
           LOTAnimationView *animationView = (LOTAnimationView *)view;
            [animationView stop];
        }
    }
    
}


#pragma mark ----lazy

- (LOTAnimationView *)animationViewA {
    if (!_animationViewA) {
        _animationViewA = [LOTAnimationView animationNamed:@"shouye"];
        _animationViewA.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationViewA;
}
- (LOTAnimationView *)animationViewB {
    if (!_animationViewB) {
        _animationViewB = [LOTAnimationView animationNamed:@"huiyuan"];
        _animationViewB.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationViewB;
}
- (LOTAnimationView *)animationViewC {
    if (!_animationViewC) {
        _animationViewC = [LOTAnimationView animationNamed:@"dingdan"];
        _animationViewC.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationViewC;
}
- (LOTAnimationView *)animationViewD {
    if (!_animationViewD) {
        _animationViewD = [LOTAnimationView animationNamed:@"wode"];
        _animationViewD.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _animationViewD;
}

- (LMTabBar *)customTabBar {
    if (!_customTabBar) {
        _customTabBar = [[LMTabBar alloc]init];
        _customTabBar.backgroundColor = [UIColor whiteColor];
        _customTabBar.lmDelegate = self;
    }
    return _customTabBar;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
