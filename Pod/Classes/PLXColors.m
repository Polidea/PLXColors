//
//  Created by Michał Laskowski <michal.laskowski@polidea.com>
//  Copyright (c) 2015 Polidea Sp. z o.o.
//

#import "PLXColors.h"


@implementation PLXColor (PLColors)

+ (PLXColor *)colorWithHexString:(NSString *)hexString {
    if (hexString.length == 3 || (hexString.length == 4 && [hexString characterAtIndex:0] == '#')) {
        hexString = [hexString stringByAppendingString:@"F"];
    }
    else {
        hexString = [hexString stringByAppendingString:@"FF"];
    }

    return [PLXColor colorWithHexStringWithAlpha:hexString];
}

+ (PLXColor *)colorWithHexStringWithAlpha:(NSString *)hexString {
    if (hexString.length > 0 && [hexString characterAtIndex:0] == '#') {
        hexString = [hexString substringFromIndex:1];
    }

    if (hexString.length != 4 && hexString.length != 8) {
        return nil;
    }

    if (hexString.length == 4) {
        unichar char0 = [hexString characterAtIndex:0];
        unichar char1 = [hexString characterAtIndex:1];
        unichar char2 = [hexString characterAtIndex:2];
        unichar char3 = [hexString characterAtIndex:3];
        hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c", char0, char0, char1, char1, char2, char2, char3, char3];
    }

    NSString *componentPattern = @"[0-9A-Fa-f]{2}";
    NSString *pattern = [NSString stringWithFormat:@"^(%@)(%@)(%@)(%@)$", componentPattern, componentPattern, componentPattern, componentPattern];

    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:hexString options:0 range:NSMakeRange(0, hexString.length)];
    if (matches.count != 1) {
        return nil;
    }

    NSTextCheckingResult *result = matches[0];
    if (result.numberOfRanges != 5) {
        return nil;
    }

    CGFloat red = [PLXColor normalizedFloatColorComponentFromHexString:[hexString substringWithRange:[result rangeAtIndex:1]]];
    CGFloat green = [PLXColor normalizedFloatColorComponentFromHexString:[hexString substringWithRange:[result rangeAtIndex:2]]];
    CGFloat blue = [PLXColor normalizedFloatColorComponentFromHexString:[hexString substringWithRange:[result rangeAtIndex:3]]];
    CGFloat alpha = [PLXColor normalizedFloatColorComponentFromHexString:[hexString substringWithRange:[result rangeAtIndex:4]]];

    if (red < 0.f || green < 0.f || blue < 0.f || alpha < 0.f) {
        return nil;
    }

    return [PLXColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (PLXColor *)colorWithHexInteger:(NSUInteger)value {
    if (value > 0xFFFFFF) {
        return nil;
    }

    CGFloat blue = [PLXColor normalizedFloatColorComponentFromInteger:(value & 0xFF)];
    value >>= 8;
    CGFloat green = [PLXColor normalizedFloatColorComponentFromInteger:(value & 0xFF)];
    value >>= 8;
    CGFloat red = [PLXColor normalizedFloatColorComponentFromInteger:(value & 0xFF)];

    return [PLXColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (PLXColor *)colorWithHexIntegerWithAlpha:(NSUInteger)value {
    NSUInteger alphaIntComponent = value & 0xFF;
    CGFloat alphaFloatValue = [PLXColor normalizedFloatColorComponentFromInteger:alphaIntComponent];
    if (alphaFloatValue < 0.f) {
        return nil;
    }

    return [[PLXColor colorWithHexInteger:(value >> 8)] colorWithAlphaComponent:alphaFloatValue];
}

+ (CGFloat)normalizedFloatColorComponentFromInteger:(NSUInteger)value {
    if (value > 255) {
        return -1.0f;
    }

    return value / 255.0f;
}

+ (CGFloat)normalizedFloatColorComponentFromHexString:(NSString *)hexString {
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"0x%@", hexString]];
    unsigned int intValue;
    BOOL result = [scanner scanHexInt:&intValue];
    if (!result) {
        return -1.0f;
    }

    return [PLXColor normalizedFloatColorComponentFromInteger:intValue];
}


@end