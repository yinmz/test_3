//
//  ViewController.m
//  test_3
//
//  Created by bytedance on 2020/5/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH_DEVIEDS_THREE ([[UIScreen mainScreen] bounds].size.width / 3)


#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "Model.h"
#import "UIView+extensionID.h"
/*
@interface UIView (Extention)
@property (nonatomic, assign) int pos;
@end
*/



@interface ViewController ()
{
    Board *board;
    UIView *_boardView;
    NSArray *startArray;
    NSArray *finishArray;
    NSMutableArray *viewArray;
    UIView *nowView;
    NSMutableSet *posSet;
    int up,left,down,right;
    CGFloat totOffsetX;
    CGFloat totOffsetY;
    int gg;
}

@end



@implementation ViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:_boardView];
    for(id view in viewArray){
        if (CGRectContainsPoint([view frame], pt)) {
            nowView = view;
            break;
        }
    }
    
    up = left = down = right = 0;
    if(gg)
        return;
    
    switch ([nowView.number intValue]) {
        case 0:
            if(![posSet containsObject:@1]){
                down = 1;
            }else if(![posSet containsObject:@3])
                right = 1;
            break;
        case 1:
            if(![posSet containsObject:@0]){
                up = 1;
            }else if(![posSet containsObject:@2]){
                down = 1;
            }else if(![posSet containsObject:@4]){
                right = 1;
            }
            break;
        case 2:
            if(![posSet containsObject:@1]){
                up = 1;
            }else if(![posSet containsObject:@5])
                right = 1;
            break;
        case 3:
            if(![posSet containsObject:@0]){
                left = 1;
            }else if(![posSet containsObject:@4]){
                down = 1;
            }else if(![posSet containsObject:@6]){
                right = 1;
            }
            break;
        case 4:
            if(![posSet containsObject:@3]){
                up = 1;
            }
            else if(![posSet containsObject:@1]){
                left = 1;
            }else if(![posSet containsObject:@5]){
                down = 1;
            }else if(![posSet containsObject:@7]){
                right = 1;
            }
            break;
        case 5:
            if(![posSet containsObject:@4]){
                up = 1;
            }else if(![posSet containsObject:@2]){
                left = 1;
            }else if(![posSet containsObject:@8]){
                right = 1;
            }
            break;
        case 6:
            if(![posSet containsObject:@3]){
                left = 1;
            }else if(![posSet containsObject:@7])
                down = 1;
            break;
        case 7:
            if(![posSet containsObject:@6]){
                up = 1;
            }else if(![posSet containsObject:@4]){
                left = 1;
            }else if(![posSet containsObject:@8]){
                down = 1;
            }
            break;
        case 8:
            if(![posSet containsObject:@7]){
                up = 1;
            }else if(![posSet containsObject:@5])
                left = 1;
            break;
        default:
            break;
    }
    
    totOffsetX = 0;
    totOffsetY = 0;
    
    nowView.backgroundColor = [UIColor whiteColor];

}
    
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"%d %d %d %d",up,left,down,right);
    // 获取UITouch对象
    UITouch *touch = [touches anyObject];

    // 获取当前点
    CGPoint curP = [touch locationInView:nowView];

    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:nowView];

    // 获取x轴偏移量
    CGFloat offsetX = curP.x - preP.x;

    // 获取y轴偏移量
    CGFloat offsetY = curP.y - preP.y;
    
    if(!up && !down){
        offsetY = 0;
    }else if(!left && !right){
        offsetX = 0;
    }

    if(totOffsetY + offsetY < - up * SCREEN_WIDTH_DEVIEDS_THREE){
        offsetY = - up * SCREEN_WIDTH_DEVIEDS_THREE - totOffsetY;
    }else if(totOffsetX + offsetX < - left * SCREEN_WIDTH_DEVIEDS_THREE){
        offsetX = - left * SCREEN_WIDTH_DEVIEDS_THREE - totOffsetX;
    }else if(totOffsetY + offsetY > down * SCREEN_WIDTH_DEVIEDS_THREE){
        offsetY = down * SCREEN_WIDTH_DEVIEDS_THREE - totOffsetY;
    }else if(totOffsetX + offsetX > right * SCREEN_WIDTH_DEVIEDS_THREE){
        offsetX = right * SCREEN_WIDTH_DEVIEDS_THREE - totOffsetX;
    }
    
    totOffsetX += offsetX;
    totOffsetY += offsetY;
    

    
    // 修改view的位置（frame,center,transform）
    // 每次移动需要和上一次做比较, 所有使用CGAffineTransformTranslate
    nowView.transform = CGAffineTransformTranslate(nowView.transform, offsetX, offsetY);
    }
    
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    id p = nil;
    if(up){
        if (totOffsetY > - SCREEN_WIDTH_DEVIEDS_THREE * 0.5){
            nowView.transform = CGAffineTransformTranslate(nowView.transform, 0, -totOffsetY);
        } else {
            nowView.transform = CGAffineTransformTranslate(nowView.transform, 0, -SCREEN_WIDTH_DEVIEDS_THREE - totOffsetY);
            p = @([nowView.number intValue] - 1);
        }
    }else if(left){
        if (totOffsetX > - SCREEN_WIDTH_DEVIEDS_THREE * 0.5){
            nowView.transform = CGAffineTransformTranslate(nowView.transform, -totOffsetX, 0);
        } else {
            nowView.transform = CGAffineTransformTranslate(nowView.transform, -SCREEN_WIDTH_DEVIEDS_THREE - totOffsetX, 0);
            p = @([nowView.number intValue] - 3);
        }
    }else if(down){
        if (totOffsetY < SCREEN_WIDTH_DEVIEDS_THREE * 0.5){
            nowView.transform = CGAffineTransformTranslate(nowView.transform, 0, -totOffsetY);
        } else {
            nowView.transform = CGAffineTransformTranslate(nowView.transform, 0, SCREEN_WIDTH_DEVIEDS_THREE - totOffsetY);
            p = @([nowView.number intValue] + 1);
        }
    }else if(right){
        if (totOffsetX < SCREEN_WIDTH_DEVIEDS_THREE * 0.5){
            nowView.transform = CGAffineTransformTranslate(nowView.transform, -totOffsetX, 0);
        } else {
            nowView.transform = CGAffineTransformTranslate(nowView.transform, SCREEN_WIDTH_DEVIEDS_THREE - totOffsetX, 0);
            p = @([nowView.number intValue] + 3);
        }
    }

    if(p){
        [posSet addObject:p];
        [posSet removeObject:nowView.number];
        nowView.number = p;
    }
    
    int flag = 1;
    for(int i = 0;i < 8;i++){
        //NSLog(@"%@,%@",((UIView*)[viewArray objectAtIndex:i]).number,[finishArray objectAtIndex:i]);
        if(((UIView*)[viewArray objectAtIndex:i]).number != [finishArray objectAtIndex:i]){
            flag = 0;
            break;
        }
    }

    if(flag){
        NSLog(@"wow");
        [UIView animateWithDuration:1.5f animations:^{
            _boardView.alpha = 0.0f;
        }];
        //while(1);
        gg = 1;
    }
    
    nowView.backgroundColor = [UIColor grayColor];
    nowView = nil;
}


