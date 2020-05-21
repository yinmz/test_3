
//
//  Model.h
//  test_3
//
//  Created by bytedance on 2020/5/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#ifndef Model_h
#define Model_h

@interface Board : NSObject

@property (nonatomic,strong) NSMutableArray* board;

- (void)resetBoard;

- (void)printBoard;

@end

#endif /* Model_h */
