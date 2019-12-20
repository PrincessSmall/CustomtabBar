//
//  LMTabBar.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "LMTabBar.h"
#import "LMTabBarItem.h"

//主要是将系统的item移除掉, 然后添加上自定义的item:
@interface LMTabBar ()<LMTabBarItemDelegate>

@end

@implementation LMTabBar

//重写初始化方法
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setLmItems:(NSArray<LMTabBarItem *> *)lmItems {
    _lmItems = lmItems;
}

//重写layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    // 移除系统的tabBarItem
     //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，移除
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:class]) {//这里的安全判断是很有必要的
            [item removeFromSuperview];
        }
    }
    // 设置自定义的tabBarItem
    [self setupItems];
}


/// 设置自定义的LMTabBarItem
- (void)setupItems {
    CGFloat width = self.frame.size.width/self.lmItems.count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < self.lmItems.count; i++) {
        LMTabBarItem *item = [self.lmItems objectAtIndex:i];
        item.frame = CGRectMake(i*width, 0, width, height);
        [self addSubview:item];
        item.delegate = self;
    }
}


#pragma mark ----LMTabBarItemDelegate
//实现代理方法
- (void)tabBarItem:(LMTabBarItem *)item didSelectIndex:(NSInteger)index {
    if (self.lmDelegate && [self.lmDelegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
        [self.lmDelegate tabBar:self didSelectItem:item atIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