+ (void)saysayhello:(void(^)(void))say
{
    say();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    gg = 0;
    //NSLog(@"%zd",13);
    UIView *superView = self.view;
    UIView *boardView = [[UIView alloc]init];
    boardView.translatesAutoresizingMaskIntoConstraints = NO;
    boardView.backgroundColor = [UIColor blackColor];
    [superView addSubview:boardView];
    _boardView = boardView;
    //UIEdgeInsets padding = UIEdgeInsetsMake(SCREEN_WIDTH / 30, SCREEN_WIDTH / 30, SCREEN_WIDTH / 30, SCREEN_WIDTH / 30);
    
    viewArray = [[NSMutableArray alloc]init];
    posSet = [[NSMutableArray alloc]init];
    
    [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@SCREEN_WIDTH);
    }];
    
    startArray = [[NSArray alloc]initWithObjects:@4, @7, @1, @8, @3, @5, @6, @2, nil];
    finishArray = [[NSArray alloc]initWithObjects:@0, @3, @6, @1, @4, @7, @2, @5, nil];
    
    for(int i = 0;i < 8;i++){
        int j = i / 3 - 1;
        int k = i % 3 - 1;
        UITextView *tView = [[UITextView alloc]init];
        [boardView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(boardView.mas_centerX).with.offset(SCREEN_WIDTH_DEVIEDS_THREE * k);
            make.centerY.equalTo(boardView.mas_centerY).with.offset(SCREEN_WIDTH_DEVIEDS_THREE * j);
            make.width.equalTo(boardView.mas_width).dividedBy(10);
            make.height.equalTo(boardView.mas_height).dividedBy(10);
        }];
        tView.text = [NSString stringWithFormat:@"%d",i+1];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.textColor = [UIColor whiteColor];
        tView.font = [UIFont systemFontOfSize:64.f];
        tView.backgroundColor = [UIColor clearColor];
        tView.editable = NO;
        tView.selectable = NO;
    }
    
     
    for(int _i = 1;_i < 9;_i++){
        int i = [[startArray objectAtIndex:_i-1] intValue];
        //NSLog(@"%d--%d",_i,i);
        UIView* tempView = [[UIView alloc]init];
        tempView.translatesAutoresizingMaskIntoConstraints = NO;
        tempView.backgroundColor = [UIColor grayColor];
        [boardView addSubview:tempView];
      //  tempView.pos = i;
        int j = i / 3 - 1;
        int k = i % 3 - 1;
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(boardView.mas_centerX).with.offset(SCREEN_WIDTH_DEVIEDS_THREE * j);
            make.centerY.equalTo(boardView.mas_centerY).with.offset(SCREEN_WIDTH_DEVIEDS_THREE * k);
            make.width.equalTo(boardView.mas_width).dividedBy(2.99);
            make.height.equalTo(boardView.mas_height).dividedBy(2.99);
        }];
        
        tempView.number = @(i);

        [posSet addObject:tempView.number];
        
    //  NSLog(@"----------------------%@", tempView.number.stringValue);
    //  NSLog(@"++++++++++++++++++++++%@", tempView.idid.stringValue);
        
        
        UITextView* tView = [[UITextView alloc]init];
        [tempView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tempView.mas_centerX);
            make.centerY.equalTo(tempView.mas_centerY);
            make.width.equalTo(tempView.mas_width).dividedBy(3);
            make.height.equalTo(tempView.mas_height).dividedBy(3);
        }];
        tView.text = [NSString stringWithFormat:@"%d",_i];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.font = [UIFont systemFontOfSize:64.f];
        tView.backgroundColor = [UIColor clearColor];
        tView.editable = NO;
        tView.selectable = NO;
        
        //[num addObject:[NSNumber numberWithInt:i]];
        
        [viewArray addObject:tempView];
    }
    
    
}

@end


