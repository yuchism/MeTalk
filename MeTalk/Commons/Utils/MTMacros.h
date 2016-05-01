//
//  MTMacros.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 7..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

// color macro
#define ColorFromHex( rgbValue ) ( [UIColor UIColorFromRGB:rgbValue ] )
#define ColorFromRGB( r , g , b ) ( [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1 ] )
#define ColorFromRGBA(r , g , b , a ) ( [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a ] )


// font macro : avenir
#define FontAvenirBlack( sizeValue )   ([UIFont fontWithName:@"Avenir-Black" size:sizeValue ])
#define FontAvenirBook( sizeValue )   ([UIFont fontWithName:@"Avenir-Book" size:sizeValue ])
#define FontAvenirMedium( sizeValue )   ([UIFont fontWithName:@"Avenir-Medium" size:sizeValue ])
#define FontAvenirHeavy( sizeValue )   ([UIFont fontWithName:@"Avenir-Heavy" size:sizeValue ])
#define FontAvenirRoman( sizeValue )   ([UIFont fontWithName:@"Avenir-Roman" size:sizeValue ])
#define FontAvenirLignt( sizeValue )   ([UIFont fontWithName:@"Avenir-Light" size:sizeValue ])

// font macro : avenirnext
#define FontAvenirnextRegular( sizeValue )   ([UIFont fontWithName:@"AvenirNext-Regular" size:sizeValue ])
#define FontAvenirnextDemiBold( sizeValue )   ([UIFont fontWithName:@"AvenirNext-DemiBold" size:sizeValue ])

// font macro : helveticaneue
#define FontHelveticaneue( sizeValue ) ([UIFont fontWithName:@"HelveticaNeue" size:sizeValue ])

#define UnitPerPixel  (1.0/[UIScreen mainScreen].scale)


#define kMainWindowWidth [[UIScreen mainScreen] bounds].size.width
#define kMainWindowHeight [[UIScreen mainScreen] bounds].size.height

#define kPRGraphColorTime   ColorFromRGBA(0xff, 0x00, 0x0c,0.7).CGColor
#define kPRGraphColor4_1   ColorFromRGBA(0xff, 0x00, 0x0c,0.25).CGColor
#define kPRGraphColor4_1Gradation   ColorFromRGBA(0xff, 0x00, 0x0c,0.25).CGColor

#define kPRGraphColor4_2   ColorFromRGBA(0xff, 0x00, 0x0c,0.15).CGColor

#define kPRGraphDisabledColor RGBA(0xff,0xff,0xff,0.1).CGColor

