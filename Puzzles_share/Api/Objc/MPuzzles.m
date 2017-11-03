//
//  CPuzzles.m
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/04.
//  Copyright © 2017 venus.janne. All rights reserved.
//
#import "MPuzzles.h"
#import "MStack.h"
#import "NSStringUtil.h"
#import "MArrayUtil.h"


@interface Q27State: NSObject
@property (nonatomic, assign) short direct;
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, strong) NSDictionary *usedRoute;
@property (nonatomic, strong) NSString *drivenRoutes;
-(Q27State*)clone;
@end

@implementation Q27State

-(Q27State*)clone {
    Q27State* newInst = [[Q27State alloc] init];
    newInst.direct = self.direct;
    newInst.x = self.x;
    newInst.y = self.y;
    newInst.usedRoute = [NSDictionary dictionaryWithDictionary:self.usedRoute];
    newInst.drivenRoutes = [NSString stringWithString:self.drivenRoutes];
    return newInst;
}

@end

typedef struct position_struct {
    int x1;
    int y1;
    int x2;
    int y2;
} position_t;

@interface Q31State: NSObject
@property (nonatomic, assign) short depth;
@property (nonatomic, assign) position_t orgin;
@property (nonatomic, strong) NSSet *usedRoute;
@property (nonatomic, strong) NSString *routesFrom;
@property (nonatomic, strong) NSString *routesTo;
@end

@implementation Q31State

@end

typedef struct Q32_State_Struct {
    __unsafe_unretained NSArray* pattern;
    int xx;
    int yy;
    int tatami_cnt;
} Q32State_t;

typedef struct Q38_State_Struct {
    __unsafe_unretained NSArray* pattern;
    int times;
} Q38State_t;

@interface NSValue (user_struct)
+ (instancetype)valueWithPosition:(position_t)value;
+ (instancetype)valueWithState32:(Q32State_t)value;
@property (readonly) position_t positionValue;
@property (readonly) Q32State_t state32Value;
@end

@implementation NSValue (user_struct)
+ (instancetype)valueWithPosition:(position_t)value
{
    return [self valueWithBytes:&value objCType:@encode(position_t)];
}
+ (instancetype)valueWithState32:(Q32State_t)value
{
    return [self valueWithBytes:&value objCType:@encode(Q32State_t)];
}
+ (instancetype)valueWithState38:(Q38State_t)value
{
    return [self valueWithBytes:&value objCType:@encode(Q38State_t)];
}

- (position_t) positionValue
{
    position_t value;
    [self getValue:&value];
    return value;
}
- (Q32State_t) state32Value
{
    Q32State_t value;
    [self getValue:&value];
    return value;
}
- (Q38State_t) state38Value
{
    Q38State_t value;
    [self getValue:&value];
    return value;
}
@end

@implementation MPuzzles
+ (instancetype)sharedInstance {
    static MPuzzles *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPuzzles alloc] init];
    });
    return sharedInstance;
}


-(NSInteger)calculateDrivingRoutes01: (int)limitX y:(int)limitY {
    MStack* stateLst = [[MStack alloc] initWithArray:@[]];

    __block Q27State *wkState = [Q27State new];
    wkState.direct = 3;
    wkState.x = 0;
    wkState.y = 0;
    wkState.usedRoute = @{};
    wkState.drivenRoutes = [NSString stringWithFormat:@"(%d,%d)", wkState.x, wkState.y];
    [stateLst pushObject:wkState];
    
    NSInteger retVal = 0;
    
    NSString* (^useRouteStr)(int, int, int, int) = ^(int x1, int y1, int x2, int y2) {
        
        return [NSString stringWithFormat:@"(%d,%d)-(%d,%d)",
                x1 <= x2 ? x1 : x2,
                y1 <= y2 ? y1 : y2,
                x1 <= x2 ? x2 : x1,
                y1 <= y2 ? y2 : y1];
    };

    while(stateLst.count > 0) {
        
        //pop last object
        Q27State *poppedState = [stateLst popObject];
        
        //judge searching is clear
        if(poppedState.x == limitX && poppedState.y == limitY) {
            retVal += 1;
            
            NSLog(@"Answer: %ld", (long)retVal);
            NSLog(@"%@", poppedState.drivenRoutes);
            continue;
        }
        
        //
        void (^pushState)(BOOL) = ^(BOOL turn) {
            wkState = [wkState clone];
            if (turn) {
                wkState.direct = (poppedState.direct + 1) % 4;
            } else {
                wkState.direct = poppedState.direct;
            }
                    
            int xx = 0, yy = 0;
            if(wkState.direct == 0) {yy = 1;}
            if(wkState.direct == 1) {xx = -1;}
            if(wkState.direct == 2) {yy = -1;}
            if(wkState.direct == 3) {xx = 1;}
            
            wkState.x = poppedState.x + xx;
            wkState.y = poppedState.y + yy;
            
            if (wkState.x < 0 || wkState.x > limitX) {return;}
            if (wkState.y < 0 || wkState.y > limitY) {return;}
            //#p "[A] ---- x = #{poppedState.x}, y= #{poppedState.y}, direct = #{wkState.direct}, x = #{wkState.x}, y = #{wkState.y}"
            
            //# use route
            NSString* routeUsed = useRouteStr(poppedState.x, poppedState.y, wkState.x, wkState.y);
            //#p "[B] ---- #{routeUsed}"
            if ([poppedState.usedRoute  objectForKey:routeUsed]) {return;}
            NSMutableDictionary* udic = [NSMutableDictionary dictionaryWithDictionary:poppedState.usedRoute];
            [udic setObject:routeUsed forKey:routeUsed];
            wkState.usedRoute = udic; //[NSDictionary dictionaryWithDictionary:udic];
            
            wkState.drivenRoutes = [poppedState.drivenRoutes stringByAppendingFormat:@"->(%d,%d)", wkState.x, wkState.y];
            [stateLst pushObject:wkState];
        };
        
        pushState(NO);
        pushState(YES);
    }
    return retVal;
}

