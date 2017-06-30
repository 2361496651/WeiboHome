//
//  FullScrollView.m
//  AppGame
//
//  Created by  zengchunjun on 2017/4/21.
//  Copyright © 2017年 zengchunjun. All rights reserved.
//

#import "FullScrollView.h"

@implementation FullScrollView

//多手势共同触发
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

//    NSLog(@"\n gest:%@ == %@ \n other:%@ == %@",gestureRecognizer.view.class,gestureRecognizer.class, otherGestureRecognizer.view.class,otherGestureRecognizer.class);
    

    
//    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
    
    return YES;
}



//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]]) {
//        FullScrollView *scroll = (FullScrollView *)gestureRecognizer.view;
//        NSLog(@"%lf",scroll.contentOffset.y);
//        return  YES;
//    }
//    
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
////    if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]]) {
////        FullScrollView *scroll = (FullScrollView *)gestureRecognizer.view;
////        NSLog(@"%lf",scroll.contentOffset.y);
////        return  YES;
////    }
////    NSLog(@"view:%@  viewClass:%@",gestureRecognizer.view,[gestureRecognizer.view class]);
////    return YES;
//    
//    NSLog(@"%@===%@",touch.view.class,gestureRecognizer.view.class);
//    if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]]) {
//        FullScrollView *scroll = (FullScrollView *)gestureRecognizer.view;
//        NSLog(@"%lf",scroll.contentOffset.y);
//        
//        if (scroll.contentOffset.y > 122) {
//            return NO;
//        }
//    }
//    
//    
//    
//    return YES;
//}

//以下两个成对的方法比较有趣（实现其一即可）
//返回yes－前面失效后面生效    返回no－前面生效后面失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    UIScrollView *gestScroll = (UIScrollView *)gestureRecognizer.view;
//    UIScrollView *otherGestScroll = (UIScrollView *)otherGestureRecognizer.view;
//    NSLog(@"gest:%lf %@  /n  other: %@",gestScroll.contentOffset.y,gestureRecognizer.view.class, otherGestureRecognizer.view.class);
//    
//    if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] && gestScroll.contentOffset.y < 121.5) {
//        return NO;
//    }else if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UITableView class]]){
//        return YES;
//    }
//    
//    return YES;
//}
//
////返回yes-前面生效后面失效    返回no-前面失效后面生效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    UIScrollView *gestScroll = (UIScrollView *)gestureRecognizer.view;
//    UIScrollView *otherGestScroll = (UIScrollView *)gestureRecognizer.view;
//    NSLog(@"gest:%lf  /n  other:%lf",gestScroll.contentOffset.y,otherGestScroll.contentOffset.y);
//
//    if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] && gestScroll.contentOffset.y < 121.5) {
//        return YES;
//    }
//    else if ([gestureRecognizer.view isKindOfClass:[FullScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UITableView class]]){
//        return NO;
//    }
//    return NO;
//}

@end
