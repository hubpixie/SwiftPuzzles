//
//  SPuzzles.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/06.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

fileprivate struct Q08RobotStatusDef
{
    var level: Int = 0
    var currX: Int = 0
    var currY: Int = 0
    var visitedSet: [(Int, Int)] = [(0, 0)]
}
fileprivate struct Q32_State_Struct {
    var pattern: [String]!
    var xx: Int = 0
    var yy: Int = 0
    var tatami_cnt: Int = 0
}
fileprivate typealias Q32State_t = Q32_State_Struct

fileprivate struct Q35_State_Struct {
    var x1: Int = 0
    var y1: Int = 0
    var x2: Int = 0
    var y2: Int = 0
    var metCount: Int = 0
}
fileprivate typealias Q35State_t = Q35_State_Struct

fileprivate struct Q36_State2_Struct {
    var depth: BigInt = 0
    var targetNum: BigInt = 0
}
fileprivate typealias Q36State2_t = Q36_State2_Struct

fileprivate struct Q37_State5_Struct {
    var depth: Int = 0
    var numArr: [Int] = []
}
fileprivate typealias Q37State5_t = Q37_State5_Struct

class SPuzzles {
    static let sharedInstance : SPuzzles = {
        let instance = SPuzzles()
        return instance
    }()
    
    //power for int
    func pow_num (num1: Int, num2: Int) -> Int {
        var retv: Int = 1
        if num2 <= 0 {return retv}
        for _ in 1...num2 {
            retv *= num1
        }
        return retv
    }

    /*
     * Calculate a min circular number
     *
     * Parameter - start: value of starting
     * Returns   - a min circular number
     */
    func calculateMinCircularNumber(start: Int) -> Int {
        var num = start
        var s: String = ""
        var s1: String = ""
        var s2: String = ""
        while true {
            s = String(num)
            s1 = String(num, radix:2)
            s2 = String(num, radix:8)
            if s == String(s.reversed())
                && s1 == String(s1.reversed())
                && s2 == String(s2.reversed()) {
                break
            }
            num += 2
        }
        return num
    }
    
    /*
     * Find circular numbers which is made up of some operators.
     * Parameter - start: value of starting
     * Parameter - end: value of finishing
     * Returns   - circular numbers
     * Remarks
     *  let stringWithMathematicalOperation: String = "5*5" // Example
     *  let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
     *  let result = exp.expressionValue(with: nil, context: nil)
     */
    
    func findCircularNumberWithMixedOperators(start: Int, end: Int) -> [Int] {
        var num: [Int] = []
        let operators: [String] = ["+", "-", "*", "/", ""]
        var s1: String = ""
        var val: String = ""
        var eval: Int!
        var exp: NSExpression!
        var c: [Character] = []
        
        for i in start ..< end {
            s1 = String(i)
            c = Array(s1)
            for op1 in operators {
                for op2 in operators {
                    for op3 in operators {
                        val = "\(c[3])\(op1)\(c[2])\(op2)\(c[1])\(op3)\(c[0])"
                        if val.count > 4 {
                            exp = NSExpression(format: val)
                            eval = exp.expressionValue(with: nil, context: nil) as! Int
                            if i == eval {
                                //print("\(op1),\(op2),\(op3)")
                                num.append(i)
                            }
                        }
                    }
                }
            }
        }
        return num
    }
    
    /*
     * Find back cards.
     *
     * Parameter - maxNumber: max number of card
     * Returns - indexes of back card
     */
    func findBackCards(maxNumber: Int) -> [Int] {
        var maxCards: [Bool] = []
        
        for _ in 0 ..< maxNumber {
            maxCards.append(false)
        }
        var j: Int = 0
        for i in 2 ... maxNumber {
            j = i - 1
            while j < maxCards.count {
                maxCards[j] = !maxCards[j]
                j += i
            }
        }
        
        return maxCards.enumerated().filter{ $0.element == false}.map({ return $0.offset + 1})
    }
    
    /*
     * Calculate how many a bar with 2+ cm, which is cut into 1 cm.
     *
     * Parameter - barLength: a bar length (2+ cm)
     * Parameter - cutters: number of bar cutting
     * Parameter - currentBars: small bars cutting
     * Returns - bar cut count
     */
    func calculateBarCuttingCount(barLength: Int, cutters: Int, currentBars: Int) -> Int {
        if currentBars >= barLength {
            return 0
        } else if currentBars < cutters {
            return 1 + calculateBarCuttingCount(barLength: barLength, cutters: cutters, currentBars: currentBars * 2)
        } else {
            return 1 + calculateBarCuttingCount(barLength: barLength, cutters: cutters, currentBars: currentBars + cutters)
        }
    }
    
    /*
     * Calculate how many a bar with 2+ cm, which is cut into 1 cm.
     *
     * Parameter - barLength: a bar length (2+ cm)
     * Parameter - cutters: number of bar cutting
     * Returns - bar cut count
     */
    func calculateBarCuttingCount(barLength: Int, cutters: Int) -> Int {
        var retCount: Int = 0
        var currentBars: Int = 1
        
        while barLength > currentBars {
            currentBars += currentBars < cutters ? currentBars : cutters
            retCount += 1
        }
        
        return retCount
    }
    
    /*
     * Change a big money into coins.
     *
     * Parameter - total: a bar length (2+ cm)
     * Parameter - coins: coin types (i.e., 10,50,100,500)
     * Parameter - maxCoinCount: max number of coin
     * Returns - all kinds of changing patterns
     */
    func changeMoney(total: Int, coins: [Int], maxCoinCount: Int) -> Int {
        var retCount: Int = 0
        var coins2 = coins.map { return $0 }
        let coin: Int = coins2.removeLast()
        
        if coins2.count < 1 {
            if total / coin <= maxCoinCount {
                retCount += 1
            }
        } else {
            for i in 0 ... total / coin {
                retCount += changeMoney(total: total - coin * i, coins: coins2, maxCoinCount: maxCoinCount - i)
            }
        }
        
        return retCount
    }
    
    /*
     * Check a number if it is equal to itself as 3x + 1 problem.
     *
     * Parameter - nValue: give a number to check
     * Returns - true if equal to itself, false otherwise.
     */
    func check3x1Numbers(nValue: Int) -> Bool {
        var nn: Int = 3 * nValue + 1
        
        while nn != 1 {
            if nn % 2 == 0  {
                nn = nn / 2
            } else {
                nn = nn * 3 + 1
            }
            if nn == nValue {
                return true
            }
        }
        
        return false
    }
    
    /*
     * Find circular dates between startDate and endDate
     *
     * Parameter - fromDate: a date value of starting
     * Parameter - toDate: a date value of ending
     * Returns   - circular date array
     */
    func findCircularDates(fromDate: Date, toDate: Date) -> [String] {
        var retDates: [String] = []
        let calendar = Calendar.current
        var date: Date = fromDate
        var sdate: String = ""
        var sdate2: String = ""
        
        while date <= toDate {
            let comps = calendar.dateComponents([.year, .month, .day], from: date)
            sdate = String(format:"%d%02d%02d", comps.year!, comps.month!, comps.day!)
            sdate2 = String(comps.year! * 10000 + comps.month! * 100 + comps.day!, radix: 2)
            sdate2 = String(sdate2.reversed())
            sdate2 = String(format:"%ld", strtoul(sdate2, nil, 2))
            
            if sdate == sdate2 {
                retDates.append(sdate)
            }
            date = date.addingTimeInterval(TimeInterval(24 * 60 * 60))
        }
        return retDates
    }
    
    
    /*
     * Q08-1
     * Calculate a robot moving patterns
     *
     * Parameter - levelLimit: set moving times
     * Returns   - moving patterns
     */
    func calculateRobotMoving(levelLimit: Int) -> Int {
        var retCount: Int = 0
        
        var stk = SStack<Q08RobotStatusDef>()
        let statusStarting: Q08RobotStatusDef = Q08RobotStatusDef()
        stk.push(statusStarting)
        
        while stk.count > 0 {
            guard let poppedStatus = stk.pop() else {
                continue
            }
            
            //judge the status demanded.
            if (poppedStatus.level == levelLimit) {
                retCount += 1
                continue
            }
            
            let pushStatus = {(newX: Int, newY: Int) in
                //not available
                var status: Q08RobotStatusDef = Q08RobotStatusDef()
                let nextPos: (Int, Int) = (newX, newY)
                if poppedStatus.visitedSet.contains(where: { $0 == nextPos }) {
                    return
                }
                
                status.level = poppedStatus.level + 1
                status.currX = newX
                status.currY = newY
                status.visitedSet = poppedStatus.visitedSet;
                status.visitedSet.append(nextPos);
                stk.push(status);
            }
            
            pushStatus(poppedStatus.currX, poppedStatus.currY - 1)
            
            //skip
            if poppedStatus.level == 0 {
                continue
            }
            
            pushStatus(poppedStatus.currX, poppedStatus.currY + 1);
            pushStatus(poppedStatus.currX - 1, poppedStatus.currY);
            pushStatus(poppedStatus.currX + 1, poppedStatus.currY);
        }
        return retCount * 4
    }
    
    /*
     * Q09-1
     * Calculate short path routes between two groups
     *
     * Parameter - groupA: group A
     * Parameter - groupB: group B
     * Returns   - path routes
     */
    
    func calculateShortestPathCount(groupA: Int, groupB: Int) -> Int {
        let g1: Int = groupA + 1
        let g2: Int = groupB + 1
        
        var paths: [[Int]] = []
        for _ in 0 ..< g2 {
            var elm: [Int] = []
            for _ in 0 ..< g1 {
                elm.append(0)
            }
            paths.append(elm)
        }
        paths[0][0] = 1
        
        for i in 0 ..< g2 {
            for j in 0 ..< g1 {
                if i != j && g1 - j != g2 - i {
                    if j > 0 {
                        paths[i][j] += paths[i][j-1]
                    }
                    if i > 0 {
                        paths[i][j] += paths[i-1][j]
                    }
                }
            }
        }
        return paths[g2 - 2][g1 - 1] + paths[g2 - 1][g1 - 2]
    }
    
