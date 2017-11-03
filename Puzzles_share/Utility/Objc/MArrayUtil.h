//
//  MArrayUtil.h
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/08/13.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MArrayUtil : NSObject
+(instancetype)sharedInstance;
-(NSArray*)combination:(NSArray*)array limit:(NSInteger)limit  block:(void(^)(NSArray*))itemEach;
-(NSArray*)combination_1:(NSArray*)array limit:(NSInteger)limit  block:(void(^)(NSArray*))itemEach;
@end
