//
//  ChatView.m
//  ChatDemo
//
//  Created by lwx on 16/5/26.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "ChatView.h"


@interface ChatView () {
    UILabel *_lable;
    
    UILabel *_chatLable;
}



@end

@implementation ChatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)setCount:(NSUInteger)count {
    if (_count != count) {
        
        _count = count;
        
        [self setNeedsLayout];
    }
}

- (void)createView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(250, 4, 80, 40)];
    lable.text = @"购物车";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor redColor];
    [self addSubview:lable];
    _chatLable = lable;
    
    UILabel *countLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 4, 160, 40)];
    countLable.text = @"已经选择了0件商品";
    countLable.textColor = [UIColor magentaColor];
    [self addSubview:countLable];
    _lable = countLable;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lable.text = [NSString stringWithFormat:@"已经选择了%ld件商品",self.count];
}


- (CGPoint)chatPoint {
    
    
    CGPoint point  = _chatLable.center;
    CGPoint chatLableCenter = [_chatLable convertPoint:point toView:nil];
    
    
    
    return CGPointMake(point.x,chatLableCenter.y);
}


@end