-(CGFloat)calculateGoldenRatio01: (CGFloat)ratio limit:(int)limit {
    __block CGFloat retVal = CGFLOAT_MAX;
    [[self calc29_proc:limit] enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
        CGFloat v = [(NSNumber*)obj doubleValue];
        if (fabs(ratio - v) < fabs(ratio - retVal)) {
            retVal = v;
        }
    }];
    return retVal;
}

-(NSArray*)calc29_proc:(NSInteger)limit {
    NSMutableDictionary* memDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@[@1], @"1", nil];
    NSMutableDictionary* memPallelDict = [NSMutableDictionary dictionary];
    
    NSArray* (^calc29_func)(NSInteger);
    __block  NSArray* (^calc29_block)(NSInteger) = calc29_func = ^NSArray*(NSInteger cnt) {
        NSString* keyMem = [NSString stringWithFormat:@"%ld", cnt];
        if([memDict objectForKey:keyMem]) {
            return [memDict objectForKey:keyMem];
        }
        NSMutableArray* ret = [NSMutableArray array];
        [calc29_block(cnt - 1) enumerateObjectsUsingBlock:^(id x, NSUInteger idx, BOOL *stop) {
            // Body of the function
            @autoreleasepool {
                NSNumber* x1 = [NSNumber numberWithDouble:[(NSNumber*)x doubleValue] + 1];
                [ret addObject:x1];
            }
        }];
        
        NSMutableArray* arr = [NSMutableArray array];
        for(int i = 1; i <= cnt - 1; i ++) {
            @autoreleasepool {
                [arr addObject:[NSNumber numberWithInt:i]];
            }
        }

        for(int i = 2; i <= cnt; i++) {
            @autoreleasepool {
                NSMutableDictionary *cutDict = [NSMutableDictionary dictionary];
                [[MArrayUtil sharedInstance] combination:arr limit:i - 1  block:^(NSArray* item){
                    //                NSLog(@"2222 ,item = %@, [arr] = %@", item, arr);
                    CGFloat pos = 0;
                    NSMutableArray* newItem = [NSMutableArray array];
                    for(NSNumber* num in item) {
                        [newItem addObject:[NSNumber numberWithDouble:[num doubleValue] - pos]];
                        pos = [num doubleValue];
                    }
                    [newItem addObject:[NSNumber numberWithInteger:cnt - pos]];
                    newItem = [NSMutableArray arrayWithArray:
                               [newItem sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        
                        return [(NSNumber*)a compare:(NSNumber*)b];
                    }]];
                    [cutDict setObject:newItem forKey:[NSString stringWithFormat:@"%@", newItem]];
                }];
                
                NSMutableArray* keys = [NSMutableArray array];
                [[cutDict allValues] enumerateObjectsUsingBlock:^(id  obj1, NSUInteger idx1, BOOL * stop1) {
                    NSMutableArray* keyEatch = [NSMutableArray array];
                    [(NSArray*)obj1 enumerateObjectsUsingBlock:^(id  obj2, NSUInteger idx2, BOOL * stop2) {
                        [keyEatch addObject: calc29_block([(NSNumber*)obj2 integerValue])];
                    }];
                    [keys addObject:keyEatch];
                }];
                
                [keys enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
                    [[self product_proc:(NSArray*)obj] enumerateObjectsUsingBlock:^(id  obj2, NSUInteger idx2, BOOL * stop2) {
                        NSString* k = [NSString stringWithFormat:@"%@", obj2];
                        if(![memPallelDict objectForKey:k]) {
                            [memPallelDict setObject:@"1" forKey:k];
                            [ret addObject:[NSNumber numberWithDouble:[self parallel:(NSArray*)obj2]]];
                        }
                    }];
                }];
            }
        }
        
        [memDict setObject:ret forKey:keyMem];
        return ret;
    };
    return calc29_block(limit);
}

-(NSArray*)product_proc: (NSArray*)arr  {
    NSMutableArray* retArray = [NSMutableArray array];
    
    void (^product_func)(NSInteger, NSArray*, NSArray*);
    __block void(^product_block)(NSInteger, NSArray*, NSArray*) = product_func = ^(NSInteger cnt, NSArray* inArr, NSArray* outArr) {
        NSArray* outArrTmp =  [NSMutableArray arrayWithArray:outArr];
        if (cnt == arr.count) {
            [retArray addObject:outArr];
            outArrTmp = [NSMutableArray array];
            return ;
        }
        NSArray *subArr = [arr objectAtIndex:cnt];
        for(int i = 0; i < [subArr count];i++) {
            product_block(cnt + 1, arr, [outArrTmp arrayByAddingObject:[subArr objectAtIndex:i]]);
        }
        return;
    };
    NSArray* outArr = @[];
    product_block(0, arr, outArr);
    return retArray;
}