    /*
     * Q10-1
     * Find how many kinds while  the sum of euro roulette is smaller than american's
     *
     * Parameter - non
     * Returns   - max patterns
     */
    func findRouletteSumMaxPattern() -> Int {
        var retCount: Int = 0
        let euroArr: [Int] = [0,32,15,19,4,21,2,25,17,34,6,27,13,
                              36,11,30,8,23,10,5,24,16,33,1,20,14,
                              31,9,22,18,29,7,28,12,35,3,26]
        
        let amerArr: [Int] = [0,28,9,26,30,11,7,20,32,17,5,22,34,
                              15,3,24,36,13,1,0,27,10,25,29,12,8,
                              19,31,18,6,21,33,16,4,23,35,14,2]
        
        let DeriveMaxSum = {(arr: [Int], index: Int) -> Int in
            var sumValues: [Int] = []
            let ubound = arr.count - 1
            for i in 0 ... ubound {
                var tmpSum: Int = 0
                for j in i ..< i + index {
                    var currIdx: Int = j
                    if (ubound < currIdx) {
                        currIdx -= ubound + 1
                    }
                    tmpSum += arr[currIdx]
                }
                sumValues.append(tmpSum);
            }
            return sumValues.max()!;
        }
        
        for i in 2 ... 36 {
            let euroMax = DeriveMaxSum(euroArr, i);
            let amerMax = DeriveMaxSum(amerArr, i);
            if (euroMax < amerMax) {
                retCount += 1
                print("N=\(i)のとき、ヨーロピアンでの最大=\(euroMax)。アメリカンでの最大=\(amerMax)")
            }
        }
        
        return retCount
    }
    
    /*
     * Q11-1
     * Find a fibo number that is done by dividing the sums of every bits
     *
     * Parameter - limitCount: set the limit of finding
     * Returns   - found fibo numbers
     */
    func findFibonacciDevidedNumbers(limitCount: Int) -> [Int] {
        var retNumbers: [Int] = []
        var a: Int = 1
        var b: Int = 1
        var c: Int = 0
        var cnt: Int = 0
        
        while cnt < limitCount {
            c = a + b
            var sum: Int = 0
            let str: String = "\(c)"
            for e in str {
                sum += Int(String(e))!
            }
            if c % sum == 0 {
                cnt += 1
                retNumbers.append(c)
                //print("N=\(cnt), Fib = \(c)")
            }
            a = b; b = c
        }
        return retNumbers
    }
    
    /*
     * Q11-0
     * Find a fibo number that is done by dividing the sums of every bits
     *
     * Parameter - limitCount: set the limit of finding
     * Returns   - found fibo numbers
     */
    func findFibonacciDevidedNumbers00(limitCount: Int) -> [NSDecimalNumber] {
        var retNumbers: [NSDecimalNumber] = []
        var a: NSDecimalNumber = NSDecimalNumber(string: "1")
        var b: NSDecimalNumber = NSDecimalNumber(string: "1")
        var c: NSDecimalNumber = NSDecimalNumber(string: "0")
        var cnt: Int = 0
        
        while cnt < limitCount {
            c = a.adding(b)
            var sum: Int = 0
            let str: String = "\(c)"
            for e in str {
                sum += Int(String(e))!
            }
            let sumD = sum as! NSDecimalNumber
            let d = sumD.dividing(by: c)
            if c.subtracting(d.multiplying(by: sumD)) == 0 {
                cnt += 1
                retNumbers.append(c)
                print("N=\(cnt), Fib = \(c)")
            }
            a = b; b = c
        }
        return retNumbers
    }
    
    /*
     * Q11-2
     * Find a fibo number that is done by dividing the sums of every bits
     *
     * Parameter - limitCount: set the limit of finding
     * Returns   - found fibo numbers
     */
    func findFibonacciDevidedNumbers2(limitCount: Int) -> [BigInt] {
        var retNumbers: [BigInt] = []
        var a: BigInt = BigInt("1")
        var b: BigInt = BigInt("1")
        var c: BigInt = BigInt("0")
        var cnt: Int = 0
        
        while cnt < limitCount {
            c = a + b
            var sum: Int = 0
            let str: String = "\(c)"
            for e in str {
                sum += Int(String(e))!
            }
            if c % sum == 0 {
                cnt += 1
                retNumbers.append(c)
                print("N=\(cnt), Fib = \(c)")
            }
            a = b; b = c
        }
        return retNumbers
    }

    /*
     * Q12-1
     * Find min numbers from sqrt of number values
     *
     * Parameter - none
     * Returns   - found min numbers
     */
    func findSqrtMinNumbers() -> [(Int, String)] {
        
        var retNumbers: [(Int, String)] = []
        var idx: Int = 1
        var str1: String = ""
        var str2: String = ""
        var arr: [Character] = []
        
        //for Integer
        while true {
            str1 = String(format: "%10.10f", sqrt(Double(idx)))
            let sIdx = str1.index(str1.startIndex, offsetBy: 11)
            str1 = String(str1[..<sIdx])
            str2 = str1.replacingOccurrences(of: ".", with: "")
            arr = Array(Set(Array(str2)))
            if arr.count == 10 {
                retNumbers.append((idx, str1))
                break
            }
            idx += 1
        }
        
        //only fractional part
        idx = 1
        while true {
            str1 = String(format: "%10.10f", sqrt(Double(idx)))
            str2 = str1.components(separatedBy: ".")[1]
            arr = Array(Set(Array(str2)))
            if arr.count == 10 {
                retNumbers.append((idx, str1))
                break
            }
            idx += 1
        }
        return retNumbers
    }
    
