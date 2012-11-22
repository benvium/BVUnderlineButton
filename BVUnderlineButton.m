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
    CGSize sz = [text sizeWithFont:self.titleLabel.font forWidth:rect.size.width lineBreakMode:UILineBreakModeWordWrap];
    CGFloat width = rect.size.width;
    CGFloat offset = (rect.size.width - sz.width) / 2;
    
    if (offset > 0 && offset < rect.size.width) {
        width -= offset;
    } else {
        offset = 0.0;
    }
    
    // Work out line spacing to put it just below text
    //  CGFloat baseline = rect.size.height + self.titleLabel.font.descender + 2;
    CGFloat baseline = rect.size.height + self.titleLabel.font.descender + self.underlinePosition - 0.5;
    
    // Draw a single line from left to right
    CGContextMoveToPoint(context, offset, baseline);
    CGContextAddLineToPoint(context, width, baseline);
    CGContextStrokePath(context);
}

-(void) setUnderlinePosition:(CGFloat)underlinePosition {
    _underlinePosition = underlinePosition;
    
    [self setNeedsDisplay];
}

@end