-(CGFloat)parallel:(NSArray*)arr {
    //[arr valueForKeyPath:@"@sum.self"];
    CGFloat sumValue = 0.0;
    for(NSNumber* num in arr) {
        sumValue += 1 / [num doubleValue];
    }
    return 1 / sumValue;
}

-(BigInteger*)calculateShortestPath02:(int)limitX :(int)limitY  {
    MStack* stateLst = [[MStack alloc] initWithArray:@[]];
    
    __block Q31State *wkState = [Q31State new];
    wkState.depth = 2;
    position_t orgins;
    orgins.x1 = 0; orgins.y1 = 1;
    orgins.x2 = 1; orgins.y2 = 0;
    wkState.orgin = orgins;
    wkState.usedRoute = [NSSet setWithObject:[NSValue valueWithPosition: wkState.orgin]];
    wkState.routesFrom = [NSString stringWithFormat:@"(%d,%d)", wkState.orgin.x1, wkState.orgin.y1];
    wkState.routesTo = [NSString stringWithFormat:@"(%d,%d)", wkState.orgin.x2, wkState.orgin.y2];
    [stateLst pushObject:wkState];
    
    BigInteger* retVal = [BigInteger createFromInt:0];
    
    position_t (^useRoute_check)(int, int, int, int) = ^(int x1, int y1, int x2, int y2) {
        position_t pos;
        pos.x1 = x1 < x2 ? x1 : x2;
        pos.y1 = y1 < y2 ? y1 : y2;
        pos.x2 = x1 < x2 ? x2 : x1;
        pos.y2 = y1 < y2 ? y2 : y1;
        return pos;
    };

    //void (^push_state_func)(Q31State *, BOOL, int, int);
    void(^push_state_block)(Q31State *, BOOL, int, int) = ^void(Q31State *poppedState, BOOL gone, int xx, int yy) {
        if (xx < 0 || limitX < xx) return;
        if (yy < 0 || limitY < yy) return;

        wkState = [Q31State new];
        wkState.depth = poppedState.depth + 1;
        if (gone) { //往路の場合
            //使用済の道路は使用不可
            position_t pos = poppedState.orgin;
            pos.x1 = xx; pos.y1 = yy;
            wkState.orgin = pos;

            pos = useRoute_check(poppedState.orgin.x1, poppedState.orgin.y1, xx, yy);
            if ([poppedState.usedRoute containsObject:[NSValue valueWithPosition:pos]]) return;

            wkState.usedRoute = [NSSet setWithArray:[poppedState.usedRoute allObjects]];
            wkState.usedRoute = [wkState.usedRoute setByAddingObject:[NSValue valueWithPosition: pos]];

            wkState.routesFrom = [NSString stringWithFormat:@"%@,(%d,%d)", poppedState.routesFrom, xx, yy];
            wkState.routesTo = [NSString stringWithFormat:@"%@", poppedState.routesTo];
            
            [stateLst pushObject:wkState];
        }
        else { //復路の場合
            //使用済の道路は使用不可
            position_t pos = poppedState.orgin;
            pos.x2 = xx; pos.y2 = yy;
            wkState.orgin = pos;
            
            pos = useRoute_check(poppedState.orgin.x2, poppedState.orgin.y2, xx, yy);
            if ([poppedState.usedRoute containsObject:[NSValue valueWithPosition:pos]]) return;
            
            wkState.usedRoute = [NSSet setWithArray:[poppedState.usedRoute allObjects]];
            wkState.usedRoute = [wkState.usedRoute setByAddingObject:[NSValue valueWithPosition: pos]];
            
            wkState.routesFrom = [NSString stringWithFormat:@"%@", poppedState.routesFrom];
            wkState.routesTo = [NSString stringWithFormat:@"%@,(%d,%d)", poppedState.routesTo, xx, yy];
            
            [stateLst pushObject:wkState];
        }
        wkState = nil;
    };
    
    while (stateLst.count > 0) {
        @autoreleasepool {
            Q31State *poppedState = [stateLst popObject];
            
            BOOL cleared1 = (poppedState.orgin.x1 == limitX && poppedState.orgin.y1 == limitY);
            BOOL cleared2 = (poppedState.orgin.x2 == limitX && poppedState.orgin.y2 == limitY);
        
            if (cleared1 && cleared2) {
                retVal = [retVal add:[BigInteger createFromInt:1]];
                //Console.WriteLine("解{0}を発見", AnswerCnt);
                //Console.WriteLine("経路1={0}", Popped.Log1);
                //Console.WriteLine("経路2={0}", Popped.Log2);
                continue;
            }
        
            BOOL gone; //往路ならTrue、復路ならFalse
            if (cleared1 == NO && cleared2 == NO) {
                gone = (poppedState.depth % 2 == 0);
            }
            else if (cleared1 == NO){
                gone = YES;
            }
            else {
                gone = NO;
            }
        
            //往路の場合
            if (gone) {
                push_state_block(poppedState, gone, poppedState.orgin.x1, poppedState.orgin.y1 + 1);
                push_state_block(poppedState, gone, poppedState.orgin.x1 + 1, poppedState.orgin.y1);
            }
            else { //復路の場合
                push_state_block(poppedState, gone, poppedState.orgin.x2, poppedState.orgin.y2 + 1);
                push_state_block(poppedState, gone, poppedState.orgin.x2 + 1, poppedState.orgin.y2);
            }
            
            poppedState = nil;
       }
    }
    
    return [retVal multiply:[BigInteger createFromInt:2]];
}

