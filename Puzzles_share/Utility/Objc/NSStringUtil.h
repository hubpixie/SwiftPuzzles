//
//  NSStringUtil.h
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/09/30.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Util)
-(NSString*)reverse;
-(NSInteger)convOtherbaseToDec:(int)base;
-(NSString*)convDecToOtherbase:(int)base;
@end
