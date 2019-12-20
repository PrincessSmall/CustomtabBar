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

@interface BaseTabBarViewController ()<LMTabBarDelegate>

@property (nonatomic, strong) LMTabBar *customTabBar;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupChildVC];
    self.currentSelectedIndex = 0;
    // Do any additional setup after loading the view.
}
 

#pragma mark ----setupChildVC

//设置viewControllers，添加子控制器
- (void)setupChildVC {

    AViewController *avc = [[AViewController alloc]init];
    UINavigationController *aNav = [[UINavigationController alloc]initWithRootViewController:avc];
    BViewController *bvc = [[BViewController alloc]init];
    UINavigationController *bNav = [[UINavigationController alloc]initWithRootViewController:bvc];
    CViewController *cvc = [[CViewController alloc]init];
    UINavigationController *cNav = [[UINavigationController alloc]initWithRootViewController:cvc];
    DViewController *dvc = [[DViewController alloc]init];
    UINavigationController *dNav = [[UINavigationController alloc]initWithRootViewController:dvc];
    
    self.viewControllers = @[aNav,bNav,cNav,dNav];
    [self setupCustomTabBarItems];
}

/// 设置自定义的LMTabBar
- (void)setupCustomTabBarItems {
    self.tabBar.hidden = YES;
    
    //创建items数组
    NSArray *animationJsonNameArray = @[@"fangzi",@"huiyuan",@"dingdan",@"wode"];
    NSMutableArray <LMTabBarItem *>*items = [NSMutableArray array];
    for (int i = 0; i < self.viewControllers.count; i++) {
        LMTabBarItem *item = [[LMTabBarItem alloc]init];
        item.animationJsonName = animationJsonNameArray[i];
        [items addObject:item];
        item.tag = i;
    }
    self.customTabBar.lmItems = [items copy];
    
    [self.view addSubview:self.customTabBar];
    self.customTabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - LMTabBarHeight, CGRectGetWidth(self.view.frame), LMTabBarHeight);
}


#pragma mark - LMTabBarDelegate

- (void)tabBar:(LMTabBar *)tab didSelectItem:(LMTabBarItem *)item atIndex:(NSInteger)index {
    if (index != self.currentSelectedIndex) {//切换tabBarItem，并且点击的是非选中的item，则执行下面动画
        self.lastSelectedIndex = self.currentSelectedIndex;
        self.currentSelectedIndex = index;
    }
}

- (void)setLastSelectedIndex:(NSInteger)lastSelectedIndex {
    _lastSelectedIndex = lastSelectedIndex;
    LMTabBarItem *item = self.customTabBar.lmItems[lastSelectedIndex];
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {//取LOTAnimationView
            LOTAnimationView *animationView = (LOTAnimationView *)view;
            [animationView stop];//停止动画并回到原点
            break;
        }
    }
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex {
    _currentSelectedIndex = currentSelectedIndex;
    LMTabBarItem *item = self.customTabBar.lmItems[currentSelectedIndex];
    for (UIView *view in item.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"LOTAnimationView")]) {//取LOTAnimationView
            LOTAnimationView *animationView = (LOTAnimationView *)view;
            [animationView playToProgress:0.5f withCompletion:nil];//开始动画执行到0.5
            break;
        }
    }
}

#pragma mark ----lazy

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