//Q32-1
-(int)calculateTatamiPatterns:(int)h :(int)v {
    MStack* stateLst = [[MStack alloc] initWithArray:@[]];
    int limitX = v;
    int limitY = h;
    
    __block Q32State_t wkState;
    NSMutableArray* pattArr = [NSMutableArray array];
    NSString* pattStr = nil;
    for (int i = 0; i < limitX; i++) {
        pattStr = [@"" stringByPaddingToLength:limitY withString:@" " startingAtIndex:0];
        [pattArr addObject:pattStr];
    }
    wkState.pattern = pattArr;
    wkState.xx = 0;
    wkState.yy = 0;
    wkState.tatami_cnt = 0;
    
    [stateLst pushObject:[NSValue valueWithState32:wkState]];
    
    int retVal = 0;
    
    //convert a number into char.
    char (^convDec2CHar)(int) = ^char(int num) {
        if (num < 10) {
            return (char)((int)'1' + num - 1);
        } else{
            return (char)((int)'A' + num - 10);
        }
    };

    ////judge cross pattern
    BOOL (^judge_cross)(int, int, NSArray*) = ^BOOL(int xx, int yy, NSArray* pattArr)
    {
        //judge cross position of top/bottom/left/right
        if (xx - 1 < 0) return NO;
        if (yy - 1 < 0) return NO;
        NSString* str1 = [pattArr objectAtIndex:xx - 1];
        NSString* str2 = [pattArr objectAtIndex:xx];
        if ([str1 characterAtIndex:yy - 1] == [str1 characterAtIndex: yy]) return NO;
        if ([str1 characterAtIndex:yy - 1] == [str2 characterAtIndex:yy - 1]) return NO;
        if ([str1 characterAtIndex:yy - 1] == [str2 characterAtIndex:yy]) return NO;
        return true;
    };
    
    //adjust reserved patterns
    NSArray* (^adjust_reverved_list)(char) = ^NSArray*(char patt) {
        NSMutableArray* ret = [NSMutableArray array];
        if (patt == '-') {
            [ret addObject:@[@1]];
            [ret addObject:@[@1]];
        }
        if (patt == '|') {
            [ret addObject:@[@1,@1]];
        }
        return ret;
    };

    //judge if a piece of tatami can be filled.
    BOOL (^judge_fill_pieces)(NSArray*, int, int, NSArray*) = ^BOOL(NSArray* reserved_list, int xx, int yy, NSArray* pattArr)
    {
        for (int ii = 0; ii < [reserved_list count]; ii++) {
            if (xx + ii >= limitX) return NO;
            for (int jj = 0; jj < [reserved_list[0] count]; jj++) {
                if (yy + jj >= limitY) return NO;
                if (reserved_list[ii][jj] && [pattArr[xx + ii] characterAtIndex:yy + jj] != ' ')
                    return NO;
            }
        }
        return YES;
    };

    while (stateLst.count > 0) {
        Q32State_t poppedState = [[stateLst popObject] state32Value];
        if(poppedState.tatami_cnt == limitX * limitY / 2) {
            retVal ++;
            [self q32_printPatt:poppedState.pattern :limitX :limitY];
            continue;
        }
        
        //adjust coordinate x.
        if (poppedState.xx >= limitX) {
            poppedState.xx = 0;
            poppedState.yy ++;
        }
        if (poppedState.yy >= limitY) {
            continue;
        }
    
        NSArray* tatamiChars = @[@'-', @'|'];
        for (NSNumber* chr in tatamiChars) {
            NSArray* resrvArr = adjust_reverved_list([chr charValue]);

            //judge if a piece of tatami can be filled
            // - continue if false
            if (!judge_fill_pieces(resrvArr, poppedState.xx, poppedState.yy, poppedState.pattern))
                continue;

            //push stack if a piece can be filled.
            //wkState = [Q32State new];
            wkState.xx = poppedState.xx + 1;
            wkState.yy = poppedState.yy;
            wkState.tatami_cnt = poppedState.tatami_cnt + 1;
            
            NSMutableArray *newPattArr = [NSMutableArray arrayWithArray:poppedState.pattern];
            for (int ii = 0; ii < [resrvArr count]; ii++) {
                for (int jj = 0; jj < [resrvArr[0] count]; jj++) {
                    if (!resrvArr[ii][jj]) continue;
                    NSString* rowStr = newPattArr[poppedState.xx + ii];
                    char c = convDec2CHar(wkState.tatami_cnt);
                    rowStr = [rowStr stringByReplacingCharactersInRange:NSMakeRange(poppedState.yy + jj, 1) withString:[NSString stringWithFormat:@"%c", c]];
                    [newPattArr setObject:rowStr atIndexedSubscript:poppedState.xx + ii];
                }
            }

            wkState.pattern = newPattArr;
            if (!judge_cross(poppedState.xx, poppedState.yy, wkState.pattern))
                [stateLst pushObject:[NSValue valueWithState32:wkState]];
        }

        //push into stack without filling tatamis.
        if ([poppedState.pattern[poppedState.xx] characterAtIndex:poppedState.yy] != ' ') {
            wkState.pattern = [NSArray arrayWithArray:poppedState.pattern];
            wkState.xx = poppedState.xx + 1;
            wkState.yy = poppedState.yy;
            wkState.tatami_cnt = poppedState.tatami_cnt;
            [stateLst pushObject:[NSValue valueWithState32:wkState]];
        }
    }
    return retVal;
}

