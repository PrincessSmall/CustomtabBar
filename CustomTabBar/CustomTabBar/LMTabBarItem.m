//
//  LMTabBarItem.m
//  CustomTabBar
//
//  Created by LiMin on 2019/12/18.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "LMTabBarItem.h"
#import <lottie-ios/Lottie/LOTAnimationView.h>

static NSInteger defaultTag = 100000;

@interface LMTabBarItem ()

@property (nonatomic, strong) LOTAnimationView *animationView;//动画view

@end

@implementation LMTabBarItem

//重写初始化方法
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.animationView];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItem:)];
        [self.animationView addGestureRecognizer:gesture];
    }
    return self;
}

/// item点击手势，响应点击事件
- (void)tapItem:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
        [self.delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}


#pragma mark ----set

// 重写setTag方法
- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

//set方法设置动画view的数据
- (void)setAnimationJsonName:(NSString *)animationJsonName {
    _animationJsonName = animationJsonName;
    [self.animationView setAnimationNamed:animationJsonName];
}


#pragma mark ----layoutSubviews

//重写layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = -20;
    rect.size.height += 20;
    self.animationView.frame = rect;
}


#pragma mark ----lazy

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [[LOTAnimationView alloc]init];
        _animationView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _animationView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
