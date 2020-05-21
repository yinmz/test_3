//
//  main.m
//  test_3
//
//  Created by bytedance on 2020/5/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "Model.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    /*
    void(^hihi)(void) = ^void(void){NSLog(@"hellomoto");};
    void(^xixi)(void) = ^void(void){NSLog(@"dalalalalala");};
    [ViewController saysayhello:hihi];
    [ViewController saysayhello:xixi];
    */
    
    //Board *board = [[Board alloc]init];
    
//    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