//print patterns result for tatami.
-(void) q32_printPatt:(NSArray*) arr :(int)limitX :(int)limitY {
    
    NSMutableArray* pattArr = [NSMutableArray arrayWithArray:arr];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@ || self CONTAINS[cd] %@", @"-", @"|"];
    //set '-' and '|'
    while ([[pattArr filteredArrayUsingPredicate:predicate] count] < 1 ) {
        for (int ii = 0; ii < limitX; ii++) {
            NSString* str = [pattArr objectAtIndex:ii];
            for (int jj = 0; jj < limitY; jj++) {
                char c = [str characterAtIndex:jj];
                if (c == '-' || c == '|')
                    continue;

                //adjust layout '-' if the same number
                BOOL sameXX = NO;
                for (int x = 0; x < limitX; x++) {
                    if (x == ii) continue;
                    NSString* str2 = [pattArr objectAtIndex:x];
                    if ([str2 characterAtIndex:jj] == c) {
                        str2 = [str2 stringByReplacingCharactersInRange:NSMakeRange(jj, 1) withString:@"-"];
                        [pattArr setObject:str2 atIndexedSubscript:x];
                        sameXX = YES;
                        break;
                    }
                }
                
                str = [str stringByReplacingCharactersInRange:NSMakeRange(jj, 1) withString:(sameXX ? @"-" : @"|")];
                [pattArr setObject:str atIndexedSubscript:ii];
            }
        }
    }

    NSString* outStr = @"";
    for (int jj = 0; jj < limitY; jj++) {
        outStr = [outStr stringByAppendingString:@"\n"];
        for (int ii = 0; ii < limitX; ii++) {
            outStr = [outStr stringByAppendingFormat: @"%c", [pattArr[ii] characterAtIndex:jj]];
        }
    }
    puts([outStr UTF8String]);
}

//Q32-2
-(int)calculateTatamiPatternsX2_x:(int)h :(int)v {
    NSMutableArray* tatamiArr = [NSMutableArray array];
    NSMutableArray* cornerArr = [NSMutableArray array];
    NSArray* dArr =@[@[@0, @1, @('-')], @[@1, @0, @('|')]];
//    NSMutableDictionary* memoDic = [NSMutableDictionary dictionary];
    
    for(int i =0; i < h + 2; i++) {
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        
        for(int j =0; j < v + 2; j++) {
            [arr1 addObject:@('\0')];
            [arr2 addObject:@0];
        }
        [tatamiArr addObject:arr1];
        [cornerArr addObject:arr2];
    }

    int (^dfs2)(int, int);
    __block int (^dfs)(int,int) = dfs2 = ^int(int x, int y) {
//        NSString* key = [NSString stringWithFormat:@"%d-%d", x, y];
//        if (memoDic[key]) {
//            return [memoDic[key] intValue];
//        }
        if(x==h){
            for(int i=0;i<h;i++) {
                NSString* str = @"";
                for (int j = 0; j < v; j++) {
                    str = [NSString stringWithFormat:@"%@%c", str, [tatamiArr[i][j] charValue]];
                }
                printf("%s\n", [str UTF8String]);
            }
            puts("");
            return 1;
        }
        if(y==v)return dfs(x+1,0);
        if([tatamiArr[x][y] charValue])return dfs(x,y+1);
        int l,r = 0;
        for(int k=0;k<2;k++) {
            int d0 = [dArr[k][0] intValue];
            int d1 = [dArr[k][1] intValue];
            if(x + d0 < h
               && y+d1 < v
               && ![tatamiArr[x+d0][y+d1] charValue]) {
                tatamiArr[x][y] = tatamiArr[x+d0][y+d1]=dArr[k][2];
                for(l=0;l<4;l++) {
                    NSNumber* val = cornerArr[x+l/2*(d0+1)][y+l/2*(d1+1)];
                    cornerArr[x+l/2*(d0+1)][y+l/2*(d1+1)] = [NSNumber numberWithInt:[val intValue] + 1];
                }
                for(l=0;l<4;l++) {
                    if([cornerArr[x+l/2*(d0+1)][y+l/2*(d1+1)] intValue] > 3)break;
                }
                if(l == 4) {
                    r+=dfs(x,y+1);
                }
                for(l=0;l<4;l++) {
                    NSNumber* val = cornerArr[x+l/2*(d0+1)][y+l/2*(d1+1)];
                    cornerArr[x+l/2*(d0+1)][y+l/2*(d1+1)] = [NSNumber numberWithInt:[val intValue] - 1];
                }
                tatamiArr[x][y]=@('\0'); tatamiArr[x+d0][y+d1]=@('\0');
            }
        }
//        memoDic[key] = @(r);
        return r;
    };
    return dfs(0, 0);
}