    /*
     * Q13-1
     * Find cryptarithmetic formula
     *
     * Parameter - formula
     * Returns   - replaced results with numbers
     */
    func findCryptarithmetic(formula: String) -> [String] {
        var retValues: [String] = []
        let nums = StringUtil().matches(for: "[^a-zA-Z]", in: formula)
        let chars = Array(Set(Array(nums.joined())))
        let haad = nums.map({return $0.first})
        
        _ = ArrayUtil().permutations(arr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], limit: 10, 0, options:{(seq) in
            var zeroFlg: Bool = false
            if seq.count < chars.count {
                return
            }
            if seq.contains(0) {
                zeroFlg = haad.contains(where: {$0 == chars[seq.index(of: 0)!]})
            }
            if !zeroFlg {
                var formulaVar: String = formula
                for i in 0 ..< chars.count {
                    formulaVar = formulaVar.replacingOccurrences(of: String(chars[i]), with: String(seq[i]))
                }
                
                let predicate: NSPredicate = NSPredicate(format: formulaVar)
                if predicate.evaluate(with: nil) {
                    retValues.append(formulaVar)
                }
            }
        })
        return retValues.sorted()
    }
    
    /*
     * Q14-1
     * Find the longest country name chain among following countries.
     *
     * Parameter - none
     * Returns   - the longest name chain
     */
    func findCountryNameChains() -> (Int, String) {
        var countryStack =  SStack<(Int, String)>()
        var chainLen: Int = 0
        var retChain: (Int, String) = (0, "")
        var countries: [String] = ["Brazil", "Croatia", "Mexico","Cameroon", "Spain", "Netherlands",
                                   "Chile", "Australia", "Colombia","Greece", "Cote d'lvoire", "Japan",
                                   "Uruguay", "Costa Rica", "England","Italy", "Switzerland", "Ecuador",
                                   "France", "Honduras", "Argentina", "Bosnia and Herzegovina", "Iran", "Nigeria",
                                   "Germany", "Portugal", "Ghana","USA", "Belgium", "Algeria",
                                   "Russia", "Korea Republic"]
        countries = countries.sorted()
        
        countryStack.push((0, ""))
        while countryStack.count > 0 {
            guard let poppedSts = countryStack.pop() else {
                continue
            }
            
            if chainLen < poppedSts.0 {
                chainLen = poppedSts.0
                retChain = poppedSts
            }
            
            for cname in countries {
                if poppedSts.1.contains(cname) {
                    continue
                }
                var usedNames = poppedSts.1
                if poppedSts.0 > 0 {
                    if usedNames.uppercased().last != cname.uppercased().first {
                        continue
                    }
                }
                usedNames = "\(usedNames),\(cname)"
                if usedNames.first == "," {
                    usedNames = String(usedNames[usedNames.index(after: usedNames.startIndex)..<usedNames.endIndex])
                }
                countryStack.push((poppedSts.0 + 1, usedNames))
            }
        }
        
        return retChain
    }
    
    /*
     * Q15-1
     * Find same steps while two people standing.
     *
     * Parameter - limit: max steps
     * Parameter - maxInterval: steps moving only once
     * Parameter - p1: step number of person 1 starting
     * Parameter - p2: step number of person 2 starting
     * Returns   - same steps while two people standing
     */
    func findSameSteps1(limit: Int) -> Int {
        var dfs_: ((Int, Int, Int, Int) -> Int)!
        let dfs = {(limit2: Int, interval: Int, p1: Int, p2: Int) -> Int in
            var retSameValue: Int = 0
            
            if p1 == p2 {
                return 1
            } else if p1 > p2 {
                return 0
            } else {
                for i in 1...interval {
                    for j in 1...interval {
                        retSameValue += dfs_(limit2, interval, p1 + i, p2 - j)
                    }
                }
            }
            return retSameValue
        }
        dfs_ = dfs
        return dfs(limit, 4, 0, limit)
    }
    
    /*
     * Q15-2
     * Find same steps while two people standing.
     *
     * Parameter - limit: max steps
     * Parameter - maxInterval: steps moving only once
     * Parameter - p1: step number of person 1 starting
     * Parameter - p2: step number of person 2 starting
     * Returns   - same steps while two people standing
     */
    func findSameSteps2(limit: Int) -> Int {
        let dfs = {(limit2: Int, interval: Int, p1: Int, p2: Int) -> Int in
            var retSameValue: Int = 0
            let limit2: Int = p2 - p1
            if limit2 < 1 || limit2 > limit  {
                return retSameValue
            }
            var psts: [Int] = Array(repeating: 0, count: limit2 + 1)
            psts[limit2] = 1
            
            for i in 0..<limit2 {
                for j in 0...limit2 {
                    for k in 1...interval {
                        if k > j { break }
                        psts[j-k] += psts[j]
                    }
                    psts[j] = 0
                }
                if i % 2 == 1 {
                    retSameValue += psts[0]
                }
            }
            return retSameValue
        }
        return dfs(limit, 4, 0, limit)
    }
    
    /*
     * Q16-1
     * Find cases when the area of rectacgles is eaual to area of another square.
     *
     * Parameter - lineLength: a line's length for making a square
     * Returns   - found cases
     */
    func findTwoRectEqualSquare(lineLength: Int) -> [[Int]] {
        var retValues: [[Int]] = []
        var chkRatioList: [[Float]] = []
        
        for m in 1...lineLength/4 {
            for i in 1..<2*m {
                if i >= m {continue}
                for j in 1..<2*m {
                    if j >= m  { continue }
                    let s1 = i * (2*m - i)
                    let s2 = j * (2*m - j)
                    if s1 + s2 == m * m {
                        let chkElem: [Float] = [Float(s2)/Float(s1), Float(m * m)/Float(s1)]
                        if chkRatioList.contains(where: {chkElem == $0}) {
                            continue
                        }
                        chkRatioList.append(chkElem)
                        
                        let elem: [Int] = [ i , 2*m - i, s1, j, 2*m - j, s2, m, m * m]
                        if retValues.contains(where: {elem[2] == $0[5]}) {
                            continue
                        }
                        retValues.append(elem)
                    }
                }
                
            }
        }
        
        return retValues.sorted(by: {$0[7] < $1[7]})
    }
    
    //Q17
    func calcRowingPatterns(limit: Int) -> BigInt {
        var retValue: BigInt = 0
        var male: BigInt = 1
        var female: BigInt = 0
        
        for _ in 0..<limit {
            male += female
            female = male - female
        }
        retValue = male + female
        
        return retValue
    }
    
    //Q18-1
    func findCakeCuttingBlocks01() -> [Int] {
        var retValues: [Int]!
        var cnt: Int = 2
        var squares: [Int] = []
        
        while true {
            squares = []
            for i in 2...Int(sqrt(Float(2*cnt))) {
                squares.append(i * i)
            }
            let arr = [1]
            let r = checkCuttingBlock01(squares: squares, n: cnt, preInt: 1, arr: arr)
            if r[0] == 1 {
                retValues = r
                retValues.removeFirst()
                break
            }
            cnt += 1
        }
        return retValues
    }
    
    //Q18-2
    func findCakeCuttingBlocks02() -> [Int] {
        var retValues: [Int] = []
        var cnt: Int = 2
        var squares: [Int] = []
        for i in 2..<1000 {
            squares.append(i * i)
        }
        
        while true {
            let r = checkCuttingBlock02(squares: squares, n: cnt, retArr: &retValues)
            if r {
                break
            }
            cnt += 1
        }
        return retValues
    }
    
    private func checkCuttingBlock01(squares: [Int], n: Int, preInt: Int, arr: [Int]) -> [Int] {
        var retArr: [Int] = []
        
        arr.forEach({retArr.append($0)})
        if n == arr.count {
            if squares.contains(1 + preInt) {
                retArr.insert(1, at: 0)
                return retArr
            }
        } else {
            let arr2: [Int] = (1...n).filter ({!arr.contains($0)})
            for i in arr2 {
                if squares.contains(i + preInt) {
                    let r = checkCuttingBlock01(squares: squares, n: n, preInt: i, arr: arr + [i])
                    if r[0] == 1 {
                        return r
                    }
                }
            }
        }
        retArr.insert(0, at: 0)
        return retArr
    }
    
    private func checkCuttingBlock02(squares: [Int], n: Int, retArr: inout [Int]) -> Bool {
        //var retArr = retArr
        var statusList =  SStack<(Int, [Int])>()
        var wkStatus: (Int, [Int]) = (1, [])
        for _ in 1...n {
            wkStatus.1.append(0)
        }
        wkStatus.1[0] = 1
        
        statusList.push(wkStatus)
        while !statusList.isEmpty {
            guard let poppedtatus = statusList.pop() else {
                continue
            }
            
            //Judge if StatusList is cleared
            if poppedtatus.0 > n - 1 {
                poppedtatus.1.forEach({retArr.append($0)})
                retArr.reverse()
                retArr.insert(retArr.removeLast(), at: 0)
                return true
            }
            
            wkStatus.0 = poppedtatus.0 + 1
            for i in 1...n {
                
                // seerch  a value in the stack.
                if poppedtatus.1.contains(i) {
                    continue
                }
                if !squares.contains(i + poppedtatus.1[poppedtatus.0 - 1]) {
                    continue
                }
                if poppedtatus.0 == n - 1 {
                    if !squares.contains(i + poppedtatus.1[0]) {
                        continue
                    }
                }
                
                // add  a value into the stack.
                wkStatus.1 = poppedtatus.1
                wkStatus.1[poppedtatus.0] = i
                statusList.push(wkStatus)
            }
        }
        return false
    }
    
    //Q19
    func findFriendNumbers(limit: Int) -> [Int] {
        var retValues: [Int] = []
        var minNumber: Int = 2
        
        var primeArr: [Int] = [2]
        var primeFlg: Bool = true
        
        //determine a prime numbers
        for i in 3...10000 {
            if primeArr.count >= limit {break}
            primeArr.forEach{
                if i % $0 == 0 {primeFlg = false}
            }
            if primeFlg {
                primeArr.append(i)
            } else {
                primeFlg = true
            }
        }
        minNumber = primeArr[primeArr.count - 1] * primeArr[primeArr.count - 1]
        
        _ = ArrayUtil().permutations(arr: primeArr, limit: limit, 0, options: {(prime) in
            var friends = [prime[0] * prime[0]]
            prime.eachConsecutive(2).forEach{friends += [$0[0] * $0[1]]}
            friends += [prime[prime.count - 1] * prime[prime.count - 1]]
            
            if let friendMax = friends.max() {
                if minNumber > friendMax {
                    minNumber = friendMax
                    retValues = friends
                }
            }
        })
        return retValues
        
    }
    
    //Q20
    func calculateMagicSquares() -> (Int, Int) {
        var mapValues: [Int:Int] = [:]
        let magicArr: [Int] = [1,14,14,4,11,7,6,9,8,10,10,5,13,2,3,15]
        
        mapValues[0] = 1
        for i in magicArr {
            for j in mapValues.keys.sorted(by: {$0 > $1}) {
                let sum: Int = i + j
                if mapValues.keys.contains(sum) {
                    mapValues[sum] = mapValues[sum]! + mapValues[j]!
                } else {
                    mapValues[sum] = mapValues[j]
                }
            }
        }
        var retValue: (Int, Int) = (0, 0)
        for item in mapValues {
            if item.value > retValue.1 {
                retValue.0 = item.key
                retValue.1 = item.value
            }
        }
        
        return retValue
    }
    
    //Q21-1
    func findZeroPosition01(zeroIndex: Int) -> Int {
        var arr: [[Int]] = [[1]]
        
        var row: Int = 1
        var zeroCnt: Int = 0
        while zeroCnt < zeroIndex {
            var item: [Int] = []
            for col in 0...row {
                if col == 0 || row == col {
                    item.append(1)
                } else {
                    item.append(arr[row-1][col-1] ^ arr[row-1][col])
                }
            }
            zeroCnt += item.filter({ $0 == 0}).count
            
            arr.append(item)
            
            row += 1
        }
        
        return row
    }
    
    //Q21-2
    func findZeroPosition02(zeroIndex: Int) -> Int {
        var row = 1
        var zeroCnt: Int = 0
        
        var item: String = "1"
        print("item[\(1)] = \(item)")
        while zeroCnt < zeroIndex {
            let item1: String = "\(item)0"
            let item2: String = "0\(item)"
            let itemChars1 = Array(item1)
            let itemChars2 = Array(item2)
            item = ""
            for i in 0..<itemChars1.count {
                item += "\(Int(String(itemChars1[i]))! ^ Int(String(itemChars2[i]))!)"
            }
            zeroCnt += (item.filter{$0 == "0"} as [Character]).count
            print("item[\(row + 1)] = \(item)")
            
            row += 1
        }
        return row
    }
    
    
    //Q22
    func calculatePairingPatterns(limit: Int) -> Int {
        var retValues: [Int] = [1]
        
        for i in 1...limit/2 + 1 {
            retValues.append(0)
            for j in 0..<i {
                retValues[i] += retValues[j] * retValues[i-j-1]
            }
            print("retValues = \(retValues[i-1])")
        }
        return retValues[limit/2]
    }
    
    //Q23
    func calculateBlackjackPatterns(coins: Int, level: Int) -> Int {
        var memoValue :[String: Int] = [:]
        var calcGame: ((_ c: Int, _ l: Int) -> Int)!
        let calcGameBlock = {(_ c: Int, _ l: Int) -> Int in
            if let retValue = memoValue["\(c,l)"] {
                return retValue
            }
            if c == 0 {
                return 0
            }
            if l == 0 {
                return 1
            }
            memoValue["\(c,l)"] = calcGame(c-1, l-1) + calcGame(c+1, l-1)
            return memoValue["\(c,l)"]!
        }
        calcGame = calcGameBlock
        return calcGameBlock(coins, level)
    }
    
    //Q24-1
    func calculateStrikePatterns01() -> Int {
        let zeroStr: String = "000000000"
        let twiceArr: [[String]] = [["1", "2"], ["1", "4"], ["2", "3"], ["3", "6"],
                                    ["4", "7"], ["6", "9"], ["7", "8"], ["8", "9"]]
        var prevPattern: [String: Int] = ["123456789":1]
        var retCnt: Int = 0
        
        for _ in 1...9 {
            var currPattern: [String: Int] = [:]
            for item in prevPattern {
                let nextBoard: [String] = self.makeNextBoardArr(board: item.key, byTwice: twiceArr)
                for b in nextBoard {
                    if currPattern.keys.contains(b) {
                        currPattern[b] = currPattern[b]! + item.value
                    } else {
                        currPattern[b] = item.value
                    }
                }
            }
            //print("result  at index: \(i)")
            //print("\(currPattern)")
            if currPattern.keys.contains(zeroStr) {
                retCnt += currPattern[zeroStr]!
            }
            
            prevPattern = currPattern
        }
        
        return retCnt
    }
    
    //list all patterns avaivle with given parameter
    private func makeNextBoardArr(board: String, byTwice twiceArr: [[String]]) -> [String] {
        var retArr: [String] = []
        
        //list each pattern one by one
        let boardChars = Array(board)
        for i in 0..<boardChars.count {
            if (boardChars[i] != "0") {
                var wkChars = boardChars;
                wkChars.remove(at: i)
                wkChars.insert("0", at: i)
                retArr.append(String(wkChars))
            }
        }
        
        //list each pattern  by twice
        let mkPatternByTwice = { (c1: String, c2: String) in
            if !board.contains(c1) {return}
            if !board.contains(c2) {return}
            
            var wkStr = board;
            wkStr = wkStr.replacingOccurrences(of: c1, with: "0")
            wkStr = wkStr.replacingOccurrences(of: c2, with: "0")
            retArr.append(wkStr);
        };
        for t in twiceArr {
            mkPatternByTwice(t[0], t[1])
        }
        
        return retArr
    }
    
    
    //Q24-2
    func calculateStrikePatterns02() -> Int {
        let boardPair: [[Int]] = [[1,2], [1,4], [2,3], [3,6], [4,7], [6,9], [7,8], [8,9]]
        var memoPatterns: [String: Int] = [:]
        
        var mkPatterns: ((_ stat: Int, _ level: Int) -> Int )!
        let mkPatterns2 = { (_ stat: Int, _ level: Int) -> Int in
            if let ret = memoPatterns["\(stat)"] {
                return ret
            }
            if stat == 0 {
                return 1
            }
            var statArr: [String] = []
            Array(String(stat, radix: 2)).forEach({statArr.append(String($0))})
            //print("level=[\(level)],\(statArr), stat=\(stat)")
            
            let f = { () -> Int in
                var r: Int = 0
                for p in boardPair {
                    if p[0] > statArr.count || p[1] > statArr.count {continue}
                    let n1 = statArr.count - p[0]
                    let n2 = statArr.count - p[1]
                    //print("--[1]\(statArr, p, Int(statArr[n1])!, Int(statArr[n2])!)")
                    if Int(statArr[n1])! > 0 && Int(statArr[n2])! > 0 {
                        //print("--[1]\(statArr, p)")
                        r += mkPatterns(stat & ~(1 << (p[0]-1) | 1 << (p[1]-1)), level+1)
                    }
                }
                for i in 0...8 {
                    if i >= statArr.count {continue}
                    let n1 = statArr.count - i - 1
                    //print("--[2]\(statArr, i, Int(statArr[n1])!)")
                    if Int(statArr[n1])! > 0  {
                        //print("--[2]\(statArr, i)")
                        r += mkPatterns(stat & ~(1 << i), level+1)
                    }
                }
                return r
            }
            memoPatterns["\(stat)"] = f()
            return memoPatterns["\(stat)"]!
        }
        mkPatterns = mkPatterns2
        return mkPatterns2(0b111111111, 1)
    }
    
    //Q24-3
    func calculateStrikePatterns03() -> Int {
        let boardPair: [[Int]] = [[1,2], [1,4], [2,3], [3,6], [4,7], [6,9], [7,8], [8,9],
                                  [1], [2], [3], [4], [5], [6], [7], [8], [9]]
        var memoPatterns: [String: Int] = ["\([])": 1]
        
        var mkPatterns: ((_ aBoard: [[Int]]) -> Int )!
        let mkPatterns2 = { (_ aBoard: [[Int]]) -> Int in
            if let retCnt1 = memoPatterns["\(aBoard)"] {
                return retCnt1
            }
            var retCnt: Int = 0
            
            for a in aBoard {
                var bBoard: [[Int]]!
                if a.count > 1 {
                    bBoard = aBoard.filter({!$0.contains(a[0]) && !$0.contains(a[1])})
                } else {
                    bBoard = aBoard.filter({!$0.contains(a[0])})
                }
                retCnt += mkPatterns(bBoard)
            }
            memoPatterns["\(aBoard)"] = retCnt
            return retCnt
        }
        mkPatterns = mkPatterns2
        return mkPatterns2(boardPair)
    }
    
    //Q25-1
    func calculateLacingPatterns01(holeLimit: Int) -> [Int] {
        
        //judge crossing
        let calcCross = {( _ data: [Int]) -> Int in
            var crossData: [(Int, Int)] = []
            var retCnt: Int = 0
            
            for i in 0..<data.count - 1 {
                if i % 2 == 0 {
                    crossData.append((data[i], data[i + 1]))
                } else {
                    crossData.append((data[i + 1], data[i]))
                }
            }
            
            //print("calcCross: \(data)")
            for i in 0..<crossData.count-1 {
                for j in i + 1 ... crossData.count - 1 {
                    if crossData[i].0 > crossData[j].0
                        && crossData[i].1 < crossData[j].1 {
                        retCnt += 1
                    }
                    if crossData[i].0 < crossData[j].0
                        && crossData[i].1 > crossData[j].1 {
                        retCnt += 1
                    }
                }
            }
            //print("calcCross: \(crossData, retCnt)")
            return retCnt
        }
        
        //do depth-first search
        let dfs = {(hole: Int) -> [Int] in
            var statusList = SStack<(Int, [Int])>()
            var wkStatus: (Int, [Int]) = (1, [0])
            var retArr: [Int] = []
            
            statusList.push(wkStatus)
            while !statusList.isEmpty {
                guard let poppedtatus = statusList.pop() else {
                    continue
                }
                
                //Judge if StatusList is cleared
                if poppedtatus.0 == 2 * hole {
                    retArr.append(calcCross(poppedtatus.1))
                    continue
                }
                
                wkStatus.0 = poppedtatus.0 + 1
                
                //hold up the last hole
                if poppedtatus.0 == 2 * hole - 1 {
                    wkStatus.1 = poppedtatus.1
                    wkStatus.1.append(0)
                    statusList.push(wkStatus)
                    continue
                }
                
                for i in 1..<hole {
                    let holeUsed: Bool = (poppedtatus.0 % 2 == 0)
                    var continueFlg: Bool = false
                    
                    for j in 0..<poppedtatus.1.count {
                        if holeUsed && j % 2 == 1 { continue }
                        if !holeUsed && j % 2 == 0 { continue }
                        if poppedtatus.1[j] == i {
                            continueFlg = true
                            break
                        }
                    }
                    if continueFlg { continue }
                    
                    // add  a value into the stack.
                    wkStatus.1 = poppedtatus.1
                    wkStatus.1.append(i)
                    statusList.push(wkStatus)
                }
            }
            return retArr
        }
        
        var retVal :[Int] = []
        for h in 2...holeLimit {
            let maxCross = dfs(h)
            retVal.append(maxCross.max()!)
            
        }
        return retVal
    }
    
    //Q25-2
    func calculateLacingPatterns02(holeLimit: Int) -> [Int] {
        var retVal: [Int] = []
        var crossLst: [String: Int] = [:]
        let aryUtil = ArrayUtil()
        
        for h in 2...holeLimit {
            _ = aryUtil.permutations(arr: ([Int])(1...h-1), limit: h - 1, 0, options: {(seq) in
                _ = aryUtil.permutations(arr: ([Int])(1...h-1), limit: h - 1, 0, options: {(seq2) in
                    
                    //collect lacing patterns
                    var patt: [[Int]] = []
                    var l: Int = 0
                    var r: Int = seq2[0]
                    
                    for i in 0 ..< h-1 {
                        patt.append([l, r])
                        l = seq[i]
                        patt.append([l, r])
                        if i + 1 >= seq2.count {continue}
                        r = seq2[i + 1]
                    }
                    patt.append([l, 0])
                    
                    //judge crossing
                    var crossCnt: Int = 0
                    for i in 0 ..< h * 2 - 1 {
                        for j in i + 1 ..< h * 2 - 1 {
                            var tmpVal = patt[i][0] - patt[j][0]
                            tmpVal *= (patt[i][1] - patt[j][1])
                            if tmpVal < 0 {
                                crossCnt += 1
                            }
                        }
                    }
                    if !crossLst.keys.contains("\(h)") {
                        crossLst["\(h)"] = crossCnt
                    } else {
                        crossLst["\(h)"] = [crossCnt, crossLst["\(h)"]!].max()!
                    }
                })
            })
        }
        for h in 2...holeLimit {
            retVal.append(crossLst["\(h)"]!)
        }
        return retVal
    }

    //Q26-1
    func calculateParkingRoutes01(limitX: Int, limitY: Int) -> Int {
        var parkingArr: [Int] = Array(repeating: 9, count: limitX + 1)
        for _ in 1...limitY {
            parkingArr += Array(repeating: 1, count: limitX) + [9]
        }
        parkingArr += Array(repeating: 9, count: limitX + 1)
        let parkLen: Int = parkingArr.count
        
        print( "parkingArr = \(parkingArr)")
        
        var targetArr: [Int] = parkingArr
        targetArr[limitX + 1] = 2
        var startingArr: [Int] = parkingArr
        startingArr[parkLen - limitX - 3] = 2
        var tracedLst: [String: Int] = [:]
        
        var retVal: Int = 0
        
        let fkey = {(_ str: String) -> String in
            return str.replacingOccurrences(of: ", ", with: "")
        }
        var dfs: ((_ prevData: [([Int], Int)], _ depth: Int) -> Void)!
        
        let dfs2 = { (_ prevData: [([Int], Int)], _ depth: Int) in
            var routelst: [([Int], Int)] = []
            for prev in prevData {
                for i in [-1, 1, limitX + 1, -1 - limitX] {
                    let m = prev.1
                    let n = i + m < 0 ? i + m + parkLen : i + m
                    
                    if prev.0[n] != 9 {
                        var tempArr: [Int] = prev.0
                        tempArr[n] = prev.0[m]
                        tempArr[m] = prev.0[n]
                        if !tracedLst.keys.contains(fkey("\(tempArr,n)")) {
                            routelst.append((tempArr, n))
                            tracedLst[fkey("\(tempArr,n)")] = depth + 1
                        }
                    }
                }
            }
            if let _ = tracedLst[fkey("\(targetArr,(limitX+1) * (limitY+1) - 2)")] {
                return
            }
            if routelst.count > 0 {
                dfs(routelst, depth + 1)
            }
        }
        dfs = dfs2
        
        tracedLst[fkey("\(startingArr,(limitX + 1) * limitY - 2)")] = 0
        tracedLst[fkey("\(startingArr,(limitX + 1) * (limitY + 1) - 3)")] = 0
        
        dfs([(startingArr, (limitX+1) * limitY - 2) ,
             (startingArr, (limitX+1) * (limitY+1) - 3)], 0)
        retVal = tracedLst[fkey("\(targetArr,(limitX+1) * (limitY+1) - 2)")]!
        return retVal
    }
    
    //Q26-2
    func calculateParkingRoutes02(limitX: Int, limitY: Int) -> Int {
        let replaceStr = {(str: String, pos1: Int, pos2: Int, withStr: String) -> String in
            let sIdx: String.Index = str.index(str.startIndex, offsetBy: pos1)
            let eIdx: String.Index = str.index(sIdx, offsetBy: pos2 - pos1)
            
            return str.replacingCharacters(in: sIdx..<eIdx, with: withStr)
        }
        
        let calcWay = {(way: [String]) -> Int in
            var x: Int = -1
            var y: Int = -1
            
            for i in 0..<way.count {
                if let idx = way.index(of: "C") {
                    x = idx
                    y = i
                    break
                }
            }
            return way[0].count - x + way.count - y
        }
        
        let dfs = {(_ level: Int) -> Int in
            var stateLst = SStack<(Int, Int, Int, [String], [[String]])>()
            //var stateLst: MStack = MStack()
            
            var wkState :(Int, Int, Int, [String], [[String]])
            wkState.0 = 0 //level
            wkState.1 = limitX - 1 //X
            wkState.2 = limitY - 1 //Y
            wkState.3 = Array(repeating: String(repeating: "1", count: limitX), count: limitY) //way
            wkState.3[0] = replaceStr(wkState.3[0], 0, 1, "C")
            wkState.3[limitY-1] = replaceStr(wkState.3[limitY-1], limitX-1, limitX, "0") //way history
            wkState.4 = [wkState.3]
            
            stateLst.push(wkState)
            
            var paths: [String: Int] = [:]
            while stateLst.count > 0 {
                guard let poppedStat: (Int, Int, Int, [String], [[String]]) = stateLst.pop() else {
                    continue
                }
                //let poppedStat: (Int, Int, Int, [String], [[String]]) = stateLst.popObject() as! (Int, Int, Int, [String], [[String]])
                
                //judge stack is cleared
                var poppedStatChars: [Character]  = Array(poppedStat.3[limitY-1])
                if poppedStatChars[limitX-1] == "C" {
                    for i in 0..<poppedStat.4.count {
                        print("[path: \(i)]")
                        for row in poppedStat.4[i] {
                            print("\t\(row)")
                        }
                    }
                    return poppedStat.4.count - 1
                }
                
                //judge if continue searching
                if poppedStat.0 + calcWay(poppedStat.3) > level {
                    continue
                }
                
                let pushStatList = {(x: Int, y: Int) in
                    if x < 0 || x >= limitX {return}
                    if y < 0 || y >= limitY {return}
                    
                    //wkState = (Int, Int, Int, [String], [[String]])()
                    wkState.0 = poppedStat.0 + 1 //level
                    wkState.1 = x //X
                    wkState.2 = y //Y
                    wkState.3 = poppedStat.3 //way
                    poppedStatChars = Array(poppedStat.3[y])
                    wkState.3[poppedStat.2] = replaceStr(wkState.3[poppedStat.2], poppedStat.1, poppedStat.1+1, String(poppedStatChars[x])) //way history
                    wkState.3[y] = replaceStr(wkState.3[y], x, x+1, "0") //way history
                    wkState.4 = [wkState.3]
                    
                    //judge min path
                    let pkey = wkState.3.joined(separator: "")
                    if let minPath = paths[pkey] {
                        if minPath <= wkState.0 {return}
                    }
                    paths[pkey] = wkState.0
                    wkState.4 = poppedStat.4
                    wkState.4.append(wkState.3)
                    
                    stateLst.push(wkState)
                }
                pushStatList(poppedStat.1, poppedStat.2 - 1)
                pushStatList(poppedStat.1, poppedStat.2 + 1)
                pushStatList(poppedStat.1 - 1, poppedStat.2)
                pushStatList(poppedStat.1 + 1, poppedStat.2)
            }
            return 0
        }
        
        var retVal: Int = 0
        var n: Int = 1
        while true {
            retVal = dfs(n)
            if retVal > 0 {
                break
            }
            n += 1
        }
        return retVal
    }
    
    //Q28 -
    func calculateMaxClubArea(personLimit: Int) -> Int {
        var retVal: Int = 0
        
        let clubAreaData: [(Int, Int)] = [(11000, 40), (8000, 30), (400, 24), (800, 20), (900, 14), (1800, 16), (1000, 15), (7000, 40), (100, 10), (300, 12)]
        var tmpDic: [String: Int] = [:]
        var dfs: (([(Int, Int)], Int) -> Int)!
        let dfs2 = {(data: [(Int, Int)], p: Int) -> Int in
            if tmpDic.keys.contains("\(data, p)") {
                return tmpDic["\(data, p)"]!
            }
            var maxArea: Int = 0
            
            for c in data {
                if p - c.1 >= 0 {
                    maxArea = [c.0 + dfs(data.filter({$0 != c}), p - c.1), maxArea].max()!
                }
            }
            tmpDic["\(data, p)"] = maxArea
            return maxArea
        }
        dfs =  dfs2
        retVal = dfs(clubAreaData, personLimit)
        return retVal
    }
    
    //Q30-1
    private var valKeeep: [String: BigInt] = ["1":1]
    func calculateTablePlugs01(limit: Int) -> BigInt {
        if valKeeep["\(limit)"] != nil {
            return valKeeep["\(limit)"]!
        }
        var retVal: BigInt = 0
        for i in 1...(limit/2) {
            if limit - i == i {
                retVal += calculateTablePlugs01(limit: i) * (calculateTablePlugs01(limit: i) + 1) / 2
            }
            else {
                retVal += calculateTablePlugs01(limit: limit - i) * calculateTablePlugs01(limit: i)
            }
        }
        
        //let n: Int = limit / 3
        for i in stride(from:1, through: limit / 3, by: 1) {
            for j in stride(from:i, through: (limit-i) / 2, by: 1) {
                if limit - i - j == i && i == j {
                    retVal += calculateTablePlugs01(limit: i) * (calculateTablePlugs01(limit: i) + 1) * (calculateTablePlugs01(limit: i) + 2) / 6
                }
                else if limit - i - j == i  {
                    retVal += calculateTablePlugs01(limit: i) *  (calculateTablePlugs01(limit: i) + 1) * calculateTablePlugs01(limit: j) / 2
                }
                else if i == j  {
                    retVal += calculateTablePlugs01(limit: limit - i - j) *  calculateTablePlugs01(limit: i) * (calculateTablePlugs01(limit: i) + 1) / 2
                }
                else if limit - i - j == j  {
                    retVal += calculateTablePlugs01(limit: j) *  (calculateTablePlugs01(limit: j) + 1) * calculateTablePlugs01(limit: i) / 2
                }
                else {
                    retVal += calculateTablePlugs01(limit: limit - i - j) * calculateTablePlugs01(limit: j) * calculateTablePlugs01(limit: i)
                }
            }
        }
        valKeeep["\(limit)"] = retVal
        return retVal
    }

    //Q31-1
    func calculateShortestPath01(limitX: Int, limitY: Int) -> BigInt {
        var val_keep: [String: BigInt] = [:]
        var dfs2: ((Int, Int, Int) -> BigInt)!
        let dfs = { (width: Int, height: Int, back_y: Int) -> BigInt in
            if val_keep["\(width,height,back_y)"] != nil {
                return val_keep["\(width,height,back_y)"]!
            }
            var retVal: BigInt = 0
            if width == 1 {
                retVal += (back_y == height) ? back_y : back_y + 2
                return retVal
            }
            if height == 1 {
                retVal += (back_y == 0) ? 2 : 1
                return retVal
            }
            if back_y == 0 {
                for i in 0..<height {
                    retVal += 2 * dfs2(width - 1, height, i + 1)
                }
            }
            else {
                for i in back_y...height {
                    retVal += dfs2(width - 1, height, i)
                }
                retVal += dfs2(width, height - 1, back_y - 1)
            }
            val_keep["\(width,height,back_y)"] = retVal
            return retVal
        }
        dfs2 = dfs
        
        return dfs(limitX, limitY, 0)
    }
    /*
    func calculateShortestPath01(limitX: Int, limitY: Int) -> MBigInteger {
        var val_keep: [String: MBigInteger] = [:]
        var dfs2: ((Int, Int, Int) -> MBigInteger)!
        let dfs = { (width: Int, height: Int, back_y: Int) -> MBigInteger in
            if val_keep["\(width,height,back_y)"] != nil {
                return val_keep["\(width,height,back_y)"]!
            }
            var retVal: MBigInteger = MBigInteger.create(fromLong: 0)
            if width == 1 {
                retVal += (back_y == height) ? back_y : back_y + 2
                return retVal
            }
            if height == 1 {
                retVal += (back_y == 0) ? 2 : 1
                return retVal
            }
            if back_y == 0 {
                for i in 0..<height {
                    retVal += 2 * dfs2(width - 1, height, i + 1)
                }
            }
            else {
                for i in back_y...height {
                    retVal += dfs2(width - 1, height, i)
                }
                retVal += dfs2(width, height - 1, back_y - 1)
            }
            val_keep["\(width,height,back_y)"] = retVal
            return retVal
        }
        dfs2 = dfs
        
        return dfs(limitX, limitY, 0)
    }*/

    //Q32-3
    func calculateTatamiPatterns03(h: Int, v: Int) -> Int {
        var stateLst = SStack<Q32State_t>()
        let limitX: Int = v
        let limitY: Int = h
        var wkState: Q32State_t = Q32State_t()
        var pattArr: [String] = []
        var pattStr: String = ""
        for _ in 0 ..< limitX {
            pattStr = "".padding(toLength: limitY, withPad: " ", startingAt: 0)
            pattArr.append(pattStr)
        }
        wkState.pattern = pattArr
        wkState.xx = 0
        wkState.yy = 0
        wkState.tatami_cnt = 0
        
        stateLst.push(wkState)
        
        var retVal: Int = 0
        
        
        //convert a number into char.
        let convDec2CHar: ((_: Int) -> String)? = {(_ num: Int) -> String in
            if num < 10 {
                return String(Int("1")! + num - 1)
            }
            else {
                return String(UnicodeScalar(Int(("A" as UnicodeScalar).value) + num - 10)!)
            }
        }

        ////judge cross pattern
        let judge_cross: ((_: Int, _: Int, _: [String]) -> Bool)? = {(_ xx: Int, _ yy: Int, _ pattArr: [String]) -> Bool in
            //judge cross position of top/bottom/left/right
            if xx - 1 < 0 {
                return false
            }
            if yy - 1 < 0 {
                return false
            }
            let str1: String = pattArr[xx - 1]
            let str2: String = pattArr[xx]
            if str1[yy - 1] == str1[yy] {
                return false
            }
            if str1[yy - 1] == str2[yy - 1] {
                return false
            }
            if str1[yy - 1] == str2[yy] {
                return false
            }
            return true
        }

        //adjust reserved patterns
        let adjust_reverved_list: ((_: String) -> [[Int]]) = {(_ patt: String) -> [[Int]] in
            var ret: [[Int]] = []
            if patt == "-" {
                ret.append([1])
                ret.append([1])
            }
            if patt == "|" {
                ret.append([1, 1])
            }
            return ret
        }

        //judge if a piece of tatami can be filled.
        let judge_fill_pieces: ((_: [[Int]], _: Int, _: Int, _: [String]) -> Bool)? = {(_ reserved_list: [[Int]], _ xx: Int, _ yy: Int, _ pattArr: [String]) -> Bool in
            for ii in 0 ..< reserved_list.count {
                if xx + ii >= limitX {
                    return false
                }
                for jj in 0 ..< reserved_list[0].count {
                    if yy + jj >= limitY {
                        return false
                    }
                    if reserved_list[ii][jj] != 0 && pattArr[xx + ii][yy + jj] != " " {
                        return false
                    }
                }
            }
            return true
        }
        
        while stateLst.count > 0 {
            guard var poppedState: Q32State_t = stateLst.pop() else {
                continue
            }
            if poppedState.tatami_cnt == limitX * limitY / 2 {
                retVal += 1
                q32_printPatt(poppedState.pattern, limitX: limitX, limitY: limitY)
                continue
            }
            //adjust coordinate x.
            if poppedState.xx >= limitX {
                poppedState.xx = 0
                poppedState.yy += 1
            }
            if poppedState.yy >= limitY {
                continue
            }
            
            let tatamiChars: [String] = ["-", "|"]
            for chr in tatamiChars {
                let resrvArr: [[Int]] = adjust_reverved_list(chr)
                //judge if a piece of tatami can be filled
                // - continue if false
                if !judge_fill_pieces!(resrvArr, poppedState.xx, poppedState.yy, poppedState.pattern) {
                    continue
                }
                //push stack if a piece can be filled.
                wkState = Q32State_t();
                wkState.xx = poppedState.xx + 1
                wkState.yy = poppedState.yy
                wkState.tatami_cnt = poppedState.tatami_cnt + 1

                var newPattArr = poppedState.pattern
                for ii in 0 ..< resrvArr.count {
                    for jj in 0 ..< resrvArr[0].count {
                        if resrvArr[ii][jj] == 0 {
                            continue
                        }
                        var rowStr: String = newPattArr![poppedState.xx + ii]
                        let c = convDec2CHar!(wkState.tatami_cnt)
                        rowStr = rowStr.replacingCharacters(in: rowStr.range(location: poppedState.yy + jj, length: 1), with: c)
                        newPattArr?[poppedState.xx + ii] = rowStr
                    }
                }
                wkState.pattern = newPattArr
                if !judge_cross!(poppedState.xx, poppedState.yy, wkState.pattern) {
                    stateLst.push(wkState)
                }
                
            }

            //push into stack without filling tatamis.
            if poppedState.pattern[poppedState.xx][poppedState.yy] != " " {
                wkState.pattern = poppedState.pattern
                wkState.xx = poppedState.xx + 1
                wkState.yy = poppedState.yy
                wkState.tatami_cnt = poppedState.tatami_cnt
                stateLst.push(wkState)
            }
        }
        return retVal
    }
    
    func q32_printPatt(_ arr: [String], limitX: Int, limitY: Int) {
        var pattArr = arr
        //set '-' and '|'
        while pattArr.filter( { $0.contains("-") || $0.contains("|") }).count < 1 {
            for ii in 0..<limitX {
                var str: String = pattArr[ii]
                for jj in 0..<limitY {
                    let c = str[jj]
                    if c == "-" || c == "|" {
                        continue
                    }
                    //adjust layout '-' if the same number
                    var sameXX: Bool = false
                    for x in 0..<limitX {
                        if x == ii {
                            continue
                        }
                        var str2: String = pattArr[x]
                        if str2[jj] == c {
                            str2 = str2.replacingCharacters(in: str2.range(location: jj, length: 1), with: "-")

                            pattArr[x] = str2
                            //pBanArr[LoopX, Y] = '-';
                            sameXX = true
                            break
                        }
                    }
                    str = str.replacingCharacters(in: str.range(location: jj, length: 1), with: (sameXX ? "-" : "|"))
                    pattArr[ii] = str
                }
            }
        }
        var outStr: String = ""
        for jj in 0..<limitY {
            outStr = outStr + ("\n")
            for ii in 0..<limitX {
                outStr = outStr + ("\(pattArr[ii][jj])")
            }
        }
        print("\(outStr)")
    }
    
    //Q32-4
    func calculateTatamiPatterns04(h: Int, v: Int) -> Int {
        var tatami: [[UnicodeScalar]] = []
        var corner: [[Int]] = []
        var D: [[Int]] = [[0, 1, Int(("-" as UnicodeScalar).value)], [1, 0, Int(("|" as UnicodeScalar).value)]]
        let chr0 = UnicodeScalar(0)
//        var memoDic: [String: Int] = [:]
        
        for _ in 0..<h + 2 {
            var t: [UnicodeScalar] = []
            var c: [Int] = []
            for _ in 0..<v + 2 {
                t.append(chr0!)
                c.append(0)
            }
            tatami.append(t)
            corner.append(c)
        }
        var dfs2: ((Int, Int) -> Int)!
        let dfs = { (x: Int, y: Int) -> Int in
//            let key: String = "\(x,y)"
//            if (memoDic[key] != nil) {
//                return memoDic[key]!
//            }
            if(x == h) {
                for i in 0..<h {
                    var str: String = ""
                    for j in 0..<v {
                        str += String(tatami[i][j])
                    }
                    print(str)
                }
                print("")
                return 1
            }
            if y == v {
                return dfs2(x+1,0)
            }
            if tatami[x][y] != chr0 {
                return dfs2(x, y + 1)
            }
            
            var l = 0, r = 0
            for k in 0..<2 {
                let x1 = x+D[k][0]; let y1 = y+D[k][1]
                if (x + D[k][0] < h)
                    && (y + D[k][1] < v)
                    && (tatami[x1][y1] == chr0) {
                    tatami[x][y] = UnicodeScalar(D[k][2])!
                    tatami[x+D[k][0]][y+D[k][1]] = tatami[x][y]
                    
                    for i in 0..<4 {
                        l = i
                        corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)] += 1
                    }
                    for i in 0..<4 {
                        l = i
                        if corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)] > 3 {break}
                    }
                    if l == 3 {
                        r += dfs2(x, y+1)
                    }
                    for i in 0..<4 {
                        l = i
                        corner[x+l/2*(D[k][0]+1)][y+l/2*(D[k][1]+1)] -= 1
                    }
                    tatami[x][y] = chr0!; tatami[x+D[k][0]][y+D[k][1]] = chr0!
                }
            }
