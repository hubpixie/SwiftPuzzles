//
//  ButtonActions.swift
//  SwiftPuzzles_ios
//
//  Created by venus.janne on 2017/10/29.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

class ButtonActions {
    static let sharedInstance : ButtonActions = {
        let instance = ButtonActions()
        return instance
    }()
    
    func performAtIndex(buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            self.tapQ01Action()
        case 1:
            self.tapQ02Action()
        case 2:
            self.tapQ03Action()
        case 3:
            self.tapQ04Action()
        case 4:
            self.tapQ05Action()
        case 5:
            self.tapQ06Action()
        case 6:
            self.tapQ07Action()
        case 7:
            self.tapQ08Action()
        case 8:
            self.tapQ09CountAction()
        case 9:
            self.tapQ10Action()
        case 10:
            self.tapQ11x1Action()
        case 11:
            self.tapQ11x2Action()
        case 12:
            self.tapQ12Action()
        case 13:
            self.tapQ13Action()
        case 14:
            self.tapQ14Action()
        case 15:
            self.tapQ15x1Action()
        case 16:
            self.tapQ15x2Action()
        case 17:
            self.tapQ16Action()
        case 18:
            self.tapQ17Action()
        case 19:
            self.tapQ18x1Action()
        case 20:
            self.tapQ18x2Action()
        case 21:
            self.tapQ19Action()
        case 22:
            self.tapQ20Action()
        case 23:
            self.tapQ21x1Action()
        case 24:
            self.tapQ21x2Action()
        case 25:
            self.tapQ22Action()
        case 26:
            self.tapQ23x1Action()
        case 27:
            self.tapQ24x1Action()
        case 28:
            self.tapQ24x2Action()
        case 29:
            self.tapQ24x3Action()
        case 30:
            self.tapQ25x1Action()
        case 31:
            self.tapQ25x2Action()
        case 32:
            self.tapQ26x1Action()
        case 33:
            self.tapQ26x2Action()
        case 34:
            self.tapQ27x1Action()
        case 35:
            self.tapQ28x1Action()
        case 36:
            self.tapQ29x1Action()
        case 37:
            self.tapQ30x1Action()
        case 38:
            self.tapQ31x1Action()
        case 39:
            self.tapQ31x2Action()
        case 40:
            self.tapQ32x1Action()
        case 41:
            self.tapQ32x2Action()
        case 42:
            self.tapQ32x3Action()
        case 43:
            self.tapQ32x4Action()
        case 44:
            self.tapQ33x1Action()
        case 45:
            self.tapQ33x2Action()
        case 46:
            self.tapQ34x1Action()
        case 47:
            self.tapQ34x2Action()
        case 48:
            self.tapQ35x1Action()
        case 49:
            self.tapQ35x2Action()
        case 50:
            self.tapQ35x3Action()
        case 51:
            self.tapQ35x4Action()
        case 52:
            self.tapQ36x1Action()
        case 53:
            self.tapQ36x2Action()
        case 54:
            self.tapQ37x1Action()
        case 55:
            self.tapQ37x2Action()
        case 56:
            self.tapQ37x3Action()
        case 57:
            self.tapQ37x4Action()
        case 58:
            self.tapQ37x5Action()
        case 59:
            self.tapQ37x6Action()
        case 60:
            self.tapQ38x1Action()
        case 61:
            self.tapQ38x2Action()
        case 62:
            self.tapQ38x3Action()
        case 63:
            self.tapQ38x4Action()
        default:
            break
        }
    }
    func tapQ01Action() {
        print("Q01: calculateMinCircularNumber(start: 11) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.calculateMinCircularNumber(start: 11)
        print("calculateMinCircularNumber=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ02Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q02: findCircularNumberWithMixedOperators(start: 1000, end: 10000) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findCircularNumberWithMixedOperators(start: 1000, end: 10000)
                print("findCircularNumberWithMixedOperators=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ03Action() {
        print("Q03: findBackCards(maxNumber: 200) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.findBackCards(maxNumber: 200)
        print("findBackCards=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ04Action() {
        
        // - First thinking
        // Bar length: 20cm, cutters: 3
        print("Q04: calculateBarCuttingCount(barLength: 20, cutters: 3, currentBars: 1) ->")
        var timeA = Date()
        var ret = SPuzzles.sharedInstance.calculateBarCuttingCount(barLength: 20, cutters: 3, currentBars: 1)
        print("calculateBarCuttingCount=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
        
        // Bar length: 150cm, cutters: 8
        print("Q04: calculateBarCuttingCount(barLength: 100, cutters: 5, currentBars: 1) ->")
        timeA = Date()
        ret = SPuzzles.sharedInstance.calculateBarCuttingCount(barLength: 100, cutters: 5, currentBars: 1)
        print("calculateBarCuttingCount=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
        
        // - second thinking
        // Bar length: 20cm, cutters: 3
        print("Q04: calculateBarCuttingCount(barLength: 20, cutters: 3) ->")
        timeA = Date()
        ret = SPuzzles.sharedInstance.calculateBarCuttingCount(barLength: 20, cutters: 3)
        print("calculateBarCuttingCount=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
        
        // Bar length: 150cm, cutters: 8
        print("Q04: calculateBarCuttingCount(barLength: 100, cutters: 5) ->")
        timeA = Date()
        ret = SPuzzles.sharedInstance.calculateBarCuttingCount(barLength: 100, cutters: 5)
        print("calculateBarCuttingCount=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ05Action() {
        print("Q05: changeMoney(total: 50, coins: [500, 100, 50, 10], maxCoinCount: 15) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.changeMoney(total: 50, coins: [500, 100, 50, 10], maxCoinCount: 15)
        print("changeMoney=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ06Action() {
        print("Q06: find3x1Numbers(nValue: i) ->")
        let timeA = Date()
        var retNumbers: [Int] = []
        for i in stride(from: 2, through: 10000, by: 2) {
            let found = SPuzzles.sharedInstance.check3x1Numbers(nValue: i)
            if found {
                retNumbers.append(i)
            }
        }
        print("find3x1Numbers=\(retNumbers)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ07Action() {
        print("Q07: findCircularDates(fromDate: date1!, toDate: date2!) ->")
        let timeA = Date()
        let date1 = Calendar.current.date(from: DateComponents(year: 1960, month:1, day: 1))
        let date2 = Calendar.current.date(from: DateComponents(year: 2020, month:12, day: 31))
        let ret = SPuzzles.sharedInstance.findCircularDates(fromDate: date1!, toDate: date2!)
        print("findCircularDates=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ08Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q08: calculateRobotMoving(levelLimit: 12) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateRobotMoving(levelLimit: 12)
                print("calculateRobotMoving=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
        
    }
    
    func tapQ09CountAction() {
        print("Q09: calculateShortestPathCount(groupA: 30, groupB: 20) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.calculateShortestPathCount(groupA: 30, groupB: 20)
        print("calculateShortestPathCount=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    
    func tapQ10Action() {
        print("Q10: findRouletteSumMaxPattern() ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.findRouletteSumMaxPattern()
        print("findRouletteSumMaxPattern=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ11x1Action() {
        //NSDecimal
        print("Q11: findFibonacciDevidedNumbers(limitCount: 10) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.findFibonacciDevidedNumbers(limitCount: 10)
        for (idx, v)  in ret.enumerated() {
            print("findFibonacciDevidedNumbers:[\(idx)] = \(v)")
        }
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ11x2Action() {
        //BigInt
        print("Q11: findFibonacciDevidedNumbers2(limitCount: 50) ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.findFibonacciDevidedNumbers2(limitCount: 50)
        for (idx, v)  in ret.enumerated() {
            print("findFibonacciDevidedNumbers2:[\(idx)] = \(v)")
        }
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ12Action() {
        print("Q12: findSqrtMinNumbers() ->")
        let timeA = Date()
        let ret = SPuzzles.sharedInstance.findSqrtMinNumbers()
        print("findSqrtMinNumbers=\(ret)")
        print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
    }
    
    func tapQ13Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q13: findCryptarithmetic(formula: 'READ+WRITE+TALK==SKILL') ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findCryptarithmetic(formula: "READ+WRITE+TALK==SKILL")
                print("findCryptarithmetic=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ14Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q14: findCountryNameChains() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findCountryNameChains()
                print("findCountryNameChains=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ15x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q15: findSameSteps1(limit: 20) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findSameSteps1(limit: 20)
                print("findSameSteps1=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ15x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q15: findSameSteps2(limit: 10) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findSameSteps2(limit: 10)
                print("findSameSteps2=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ16Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q16: findTwoRectEqualSquare(lineLength: 500) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findTwoRectEqualSquare(lineLength: 500)
                print("findTwoRectEqualSquare=\(ret.count),\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ17Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q17: calcRowingPatterns(limit: 30) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.calcRowingPatterns(limit: 30)
                print("calcRowingPatterns=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q17: calcRowingPatterns(limit: 10000) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.calcRowingPatterns(limit: 10000)
                print("calcRowingPatterns=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ18x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q18: findCakeCuttingBlocks01() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findCakeCuttingBlocks01()
                print("findCakeCuttingBlocks01,size=\(ret, ret.count)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ18x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q18: findCakeCuttingBlocks02() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findCakeCuttingBlocks02()
                print("findCakeCuttingBlocks02,size=\(ret, ret.count)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ19Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q19: findFriendNumbers(limit: 10) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findFriendNumbers(limit: 10)
                print("findFriendNumbers=\(ret), max=\(ret.max()!)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ20Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q20: calculateMagicSquares() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateMagicSquares()
                print("calculateMagicSquares=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ21x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q21: findZeroPosition01(zeroIndex: 10_000) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findZeroPosition01(zeroIndex: 10_000)
                print("findZeroPosition01=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ21x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q22: findZeroPosition02(zeroIndex: 10_000) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findZeroPosition02(zeroIndex: 10_000)
                print("findZeroPosition02=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    
    func tapQ22Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q22: calculatePairingPatterns(limit: 7) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculatePairingPatterns(limit: 7)
                print("calculatePairingPatterns=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ23x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q23: calculateBlackjackPatterns(coins: 10, level: 24) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateBlackjackPatterns(coins: 10, level: 24)
                print("calculateBlackjackPatterns=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ24x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q24: calculateStrikePatterns01() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateStrikePatterns01()
                print("calculateStrikePatterns01=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ24x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q24: calculateStrikePatterns02() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateStrikePatterns02()
                print("calculateStrikePatterns02=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ24x3Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q24: calculateStrikePatterns03() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateStrikePatterns03()
                print("calculateStrikePatterns03=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ25x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q25: calculateLacingPatterns01(holeLimit: 6) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.calculateLacingPatterns01(holeLimit: 6)
                print("calculateLacingPatterns01=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q25: calculateLacingPatterns01(holeLimit: 8) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.calculateLacingPatterns01(holeLimit: 8)
                print("calculateLacingPatterns01=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ25x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q25: calculateLacingPatterns02(holeLimit: 6) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.calculateLacingPatterns02(holeLimit: 6)
                print("calculateLacingPatterns02=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q25: calculateLacingPatterns02(holeLimit: 8) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.calculateLacingPatterns02(holeLimit: 8)
                print("calculateLacingPatterns02=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }
        }
    }
    
    func tapQ26x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q26: calculateParkingRoutes01(limitX: 10, limitY: 10) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateParkingRoutes01(limitX: 10, limitY: 10)
                print("calculateParkingRoutes01=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ26x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q26: calculateParkingRoutes02(limitX: 10, limitY: 10) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateParkingRoutes02(limitX: 10, limitY: 10)
                print("calculateParkingRoutes02=\(ret)")
                print("time elapsed:\(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ27x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q27: calculateDrivingRoutes01(6, y: 4) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculateDrivingRoutes01(6, y: 4)
                print("calculateDrivingRoutes01=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ28x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q28: calculateMaxClubArea(personLimit: 150) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateMaxClubArea(personLimit: 150)
                print("calculateMaxClubArea=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ29x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q29: calculateGoldenRatio01(1.61800339887, limit: 14) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculateGoldenRatio01(1.61800339887, limit: 14)
                print("calculateGoldenRatio01=\(String(format:" ret = %.10f", ret))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ30x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q30: calculateTablePlugs01(limit: 300) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateTablePlugs01(limit: 300)
                print("calculateTablePlugs01=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ31x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q31: calculateShortestPath01(limitX: 60, limitY:60) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateShortestPath01(limitX: 60, limitY:60)
                print("calculateShortestPath01=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ31x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q31: calculateShortestPath02(7, 7) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculateShortestPath02(7, 7);
                print("calculateShortestPath02=\((ret?.toString(withRadix: 10))!)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ32x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q32: calculateTatamiPatterns(4, 7) ->")
                var timeA = Date()
                var ret = MPuzzles.sharedInstance().calculateTatamiPatterns(4, 7);
                print("calculateTatamiPatterns=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q32: calculateTatamiPatterns(5, 6) ->")
                timeA = Date()
                ret = MPuzzles.sharedInstance().calculateTatamiPatterns(5, 6);
                print("calculateTatamiPatterns=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ32x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q32: calculateTatamiPatternsX2(4, 7) ->")
                var timeA = Date()
                var ret = MPuzzles.sharedInstance().calculateTatamiPatternsX2(4, 7);
                print("calculateTatamiPatternsX2=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q32: calculateTatamiPatternsX2(5, 6) ->")
                timeA = Date()
                ret = MPuzzles.sharedInstance().calculateTatamiPatternsX2(5, 6);
                print("calculateTatamiPatternsX2=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    
    func tapQ32x3Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q32: calculateTatamiPatternsX3(4, 7) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.calculateTatamiPatterns03(h: 4, v:7);
                print("calculateTatamiPatternsX3=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q32: calculateTatamiPatternsX3(5, 6) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.calculateTatamiPatterns03(h: 5, v: 6);
                print("calculateTatamiPatternsX3=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ32x4Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q32: calculateTatamiPatternsX4(4, 7) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.calculateTatamiPatterns04(h: 4, v:7);
                print("calculateTatamiPatternsX4=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q32: calculateTatamiPatternsX4(5, 6) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.calculateTatamiPatterns04(h: 5, v: 6);
                print("calculateTatamiPatternsX4=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ33x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q33: calculateUtacartaWords() ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculateUtacartaWords();
                print("calculateUtacartaWords=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ33x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q33: calculateUtacartaWords() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateUtacartaWords02();
                print("calculateUtacartaWordsX2=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ34x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q34: calculeteChessRange() ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculeteChessRange();
                print("calculeteChessRange=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    func tapQ34x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q34: calculateChessRangeX2() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateChessRange02();
                print("calculateChessRangeX2=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
            }}
    }
    
    func tapQ35x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q35: calculateEncounterPatterns(6) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().calculateEncounterPatterns(6);
                print("calculateEncounterPatterns=\((ret?.toString(withRadix: 10))!)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ35x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q35: calculateEncounterPatternsX2(limit: 8) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateEncounterPatterns02(limit: 6);
                print("calculateEncounterPatternsX2=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ35x3Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q35: calculateEncounterPatternsX3(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateEncounterPatterns04(limit: 6);
                print("calculateEncounterPatternsX3=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ35x4Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q35: calculateEncounterPatternsX4(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.calculateEncounterPatterns04(limit: 6);
                print("calculateEncounterPatternsX4=\(ret)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ36x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q36: findCircularSevenZero(limit: 50) ->")
                var timeA = Date()
                var ret = MPuzzles.sharedInstance().findCircularSevenZero(50);
                print("findCircularSevenZero=\(String(describing: ret)), count = \(String(describing: ret?.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q36: findCircularSevenZero(limit: 100) ->")
                timeA = Date()
                ret = MPuzzles.sharedInstance().findCircularSevenZero(200);
                print("findCircularSevenZero=\(String(describing: ret)), count = \(String(describing: ret?.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ36x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q36: findCircularSevenZero02(limit: 50) ->")
                var timeA = Date()
                var ret = SPuzzles.sharedInstance.findCircularSevenZero02(limit: 50);
                print("findCircularSevenZero=\(String(describing: ret)), count = \(ret.count)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
                
                print("Q36: findCircularSevenZero02(limit: 200) ->")
                timeA = Date()
                ret = SPuzzles.sharedInstance.findCircularSevenZero02(limit: 200);
                print("findCircularSevenZero=\(String(describing: ret)), count = \(ret.count)")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns(limit: 6) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().findDicePatterns(_: 6);
                print("findDicePatterns=\(String(describing: ret?.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns02(limit: 6) ->")
                let timeA = Date()
                let ret = MPuzzles.sharedInstance().findDicePatterns02(_: 6);
                print("findDicePatterns02=\(String(describing: ret?.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x3Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns03(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findDicePatterns03(limit: 6)
                print("findDicePatterns03=\(String(ret.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x4Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns04(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findDicePatterns04(limit: 6)
                print("findDicePatterns04=\(String(ret.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x5Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns05(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findDicePatterns05(limit: 6)
                print("findDicePatterns05=\(String(ret.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ37x6Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q37: findDicePatterns06(limit: 6) ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findDicePatterns05(limit: 6)
                print("findDicePatterns06=\(String(ret.count))")
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ38x1Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q38: findNumberSwitchPatterns() ->")
                let timeA = Date()
                if let ret = MPuzzles.sharedInstance().findNumberSwitchPatterns() {
                    for i in 0..<(ret.count) {
                        print(" \(String(describing: ret[i]))")
                    }
                    let minVal = ret.last as! NSDictionary
                    print("min pattern: \(String(describing: minVal["times"]!))")
                    
                }
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ38x2Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q38: findNumberSwitchPatterns() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findNumberSwitchPatterns02()
                for i in 0..<(ret.count) {
                    print(" \(ret[i])")
                }
                let minVal = ret.last
                print("min pattern: \(minVal!["times"]!)")
                
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ38x3Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q38: findNumberSwitchPatterns() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findNumberSwitchPatterns03()
                for i in 0..<(ret.count) {
                    print(" \(ret[i])")
                }
                let minVal = ret.last
                print("min pattern: \(minVal!["times"]!)")
                
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }
    
    func tapQ38x4Action() {
        DispatchQueue.global(qos: .background).async {
            // Background Thread Or Service call Or DB fetch etc
            DispatchQueue.main.async {
                print("Q38: findNumberSwitchPatterns() ->")
                let timeA = Date()
                let ret = SPuzzles.sharedInstance.findNumberSwitchPatterns04()
                for i in 0..<(ret.count) {
                    print(" \(ret[i])")
                }
                let minVal = ret.last
                print("min pattern: \(minVal!["times"]!)")
                
                print("time elapsed - \(DateUtil().elapsedTimeString(startTime: timeA, endTime: Date()))")
            }}
    }

}