-(int)calculateTatamiPatternsX2:(int)h :(int)v {
    int L = 30;
//    char tatamiArr[50][50];
//    int cornerArr[50][50];
//    int dArr[2][3] ={{0,1,'-'},{1,0,'|'}};

//    char *_tatami = &tatamiArr[0][0];
//    int *_corner = &cornerArr[0][0];
//    int *_d = &dArr[0][0];

    __block char **tatami = nil;
    __block int **corner = nil;
    int **D = nil;
    
    tatami = malloc(L * sizeof(char*));
    corner = malloc(L * sizeof(int*));
    for (int i = 0; i < L; i++) {
        tatami[i] = malloc(L * sizeof(char));
        corner[i] = malloc(L * sizeof(int));
        for (int j = 0; j < L; j++) {
            tatami[i][j] = '\0';
            corner[i][j] = 0;
        }
    }
    
    D = malloc(2 * sizeof(int*));
    for (int i = 0; i < 2; i++) {
        D[i] = malloc(3 * sizeof(int));
    }
    D[0][0] = 0;D[0][1] = 1;D[0][2] = '-';
    D[1][0] = 1;D[1][1] = 0;D[1][2] = '|';
    
    int (^dfs2)(int, int);
    
    __block int (^dfs)(int,int) = dfs2 = ^int(int x, int y) {
       // printf("[x=%d,y=%d],", x,y);
        if(x == h){
            for(int i=0;i<h;i++) puts(tatami[i]);
            puts("");
            return 1;
        }
        if(y == v)return dfs(x+1,0);
        if(tatami[x][y]) return dfs(x,y+1);
        int l=0,r=0;
        for(int k=0;k<2;k++) if(x+D[k][0]<h && y+D[k][1]<v && !tatami[x+D[k][0]][y+D[k][1]]) {
            tatami[x][y] = tatami[x+D[k][0]][y+D[k][1]] = D[k][2];
            for(l=0;l<4;l++) corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)]++;
            for(l=0;l<4;l++) if(corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)]>3) break;
            if(l==4) r+=dfs(x,y+1);
            for(l=0;l<4;l++) corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)]--;
            tatami[x][y] = tatami[x+D[k][0]][y+D[k][1]] = '\0';
        }
        return r;
    };
//    return dfs(0, 0);
    int r = dfs(0, 0);
    for(int i = 0; i < L; i++) {free(tatami[i]);free(corner[i]); tatami[i] = nil; corner[i] = nil; }
    free(tatami); free(corner);
    for(int i = 0; i < 2; i++) {free(D[i]); D[i] = nil;}
    D = nil;
    
    return r;
}

    //Q33-1
-(int)calculateUtacartaWords {
    NSMutableArray *colA = [NSMutableArray array];
    NSMutableArray *colB = [NSMutableArray array];
    NSString* fname = [[NSBundle mainBundle] pathForResource: @"q33" ofType: @"csv"];
    NSString* fileContents = [NSString stringWithContentsOfFile:fname encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataRows = [fileContents componentsSeparatedByString:@"\n"];
    
    NSString* (^trim_str)(NSString*) = ^NSString*(NSString* inStr) {
        NSString *str = [inStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        return str;
    };

    [dataRows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            NSArray* columns = [(NSString*)obj componentsSeparatedByString:@","];
            if (columns && columns.count > 1) {
                [colA addObject:trim_str(columns[0])];
                [colB addObject:trim_str(columns[1])];
            }
        }
    }];
    
    int retVal = 0;
    int (^calc_words)(NSArray*) = ^int(NSArray* inArr) {
        int cnt = 0;
        NSInteger ub = inArr.count;
        
        for (int i = 0; i < ub; i++) {
            NSString* str = inArr[i];
            for (int j = 0; j < str.length; j++) {
                BOOL uniqFlg = YES;
                NSString* strPart = [str substringWithRange:NSMakeRange(0, j + 1)];
                
                for (int k = 0; k < ub; k++) {
                    if (k == i) continue;
                    if ([inArr[k] hasPrefix:strPart]) {
                        uniqFlg = NO;
                        break;
                    }
                }
                if (uniqFlg) {
                    puts([strPart UTF8String]);
                    cnt += j + 1;
                    break;
                }
            }
        }
        return cnt;
    };
    retVal = calc_words(colA);
    retVal += calc_words(colB);
    return retVal;
}

//Q34-1
-(NSInteger)calculeteChessRange {
    NSInteger retCnt = 0;
    //init the chess board state.
    NSMutableArray *cb = [NSMutableArray array];
    for (int n = 0; n < 11; n++) {
        NSMutableArray *item = [NSMutableArray array];
        for (int m = 0; m < 11; m++) {
            if (n == 0 || n == 10 || m == 0 || m == 10) {
                [item addObject: @(YES)];
            } else {
                [item addObject: @(NO)];
            }
        }
        [cb addObject:item];
    }
    
    NSMutableDictionary *rangeDic = [NSMutableDictionary dictionary];
    
    void(^dfs_2)(int, int, int, int);
    __block void(^dfs)(int, int, int, int) = dfs_2 = ^void(int x, int y, int dx, int dy) {
//        printf("(%d, %d, %d, %d); ", x, y, dx, dy);
        if ([cb[x][y] boolValue]) {
            return;
        }
        NSString *key = [NSString stringWithFormat:@"(%d,%d)", x, y];
        rangeDic[key] = key;
        dfs(x + dx, y + dy, dx, dy);
    };
    
    for (int ax = 1; ax < 10; ax ++) {
        for (int ay = 1; ay < 10; ay ++) {
            for (int bx = 1; bx < 10; bx ++) {
                for (int by = 1; by < 10; by ++) {
                    if (ax == bx && ay == by) {
                        continue;
                    }
                    [rangeDic removeAllObjects];
                    cb[ax][ay] = cb[bx][by] = @(YES);
                    for (NSArray *d in @[@[@(-1), @(0)], @[@(1), @(0)], @[@(0), @(-1)], @[@(0), @(1)]]) {
                        dfs(ax + [d[0] intValue], ay + [d[1] intValue], [d[0] intValue], [d[1] intValue]);
                    };
                    for (NSArray *d in @[@[@(-1), @(-1)], @[@(-1), @(1)], @[@(1), @(-1)], @[@(1), @(1)]]) {
                        dfs(bx + [d[0] intValue], by + [d[1] intValue], [d[0] intValue], [d[1] intValue]);
                    };
                    cb[ax][ay] = cb[bx][by] = @(NO);
                    retCnt += rangeDic.count;
                }
            }
        }
    }
    
    return retCnt;
}

