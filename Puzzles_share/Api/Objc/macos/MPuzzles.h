//
//  MPuzzles.h
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/04.
//  Copyright © 2017 venus.janne. All rights reserved.
//
//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "BigInteger.h"

@interface MPuzzles : NSObject
+ (instancetype)sharedInstance;
-(NSInteger)calculateDrivingRoutes01: (int)x y:(int)y;
-(CGFloat)calculateGoldenRatio01: (CGFloat)ratio limit:(int)limit;
-(BigInteger*)calculateShortestPath02:(int)limitX :(int)limitY;
//Q32-1,Q32-2
-(int)calculateTatamiPatterns:(int)h :(int)v;
-(int)calculateTatamiPatternsX2:(int)h :(int)v;
//Q33-1
-(int)calculateUtacartaWords;
//Q34-1
-(NSInteger)calculeteChessRange;
//Q35-1
-(BigInteger*)calculateEncounterPatterns:(int)limit;
//Q36-1
-(NSArray*)findCircularSevenZero:(int)limit;
//Q37-1
-(NSArray*)findDicePatterns:(int)limit;
//Q37-2
-(NSArray*)findDicePatterns02:(int)limit;
//Q38-1
-(NSArray*)findNumberSwitchPatterns;
@end
