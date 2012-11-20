BVUnderlineButton
=================

Simple UIButton subclass that draws a button with the title underlined.

Based on code originally found at http://davidjhinson.wordpress.com/2009/11/26/underline-text-on-the-iphone/ with all the fixes from the comments and some further tweaks.

This code requires ARC.

Usage
-----

Add BVUnderlineButton.m and BVUnderlineButton.h to your project.

If you're using a Storyboard or XIB files:
 - drag a UIButton to your stage, set the 'Type' (under Attributes Inspector / Button) to Custom
 - Set the Class (under Identity Inspector / Custom Class) to BVUnderlineButton.

If you're using code, just create the button as you would a regular Custom style UIButton, e.g.

    #import "BVUnderlineButton.h"

    BVUnderlineButton *button = [BVUnderlineButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self 
           action:@selector(aMethod:)
    forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"underlined" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [view addSubview:button];


 Adjusting the underline position
 --------------------------------

 Depending on the font you may wish to adjust the vertical position of the underline using the *underlinePosition* property. The default is -2 pixels. 

 If you're using a Storyboard or XIB files:
  - Select the BVUnderlineButton instance on your stage.
  - Open the 'Identity Inspector' and click the + under 'User Defined Runtime Attributes'
  - Type 'underlinePosition' for keyPath, choose 'Number' for type, and type in the new value as a floating-point number (e.g. 1)

  If you're using code, just set the underlinePosition property.

      button.underlinePosition = 1;