-(BigInteger*)calculateEncounterPatterns:(int)limit {
    BigInteger *retVal;
    
    BigInteger* (^calc_route)(int, int, int, int, int);
    __block BigInteger* (^calc_route_proc)(int, int, int, int, int) = calc_route = ^BigInteger*(int x1, int y1, int x2, int y2, int happened) {
        BigInteger *cnt = [BigInteger createFromInt:0];
        int happened_ = happened;
        if (x1 <= limit && y1 <= limit && x2 >= 0 && y2 >= 0) {
            if (x1 == limit && y1 == limit && happened >= 2)
                cnt = [cnt add:[BigInteger createFromInt:1]];
            if (x1 == x2)
                happened_ += 1;
            if (y1 == y2)
                happened_ += 1;
            cnt = [cnt add:calc_route_proc(x1 + 1, y1, x2 - 1, y2, happened_)];
            cnt = [cnt add:calc_route_proc(x1 + 1, y1, x2, y2 - 1, happened_)];
            cnt = [cnt add:calc_route_proc(x1, y1 + 1, x2, y2 - 1, happened_)];
            cnt = [cnt add:calc_route_proc(x1, y1 + 1, x2 - 1, y2, happened_)];
        }
        return cnt;
    };
    retVal = calc_route(0, 0, limit, limit, 0);
                                                                                           
    return retVal;
}

//Q36-1
-(NSArray*)findCircularSevenZero:(int)limit {
    NSMutableArray *nArr = [NSMutableArray array];
    for (int i = 1; i <= limit; i++) {
        if (i % 2 > 0 ) {
            if (i % 5 == 0) {continue;}
            [nArr addObject:@(i)];
        }
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger k = 1;  nArr.count > 0 && k <= 1000000; k++) {
        BigInteger* c = [BigInteger createFromString:[[BigInteger createFromLong:k] toStringWithRadix:2] andRadix:10];
        c = [c multiply:[BigInteger createFromInt:7]];
        NSString* s = [c toStringWithRadix:10];
        for (int i = 0; i < nArr.count; i++) {
            BigInteger *a = [BigInteger createFromLong:[nArr[i] integerValue]];
            if ([[c mod:a] intValue] == 0) {
                if (s == [s reverse]) {
                    [arr addObject:@[a, [c divide:a], c]];
                    [nArr removeObjectAtIndex:i];
                }
            }
        }
    }
    
    //sort
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        BigInteger *bi1 = (BigInteger*)((NSArray*)obj1)[0];
        BigInteger *bi2 = (BigInteger*)((NSArray*)obj2)[0];
        if ([bi1 lessThanOrEqualTo:bi2]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    //prepare for returning result
    NSMutableArray *retVal = [NSMutableArray array];
    for (NSArray* obj in arr) {
        [retVal addObject:[NSString stringWithFormat:@"%@ x %@ = %@",
                           [(BigInteger*)((NSArray*)obj)[0] toStringWithRadix:10],
                           [(BigInteger*)((NSArray*)obj)[1] toStringWithRadix:10],
                           [(BigInteger*)((NSArray*)obj)[2] toStringWithRadix:10]
                           ]];
    }
    return retVal;
}

//Q37-1
-(NSArray*)findDicePatterns:(int)limit {
    NSString* (^conv_val)(NSString*) = ^NSString*(NSString* str) {
        NSString* retStr = @"";
        for (int i= 0; i < str.length; i++ ) {
            retStr = [NSString stringWithFormat:@"%@%d", retStr, '7'-[str characterAtIndex:i]];
        }
        return retStr;
    };
    NSString* (^next_dice)(NSString*) = ^NSString*(NSString* inDice) {
        NSInteger n = (char)[inDice characterAtIndex:0] - '0';
        NSString * r = conv_val([inDice substringToIndex:n]);
        return [NSString stringWithFormat:@"%@%@", [inDice substringFromIndex: n], r];
    };
    NSMutableArray *retArr = [NSMutableArray array];
    
    NSInteger num = pow(limit, limit);
    for (int i = 0; i < num; i ++) {
        NSString* dc = [NSString stringWithFormat:@"%ld", [[[NSString stringWithFormat:@"%d", i] convDecToOtherbase:6] integerValue] + 111111];
        NSMutableDictionary *chk = [NSMutableDictionary dictionary];
        int j = 0;
        
        //look for next dice
        while (!chk[dc]) {
            [chk setObject:@(j) forKey:dc];
            dc = next_dice(dc);
            j += 1;
        }
        if ([chk[dc] intValue] > 0) {
            [retArr addObject:dc];
        }
    }
    [retArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [(NSString*)obj1 compare:(NSString*)obj2];
    }];

    return retArr;
}

