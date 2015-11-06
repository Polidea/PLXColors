//
//  Created by Michał Laskowski <michal.laskowski@polidea.com>
//  Copyright (c) 2015 Polidea Sp. z o.o.
//

#import "PLXViewController.h"
#import "PLXView.h"

@interface PLXViewController ()

@end

@implementation PLXViewController

- (void)loadView {
    self.view = [PLXView new];
}

@end
