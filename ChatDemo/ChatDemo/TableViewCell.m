//
//  TableViewCell.m
//  ChatDemo
//
//  Created by lwx on 16/5/26.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
@interface TableViewCell () {
    UIView *_bgView;
    UIButton *_button;
    UIImageView *_imageView;
}



@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatView];
        
        
    }
    return self;
}


- (void)creatView {
    
    UIView *bgView = [UIView new];
    [self.contentView addSubview:bgView];
    _bgView = bgView;
    
    
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    _imageView = imageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    _button = button;
}

- (void)buttonClick:(UIButton *)sender {
    
    UIImage *image = _imageView.image;
    
    if (image) {
        self.tagHandle(sender,image,_imageView);
    }
    
    
}


- (void)buttonHandle:(AddBlock)block{
    self.tagHandle = block;
}


- (void)setUrl:(NSString *)url {
    if (_url != url) {
        _url = url;
        
        [self setNeedsLayout];
    }
}

- (void)setAllDefalut {
    [_bgView removeFromSuperview];
    _bgView = nil;
    [self creatView];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.url) {
        
        _bgView.frame = self.bounds;
        
        _imageView.frame = CGRectMake(5, 5, 150, 150);
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.url]];
        
        _button.frame = CGRectMake(220, 40, 80, 80);
        
    }
    
}


@end