//Q37-2
-(NSArray*)findDicePatterns02:(int)limit {
    NSInteger (^next_dice)(NSInteger) = ^NSInteger(NSInteger inDice) {
        NSInteger t = inDice / pow(limit, 5);
        NSInteger l = inDice / pow(limit, 5 - t);
        NSInteger r = inDice % (NSInteger)pow(limit, 5 - t);
        return (r + 1) * pow(6, t + 1) - (l + 1);
    };
    NSMutableArray *retArr = [NSMutableArray array];
    
    NSInteger num = pow(limit, limit);
    NSMutableArray *allPatts = [NSMutableArray array];
    for (int i = 0; i < num; i ++) {
        [allPatts addObject:@(0)];
    }
    
    for (int i = 0; i < num; i ++) {
        if ([allPatts[i] intValue] == 0) {
            NSMutableArray *chkArr = [NSMutableArray array];
            
            //look for next dice
            NSInteger d = i;
            while ([allPatts[d] intValue] == 0 && ![chkArr containsObject:@(d)]) {
                [chkArr addObject:@(d)];
                d = next_dice(d);
            }
            
            NSInteger idx = [chkArr indexOfObject:@(d)];
            if (idx != NSNotFound) {
                for (NSInteger j = 0; j < chkArr.count; j ++) {
                    if (j < idx) {
                        [allPatts setObject:@(1) atIndexedSubscript:[chkArr[j] intValue]];
                        [retArr addObject:chkArr[j]];
                    }else{
                        [allPatts setObject:@(2) atIndexedSubscript:[chkArr[j] intValue]];
                    }
                }
            } else {
                for (NSInteger j = 0; j < chkArr.count; j ++) {
                    [allPatts setObject:@(1) atIndexedSubscript:[chkArr[j] intValue]];
                    [retArr addObject:chkArr[j]];
                }
            }
        }
    }
    [retArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [(NSNumber*)obj1 compare:(NSNumber*)obj2];
    }];
    for (int i = 0; i < retArr.count; i ++) {
        [retArr setObject:@([[[NSString stringWithFormat:@"%@", retArr[i]] convDecToOtherbase:6] integerValue] + 111111) atIndexedSubscript:i];
    }
    return retArr;
}

//Q38-1
-(NSArray*)findNumberSwitchPatterns {
    NSArray* bits = @[@(0b01111110), @(0b0110000), @(0b1101101), @(0b1111001), @(0b0110011),
                      @(0b1011011), @(0b1011111), @(0b1110000), @(0b1111111), @(0b1111011)];
    //adjust reserved patterns
    int (^num_switch_cnt)(int, int) = ^int(int num1, int num2) {
        int cnt = 0;
        if (num1 < 0 || num1 > 9 || num2 < 0 || num2 > 9) {
            return cnt;
        }
        int num = [bits[num1] intValue] ^ [bits[num2] intValue];
        while (num > 0) {
            cnt += (num % 2) == 1 ? 1 : 0;
            num = num / 2;
        }
        return cnt;
    };

    MStack* stateLst = [[MStack alloc] initWithArray:@[]];
    
    __block Q38State_t wkState;
    wkState.pattern = @[];
    wkState.times = 0;
    
    [stateLst pushObject:[NSValue valueWithState38:wkState]];
    int minCnt = 9999;
    
    NSMutableArray *retArr = [NSMutableArray array];
    while ([stateLst count]) {
        Q38State_t poppedState = [[stateLst popObject] state38Value];
        if (minCnt < poppedState.times ) {continue;}
        
        //judge the condition if it meets
        if (poppedState.pattern.count == 10) {
            if (minCnt > poppedState.times) {
                minCnt = poppedState.times;
            }
            NSString *str = @""; //[NSString stringWithFormat:@"Pattenrs [%d] : ", minCnt];
            for (int i = 0; i < poppedState.pattern.count; i ++) {
                str = [NSString stringWithFormat:@"%@%d", str, [poppedState.pattern[i] intValue]];
                if (i < poppedState.pattern.count - 1) {
                    str = [NSString stringWithFormat:@"%@-[%d]->", str, num_switch_cnt([poppedState.pattern[i] intValue], [poppedState.pattern[i+1] intValue])];
                }
            }
            [retArr addObject:@{@"times":@(minCnt), @"path": str}];
            continue;
        }
        
        for (int i = 0; i < 10; i++) {
            if ([poppedState.pattern containsObject:@(i)]) continue;

            //exclude pattern when i = 0, 5
            if (i == 0 && poppedState.pattern.count > 5) continue;
            NSMutableArray *ptn = [NSMutableArray arrayWithArray:poppedState.pattern];
            [ptn addObject:@(i)];
            wkState.pattern = [NSArray arrayWithArray:ptn];

            wkState.times = poppedState.times;
            if (poppedState.pattern.count > 0) {
                wkState.times += +num_switch_cnt([[poppedState.pattern lastObject] intValue], i);
            }

            [stateLst pushObject:[NSValue valueWithState38:wkState]];
        }
    }
    return retArr;
}
@end

