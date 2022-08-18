//
//  UIView+common.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "UIView+common.h"

@implementation UIView (common)

+ (instancetype)instanceFromNib {

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[[self class] cellReuseIdentifier] bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)addRoundedCorners:(UIRectCorner)corners withRadius:(CGSize)radius {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (CGFloat)jn_width
{
    return self.frame.size.width;
}

-(void)setJn_width:(CGFloat)jn_width
{
    CGRect rect = self.frame;
    rect.size.width = jn_width;
    self.frame = rect;
}

- (CGFloat)jn_height
{
    return self.frame.size.height;
}
-(void)setJn_height:(CGFloat)jn_height
{
    CGRect rect = self.frame;
    rect.size.height = jn_height;
    self.frame = rect;
}



- (CGFloat)jn_x
{
    return self.frame.origin.x;
    
}

-(void)setJn_x:(CGFloat)jn_x
{
    CGRect rect = self.frame;
    rect.origin.x = jn_x;
    self.frame = rect;
}
- (CGFloat)jn_y
{
    
    return self.frame.origin.y;
}

-(void)setJn_y:(CGFloat)jn_y
{
    CGRect rect = self.frame;
    rect.origin.y = jn_y;
    self.frame = rect;
}

- (CGFloat)jn_centerX
{
    return self.center.x;
}

-(void)setJn_centerX:(CGFloat)jn_centerX
{
    CGPoint center = self.center;
    center.x = jn_centerX;
    self.center = center;
}

- (CGFloat)jn_centerY
{
    return self.center.y;
}

-(void)setJn_centerY:(CGFloat)jn_centerY
{
    CGPoint center = self.center;
    center.y = jn_centerY;
    self.center = center;
}
-(void)setJn_right:(CGFloat)jn_right{
    CGRect newFrame   = self.frame;
    newFrame.origin.x = jn_right - self.frame.size.width;
    self.frame        = newFrame;
}
-(CGFloat)jn_right{
    return self.frame.origin.x + self.frame.size.width;
}
@end