//            memoDic[key] = r
            return r
        }
        dfs2 = dfs
        return dfs(0, 0)
    }
    
    //Q33-2
    func calculateUtacartaWords02() -> Int {
        var colA = [String]()
        var colB = [String]()
        let fname: String? = Bundle.main.path(forResource: "q33", ofType: "csv")
        let fileContents = try? String(contentsOfFile: fname!, encoding: String.Encoding.utf8)
        let dataRows: [String]? = fileContents?.components(separatedBy: "\n")
        
        let trim_str: ((_: String) -> String) = {(_ inStr: String) -> String in
            var str: String = inStr.trimmingCharacters(in: CharacterSet.whitespaces)
            str = str.replacingOccurrences(of: "\"", with: "")
            return str
        }
        for (idx, str) in (dataRows?.enumerated())! {
            if idx > 0 {
                let columns: [String]? = str.components(separatedBy: ",")
                if columns != nil && (columns?.count)! > 1 {
                    colA.append(trim_str((columns?[0])!))
                    colB.append(trim_str((columns?[1])!))
                }
            }
        }
        
        var retVal: Int = 0
        
        var calc_words_1:(([String], Int) -> Int)!
        let calc_words = {(arr: [String], len: Int) -> Int in
            var cnt: Int = 0
            if arr.count == 1 {
                cnt += len - 1
            } else {
                arr.uniqStringArray(keyRangeStart: 0, keyRangeEnd: len).forEach { str in
                    cnt += calc_words_1(arr.filter{$0.hasPrefix(String(str[str.range(location: 0, length: len)]))}, len + 1)
                }
            }
            return cnt
        }
        calc_words_1 = calc_words
        
        retVal += calc_words(colA, 1)
        retVal += calc_words(colB, 1)
        return retVal
    }
    
    //Q34-2
    //Hisha - rook, Kaku - bishop
    //calculate a rook and a bishop being moved ranges.
    func calculateChessRange02() -> Int {
        let bound: Int = 9
        var retCnt: Int = 0
        
        let calc_range = {(rx: Int, ry: Int, bx: Int, by: Int) -> Int in
            var reangeSet: Set<String> = []
            
            for p in [[1, -1], [1, 1], [-1, 1], [-1, -1]] {
                for i in 1..<bound {
                    let x: Int = bx + i * p[0], y: Int = by + i * p[1]
                    if x < 0 || y < 0 || x >= bound || y >= bound {
                        continue
                    }
                    if x == rx && y == ry  {
                        break
                    }
                    reangeSet.insert("\(x,y)")
                }
            }
            for p in [[0, -1], [1, 0], [0, 1], [-1, 0]] {
                for i in 1..<bound {
                    let x: Int = rx + i * p[0], y: Int = ry + i * p[1]
                    if x < 0 || y < 0 || x >= bound || y >= bound {
                        continue
                    }
                    if (rx == bx && y == by) || (x == bx && ry == by) {
                        break
                    }
                    reangeSet.insert("\(x,y)")
                }
            }
            return reangeSet.count
        }
        
        
        let calc_range2 = {(bx: Int, by: Int) -> Int in
            var cnt: Int = 0
            
            for rx in 0..<bound {
                for ry in 0..<bound {
                    if rx == bx && ry == by {
                        continue
                    }
                    cnt += calc_range(rx, ry, bx, by)
                }
                
            }
            return cnt
        }
        
        //set a bishop ranges can be moved.
        for bx in 0...(bound - 1) / 2 {
            for by in 0...(bound - 1) / 2 {
                var cnt: Int = calc_range2(bx, by)
                if bound - 1 - bx != bx  {
                    cnt *= 2
                }
                if bound - 1 - by != by  {
                    cnt *= 2
                }
                retCnt += cnt
            }
        }
        
        return retCnt
    }
    
    //Q35-2
    func calculateEncounterPatterns02(limit: Int) -> BigInt {
        var stateLst = SStack<Q35State_t>()
        var wkState: Q35State_t = Q35State_t()

        wkState.x1 = 0; wkState.y1 = 0
        wkState.x2 = limit; wkState.y2 = limit
        wkState.metCount = 0
        
        stateLst.push(wkState)
        
        var retVal: BigInt = BigInt(0)
        
        //Push the new state to queues.
        let addQueue_proc = {(popped: Q35State_t, x1: Int, y1: Int, x2: Int, y2: Int) in
            if x1 < 0 || x1 > limit {return}
            if y1 < 0 || y1 > limit {return}
            if x2 < 0 || x2 > limit {return}
            if y2 < 0 || y2 > limit {return}
            wkState = Q35State_t()
            wkState.x1 = x1; wkState.y1 = y1
            wkState.x2 = x2; wkState.y2 = y2
            wkState.metCount = popped.metCount
            stateLst.push(wkState)
        }
        
        //Calculate the rest patterns with Combination
        let comb_proc: (Int, Int) -> Int = {(n: Int, r: Int) -> Int in
            var cnt: Int = 1
            let r: Int = [r, n - r].min()!
            
            for i in stride(from: n - r + 1, through: n, by: 1) {
                cnt *= i
            }
            for i in stride(from: 2, through: r, by: 1) {
                cnt /= i
            }
            return cnt
        }
        
        while stateLst.count > 0 {
            guard var poppedState:Q35State_t = stateLst.pop() else {
                continue
            }
            if poppedState.x1 == poppedState.x2 {poppedState.metCount += 1}
            if poppedState.y1 == poppedState.y2 {poppedState.metCount += 1}
            
            //Judge for meeting patterns
            if poppedState.metCount >= 2 {
                let n1: Int = limit - poppedState.x1 + limit - poppedState.y1;
                let r1: Int = limit - poppedState.x1;
                let comb1: Int = comb_proc(n1, r1)
                
                let n2: Int = poppedState.x2 + poppedState.y2
                let r2: Int = poppedState.y2
                let comb2: Int = comb_proc(n2, r2)
                
                retVal += comb1 * comb2
                continue
            }
            
            //Change their positions to move next
            addQueue_proc(poppedState, poppedState.x1, poppedState.y1 + 1, poppedState.x2, poppedState.y2 - 1)
            addQueue_proc(poppedState, poppedState.x1, poppedState.y1 + 1, poppedState.x2 - 1, poppedState.y2)
            addQueue_proc(poppedState, poppedState.x1 + 1, poppedState.y1, poppedState.x2, poppedState.y2 - 1)
            addQueue_proc(poppedState, poppedState.x1 + 1, poppedState.y1, poppedState.x2 - 1, poppedState.y2)
        }
        return retVal
    }

    //Q35-3
    func calculateEncounterPatterns03(limit: Int) -> BigInt {
        let next_perm = {( arr: inout [Int], n: Int) -> Bool in
            if n < 0 || arr.count < n {
                return false
            }
            arr.replaceSubrange(arr.startIndex..<arr.endIndex, with: arr[0..<n] + arr[n..<arr.count].reversed())
            var k: Int = NSNotFound
            var l: Int = NSNotFound
            for i in stride(from: arr.count - 2, through: 0, by: -1) {
                if arr[i] < arr[i + 1] {k = i;break}
            }
            if k == NSNotFound {
                arr = arr.reversed()
                return false
            }
            for i in stride(from: arr.count - 1, through: k+1, by: -1) {
                if arr[k] < arr[i] {l = i;break}
            }
            if l == NSNotFound {return false}
            let t = arr[l]; arr[l] = arr[k]; arr[k] = t
            arr.replaceSubrange(arr.startIndex..<arr.endIndex, with: arr[0..<k+1] + arr[k+1..<arr.count].reversed())
           return true
        }
        var retVal: BigInt = BigInt(0)
     
        var eArr: [Int] = (Array(repeating: 0, count: limit) + Array(repeating: 1, count: limit)).sorted()
        var fArr: [Int] = eArr

        repeat {
            repeat {
                var flg: Int = 0, x1: Int = 0, y1: Int = 0, x2: Int = limit, y2: Int = limit
                for i in 0..<2*limit {
                    x1 += (eArr[i] == 0) ? 1 : 0
                    y1 += (eArr[i] == 1) ? 1 : 0
                    x2 -= (fArr[limit*2-1-i] == 0) ? 1 : 0
                    y2 -= (fArr[limit*2-1-i] == 1) ? 1 : 0
                    flg += (x1 == x2) ? 1 : 0
                    flg += (y1 == y2) ? 1 : 0
                }
                retVal += (flg >= 2) ? 1 : 0
            } while next_perm(&fArr, fArr.count)
        } while next_perm(&eArr, eArr.count)
        return retVal
    }

    //Q35-4
    func calculateEncounterPatterns04(limit: Int) -> BigInt {
        let each_perm = {( arr:[Int], n: Int, yieldItr: (([Int]) -> ())? ) -> [[Int]] in
            var retArr: [[Int]] = []
            if n < 0 || arr.count < n {
                return retArr
            }
            var arr = arr
            arr = arr.sorted()
            while true {
                retArr.append(arr)
                if yieldItr != nil {yieldItr?(arr)}
                arr.replaceSubrange(arr.startIndex..<arr.endIndex, with: arr[0..<n] + arr[n..<arr.count].reversed())
                var k: Int = NSNotFound
                var l: Int = NSNotFound
                for i in stride(from: arr.count - 2, through: 0, by: -1) {
                    if arr[i] < arr[i + 1] {k = i;break}
                }
                if k == NSNotFound {
                    arr = arr.reversed()
                    break
                }
                for i in stride(from: arr.count - 1, through: k+1, by: -1) {
                    if arr[k] < arr[i] {l = i;break}
                }
                if l == NSNotFound {break}
                let t = arr[l]; arr[l] = arr[k]; arr[k] = t
                arr.replaceSubrange(arr.startIndex..<arr.endIndex, with: arr[0..<k+1] + arr[k+1..<arr.count].reversed())
            }
            return retArr
        }
        var retVal: BigInt = BigInt(0)
        
        let eArr: [Int] = (Array(repeating: 0, count: limit) + Array(repeating: 1, count: limit)).sorted()
        let fArr: [Int] = eArr

        _ = each_perm(eArr, eArr.count, {arr in
           _ = each_perm(fArr, fArr.count,   {arr2 in
                var flg: Int = 0, x1: Int = 0, y1: Int = 0, x2: Int = limit, y2: Int = limit
                for i in 0..<2*limit {
                    x1 += (arr[i] == 0) ? 1 : 0
                    y1 += (arr[i] == 1) ? 1 : 0
                    x2 -= (arr2[limit*2-1-i] == 0) ? 1 : 0
                    y2 -= (arr2[limit*2-1-i] == 1) ? 1 : 0
                    flg += (x1 == x2) ? 1 : 0
                    flg += (y1 == y2) ? 1 : 0
                }
                retVal += (flg >= 2) ? 1 : 0
            })
        })
        return retVal
    }
    
    //Q36-2
    func findCircularSevenZero02(limit: Int) -> [String] {
        var arr: [[BigInt]] = []
        
        //push numbers including 0 and 7 into stacks
        let genn_num_arr = {(nBase: Int)->[BigInt] in
            var nArr: [BigInt] = []
            var statelst: SStack<Q36State2_t> = SStack<Q36State2_t>()
            var wkState: Q36State2_t = Q36State2_t()
            wkState.depth = 0; wkState.targetNum = 0
            statelst.push(wkState)
            
            let pushSt = {(poppedObj: Q36State2_t, num: BigInt) in
                wkState.depth = poppedObj.depth + 1
                wkState.targetNum = num
                statelst.push(wkState)
            }
            while statelst.count > 0 {
                guard let poppedState = statelst.pop() else {
                    continue
                }
                nArr.append(poppedState.targetNum)
                if poppedState.depth == nBase {continue}
                pushSt(poppedState, poppedState.targetNum * 10 + 0)
                pushSt(poppedState, poppedState.targetNum * 10 + 7)
            }
            nArr = nArr.filter{$0 > 0}
            return nArr
        }
        
        //judge circular number
        let judge_circ = {(inNum: BigInt) ->Bool in
            let s: String = inNum.asString(withBase: 10)
            return s == String(s.reversed())
        }
        
        //judge if contains 0 and 7
        let judge_exist0and7 = {(inNum: BigInt) ->Bool in
            let s: String = inNum.asString(withBase: 10)
            return s.contains(where: {$0 == "0" || $0 == "7"})
        }
        
        
        // find numbers including 0 and 7.
        let ranges = Array(1...limit).filter{$0 % 2 > 0}.filter{$0 % 5 > 0}
        for d in 1...30 {
            let nArr: [BigInt] = genn_num_arr(d)
            var continued: Bool = false
            
            for i in 1...limit {
                if !nArr.contains(where: {$0 % i == 0}) {
                    continued = true
                    break
                }
                if continued {continue}
            }
            if continued {continue}
            for r in ranges {
                let num: BigInt = nArr.filter{$0 % r == 0}.min()!
                if !judge_circ(num) {continue}
                if !judge_exist0and7(num) {continue}

                arr.append([BigInt(r), num/BigInt(r), num])
            }
            break
        }
        
        //sort numbers found
        arr.sort { (v1, v2) -> Bool in
            return v1[0] <= v2[0]
        }
      
        //set returning values
        var retArr: [String] = []
        for v in arr {
            retArr.append("\(v[0]) x \(v[1]) = \(v[2])")
        }
        return retArr
    }
    
    //Q37-3
    func findDicePatterns03(limit: Int) -> [Int] {
        let pow_num = {(num1: Int, num2: Int) -> Int in
            var retv: Int = 1
            if num2 <= 0 {return retv}
            for _ in 1...num2 {
                retv *= num1
            }
            return retv
        }
        let next_dice = { (d: Int) -> Int in
            let t: Int = d / pow_num(limit, 5)
            let l: Int = d / pow_num(limit, 5 - t)
            let r: Int = d % pow_num(limit, 5 - t)
            return (r + 1) * pow_num(limit, t + 1) - (l + 1)
        }
        
        var retArr: [Int] = []
        let num: Int = pow_num(limit, limit)
        for i in 0..<num {
            var chkArr: [Int] = []
            
            // look for next dice
            var d: Int = i
            while !chkArr.contains(d) {
                chkArr.append(d)
                d = next_dice(d)
            }
            if chkArr.index(of: d) != 0 {
                retArr.append(d + 111111)
            }
        }
        retArr.sort()
        
        return retArr
    }
    
    //Q37-4
    func findDicePatterns04(limit: Int) -> [Int] {
        let next_dice = { (d: Int) -> Int in
            let t: Int = d / self.pow_num(num1: limit, num2: 5)
            let l: Int = d / self.pow_num(num1: limit, num2: 5 - t)
            let r: Int = d % self.pow_num(num1: limit, num2: 5 - t)
            return (r + 1) * self.pow_num(num1: limit, num2: t + 1) - (l + 1)
        }
        
        var retArr: [Int] = []
        let num: Int = self.pow_num(num1: limit, num2: limit)
        var allPatts: [Int] = Array(repeating: 0, count: num)
        for i in 0..<num {
            if allPatts[i] == 0 {
                var chkArr: [Int] = []
                
                // look for next dice
                var d: Int = i
                while allPatts[i] == 0 && !chkArr.contains(d) {
                    chkArr.append(d)
                    d = next_dice(d)
                }

                if let idx: Int = chkArr.index(of: d), idx != NSNotFound {
                    for j in 0..<chkArr.count {
                        if j < idx {
                            allPatts[chkArr[j]] = 1
                            retArr.append(chkArr[j] + 111111)
                        } else {
                            allPatts[chkArr[j]] = 2
                        }
                    }
                }else{
                    for j in 0..<chkArr.count {
                        allPatts[chkArr[j]] = 1
                        retArr.append(chkArr[j] + 111111)
                    }
                }
            }
        }
        retArr = Array(Set(retArr))
        retArr.sort()
        
        return retArr
    }

    //Q37-5
    func findDicePatterns05(limit: Int) -> [Int] {
        let conv_patt_num = {(numArr: [Int]) -> Int in
            var retVal: Int = 0
            for num in numArr {
                retVal *= 10
                retVal += num
            }
            return retVal
        }
        
        let fetch_next_patt = {(numArr: [Int]) -> [Int] in
            var arr: [Int] = []
            for i in numArr[0]..<numArr.count {
                arr.append(numArr[i])
            }
            for i in 0..<numArr[0] {
                arr.append(7-numArr[i])
            }
            return arr
        }
        
        let first_cycle = {(numArr: [Int]) -> Bool in
            var usedArr: [Int] = []
            var arr: [Int] = numArr
            var retVal: Bool = false
        
            while true {
                let n: Int = conv_patt_num(arr)
                if usedArr.contains(n)  {
                    retVal = ( n == usedArr[0])
                    break
                }
                usedArr.append(n)
                arr = fetch_next_patt(arr)
            }
            
            return retVal
        }
        
        //push and pop stack for making valid dice pattern list
        var arr: [[Int]] = []
        var retArr: [Int] = []
        var wkState: Q37State5_t = Q37_State5_Struct()
        var stateLst: SStack<Q37State5_t> = SStack<Q37State5_t>()
        stateLst.push(wkState)
        
        while stateLst.count > 0 {
            guard let poppedState: Q37State5_t = stateLst.pop() else {
                continue
            }
            if poppedState.depth == limit {
                arr.append(poppedState.numArr)
                continue
            }
            
            for i in 1...limit {
                wkState = Q37_State5_Struct()
                wkState.depth = poppedState.depth + 1
                wkState.numArr = poppedState.numArr
                wkState.numArr.append(i)
                stateLst.push(wkState)
            }
        }
        arr.forEach { (item) in
            if !first_cycle(item) {
               retArr.append(conv_patt_num(item))
            }
        }
        retArr.sort()
        return retArr
    }

    //Q37-6
    func findDicePatterns06(limit: Int) -> [Int] {
        let conv_patt_num = {(numArr: [Int]) -> Int in
            var retVal: Int = 0
            for num in numArr {
                retVal *= 10
                retVal += num
            }
            return retVal
        }
        
        let fetch_next_patt = {(numArr: [Int]) -> [Int] in
            var arr: [Int] = []
            for i in numArr[0]..<numArr.count {
                arr.append(numArr[i])
            }
            for i in 0..<numArr[0] {
                arr.append(7-numArr[i])
            }
            return arr
        }

        var retArr: [Int] = []
        let num: Int = self.pow_num(num1: limit, num2: 6)
        for i in 1...num {
            var dc: [Int] = [i/limit/limit/limit/limit/limit + 1, i/limit/limit/limit/limit % limit + 1,
                             i/limit/limit/limit % limit + 1, i/limit/limit % limit + 1, i/limit % limit + 1, i % limit + 1]
            var mem: [String: Int] = [:]
            var arr: [[Int]] = []
            while true {
                if let _ = mem["\(dc)"] {break}
                mem["\(dc)"] = arr.count
                arr.append(dc)
                
                //look for next dice
                dc = fetch_next_patt(dc)
            }
            guard let n = mem["\(dc)"] else {continue}
            for i in 0..<n {
                retArr.append(conv_patt_num(arr[i]))
            }
            
            retArr.sort()
        }
        return retArr
    }
    
    //Q38-2(ref 1)
    func findNumberSwitchPatterns02() -> [Dictionary<String, String>] {
        //bits of 0 ~ 9
        let  bits:[Int] = [0b1111110, 0b0110000, 0b1101101, 0b1111001, 0b0110011,
                           0b1011011, 0b1011111, 0b1110000, 0b1111111, 0b1111011]

        // calculate patterns when switch two numbers
        let num_switch =  {(num1: Int, num2: Int) -> Int in
            if num1 < 0 || num1 > 9 || num2 < 0 || num2 > 9 {return 0}
            let sum: Int = (String(bits[num1] ^ bits[num2], radix: 2).filter({$0 == "1"}) as [Character]).count
            return sum
        }
        
        // set switch path
        let out_switch_path = {(arr: [Int]) -> String in
            var path: String = ""
            for i in 0..<arr.count {
                path += "\(arr[i])"
                if i < arr.count - 1 {
                    path += "-[\(num_switch(arr[i], arr[i+1]))]->"
                }
            }
            return path
        }
        
        //  min value of all patterns
        var minVal: Int = 9999
        var retArr: [Dictionary<String, String>] = []
        _ = ArrayUtil().permutations(arr: Array(0...9), limit: 10, 0) { (seq) in
            var sum: Int = 0
            for i in 0..<seq.count-1 {
                sum += num_switch(seq[i], seq[i+1])
                if minVal <= sum {break}
            }
            if minVal > sum {
                minVal = sum
                retArr.append(["times":"\(minVal)", "path":out_switch_path(seq)])
            }
        }
        return retArr
    }

    //Q38-3(ref 2)
    func findNumberSwitchPatterns03() -> [Dictionary<String, String>] {
        //bits of 0 ~ 9
        let  bits:[Int] = [0b1111110, 0b0110000, 0b1101101, 0b1111001, 0b0110011,
                           0b1011011, 0b1011111, 0b1110000, 0b1111111, 0b1111011]
        
        // calculate patterns and keep them into array beforehand.
        var num_arr: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
        for i in 0..<10 {
            for j in 0..<10 {
                num_arr[i][j] = (String(bits[i] ^ bits[j], radix: 2).filter{$0 == "1"} as [Character]).count
            }
        }

        // set switch path
        let out_switch_path = {(arr: [Int]) -> String in
            var path: String = ""
            for i in 0..<arr.count {
                path += "\(arr[i])"
                if i < arr.count - 1 {
                    path += "-[\(num_arr[arr[i]][arr[i+1]])]->"
                }
            }
            return path
        }
        
        //  min value of all patterns
        var minVal: Int = 9999
        var retArr: [Dictionary<String, String>] = []
        _ = ArrayUtil().permutations(arr: Array(0...9), limit: 10, 0) { (seq) in
            var sum: Int = 0
            for i in 0..<seq.count-1 {
                sum += num_arr[seq[i]][seq[i+1]]
                if minVal <= sum {break}
            }
            if minVal > sum {
                minVal = sum
                retArr.append(["times":"\(minVal)", "path":out_switch_path(seq)])
            }
        }
        return retArr
    }

    //Q38-4(ref 3)
    func findNumberSwitchPatterns04() -> [Dictionary<String, String>] {
        //bits of 0 ~ 9
        let  bits:[Int] = [0b1111110, 0b0110000, 0b1101101, 0b1111001, 0b0110011,
                           0b1011011, 0b1011111, 0b1110000, 0b1111111, 0b1111011]
        
        // calculate patterns and keep them into array beforehand.
        var num_arr: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
        for i in 0..<10 {
            for j in 0..<10 {
                num_arr[i][j] = {
                    var cnt: Int = 0
                    var num: Int = bits[i] ^ bits[j]
                    while num > 0 {
                        cnt += (num % 2 == 1) ? 1 : 0
                        num = num / 2
                    }
                    return cnt
                }()
            }
        }
        
        // set switch path
        let out_switch_path = {(arr: [Int]) -> String in
            var path: String = ""
            for i in 0..<arr.count {
                path += "\(arr[i])"
                if i < arr.count - 1 {
                    path += "-[\(num_arr[arr[i]][arr[i+1]])]->"
                }
            }
            return path
        }
        
        //  min value of all patterns
        var minVal: Int = 9999
        var retArr: [Dictionary<String, String>] = []
        var dfs_: ((_ usedArr: [Bool], _ sum: Int, _ arr: [Int], _ idx: Int) -> Void)!
        let dfs = {(_ usedArr: [Bool], _ sum: Int, _ arr: [Int], _ idx: Int) -> Void in
            var usedArr = usedArr
            var arr = arr
            
            let prevNum: Int = (idx > 0) ? arr[idx-1]: -1
            if !usedArr.contains(false) {
                minVal = sum
                retArr.append(["times":"\(minVal)", "path":out_switch_path(arr)])
            } else {
                for i in 0..<10 {
                    if usedArr[i] == false {
                        usedArr[i] = true
                        let sum1: Int = (prevNum >= 0) ? sum + num_arr[prevNum][i] : 0
                        if minVal > sum1 {
                            arr[idx] = i
                            dfs_(usedArr, sum1, arr, idx + 1)
                        }
                        usedArr[i] = false
                    }
                }
            }
        }
        dfs_ = dfs
        let usedArr: [Bool] = Array(repeating: false, count: 10)
        let arr: [Int] = Array(repeating: -1, count: 10)
        dfs(usedArr, 0, arr, 0)
        return retArr
    }
}
