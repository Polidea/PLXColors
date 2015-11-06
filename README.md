# PLXColors

[![CI Status](http://img.shields.io/travis/Polidea/PLXColors.svg?style=flat)](https://travis-ci.org/Polidea/PLXColors)
[![Version](https://img.shields.io/cocoapods/v/PLXColors.svg?style=flat)](http://cocoadocs.org/docsets/PLXColors)
[![License](https://img.shields.io/cocoapods/l/PLXColors.svg?style=flat)](http://cocoadocs.org/docsets/PLXColors)
[![Platform](https://img.shields.io/cocoapods/p/PLXColors.svg?style=flat)](http://cocoadocs.org/docsets/PLXColors)

PLXColors is a small library that allows you to create UIColor or NSColor objects based on the hexadecimal representation of the
colors, similar to that used in HTML and CSS languages. UIKit/AppKit allows you to create UIColor/NSColor objects only with floating
point numbers which is inconvenient when you get these values from graphics programs.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Methods

PLXColors provides four methods to create UIColor or NSColor objects:

```objc
+ (PLColor *)colorWithHexString:(NSString *)hexString;
+ (PLColor *)colorWithHexStringWithAlpha:(NSString *)hexString;
+ (PLColor *)colorWithHexInteger:(NSUInteger)value;
+ (PLColor *)colorWithHexIntegerWithAlpha:(NSUInteger)value;
```

where PLColor is UIColor or NSColor class depends on target platform.

See the code or [Documentation](http://cocoadocs.org/docsets/PLXColors) to check in which format should be parameters.

## Requirements

- iOS6 or OS X 10.8

## Installation

PLXColors is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "PLXColors"

## Author

Michał Laskowski, michal.laskowski@polidea.com

## License

PLXColors is available under the MIT license. See the LICENSE file for more info.
