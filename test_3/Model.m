
//
//  Model.m
//  test_3
//
//  Created by bytedance on 2020/5/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"



@implementation Board

- (NSMutableArray*)board{
    if(!_board){
        _board = [[NSMutableArray alloc]initWithObjects:
                  [[NSMutableArray alloc] initWithObjects:@0, @0, @0, nil],
                  [[NSMutableArray alloc] initWithObjects:@0, @0, @0, nil],
                  [[NSMutableArray alloc] initWithObjects:@0, @0, @0, nil], nil];
    }
    return _board;
}

- (void)resetBoard{
    for(int i = 0;i < 3;i++){
        for(int j = 0;j < 3;j++){
            [[_board objectAtIndex:i] replaceObjectAtIndex:j
                                                withObject:@([[[_board objectAtIndex:i] objectAtIndex:j] intValue] + 1)];
            [self printBoard];
        }
    }
}

- (void)printBoard{
    NSLog(@"%@",self.board);
}

@end
