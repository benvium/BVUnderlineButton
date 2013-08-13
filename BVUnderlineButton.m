//
//  BVUnderlineButton.m
//  https://github.com/benvium/BVUnderlineButton
//
//  Created by Benjamin Clayton on 20/11/2012.
//  Copyright (c) 2012 Benjamin Clayton (benvium). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
#import "BVUnderlineButton.h"

@implementation BVUnderlineButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaults];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefaults];
    }
    return self;
}

- (void) setDefaults {
    [self addTarget: self action: @selector(touchDown:) forControlEvents: UIControlEventTouchDown];
    [self addTarget: self action: @selector(touchDown:) forControlEvents: UIControlEventTouchDragEnter];
    
    [self addTarget: self action: @selector(touchUp:) forControlEvents: UIControlEventTouchUpInside];
    [self addTarget: self action: @selector(touchUp:) forControlEvents: UIControlEventTouchUpOutside];
    [self addTarget: self action: @selector(touchUp:) forControlEvents: UIControlEventTouchCancel];
    [self addTarget: self action: @selector(touchUp:) forControlEvents: UIControlEventTouchDragExit];
    self.underlinePosition = -2.0;
}

- (void)touchDown: (id)sender
{
    [self setNeedsDisplay];
}

- (void)touchUp: (id)sender
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.currentTitleColor.CGColor);
    
    // Draw them with a 1.0 stroke width.
    CGContextSetLineWidth(context, 1.0);
    
    // Work out line width
    NSString *text = self.titleLabel.text;
    CGSize titleLabelSize = [text sizeWithFont:self.titleLabel.font forWidth:self.titleLabel.frame.size.width lineBreakMode:UILineBreakModeWordWrap];
    CGFloat width = titleLabelSize.width;
    
    // Work out starting point of the underline
    CGFloat xOffset = 0;
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
        xOffset = (rect.size.width - width) / 2;
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
        xOffset = rect.size.width - width;
    
    // If offset would be negative, we'll set it to 0
    xOffset = MAX(xOffset, 0);
    
    // If width would be more than our buttons width, we'll set it to the buttons width
    width = MIN(width, rect.size.width);
    
    // Work out our vertical baseline
    CGFloat textHeight = self.titleLabel.font.lineHeight;
    CGFloat yBaseline = 0 + textHeight; //roundf(rect.size.height + self.titleLabel.font.descender + self.underlinePosition);
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
        yBaseline = (rect.size.height + textHeight) / 2.0;
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
        yBaseline = rect.size.height - 1;
    
    // Round yBaseline, so its value has always that of a full pixel
    yBaseline = roundf(yBaseline);
    
    // Draw a single line from left to right
    CGContextMoveToPoint(context, xOffset, yBaseline);
    CGContextAddLineToPoint(context, xOffset + width, yBaseline);
    CGContextStrokePath(context);
}

-(void) setUnderlinePosition:(CGFloat)underlinePosition {
    _underlinePosition = underlinePosition;
    
    [self setNeedsDisplay];
}

@end