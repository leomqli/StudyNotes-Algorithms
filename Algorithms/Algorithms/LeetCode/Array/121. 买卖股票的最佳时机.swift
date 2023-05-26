//
//  121. 买卖股票的最佳时机.swift
//  Algorithms
//
//  Created by Leo on 2022-11-26.
//
//  https://leetcode.cn/problems/best-time-to-buy-and-sell-stock

/*
 
 给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

 你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。
 设计一个算法来计算你所能获取的最大利润。

 返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回0。

 示例 1：
 输入：[7,1,5,3,6,4]
 输出：5
 解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
      注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
 
 示例 2：
 输入：prices = [7,6,4,3,1]
 输出：0
 解释：在这种情况下, 没有交易完成, 所以最大利润为 0。

 提示：
 1 <= prices.length <= 105
 0 <= prices[i] <= 104
 */

extension Algorithm {
    static func test121() {
        let prices = [1,2]
//        let prices = [7,1,5,3,6,4] // 5
//        let prices = [7,6,4,3,1] // 0
        print(Solution().maxProfit1(prices))
    }
}

extension Solution {
    
    /// 暴力法
    /// 时间复杂度：O(n^2)。循环运行 n(n−1) / 2 次。
    /// 空间复杂度：O(1)。只使用了常数个变量。
    /// 会超时！！！
    func maxProfit(_ prices: [Int]) -> Int {
        
        let count = prices.count
        var max = 0
        
        for i in 0 ..< count - 1 {
            for j in i + 1 ..< count {
                
                print("i = \(i), j =\(j)")
                let price = prices[j] - prices[i]
                
                if price > max {
                    max = price
                }
            }
        }
        
        return max
    }
    
    /// 一次遍历
    /// 时间复杂度：O(n)。
    /// 空间复杂度：O(1)。
    /// 时间 664 ms  击败 93.99%
    /// 内存 17.7 MB 击败 35.62%
    func maxProfit1(_ prices: [Int]) -> Int {
        var minprice = prices[0], profit = 0
        let count = prices.count
        
        for i in 1 ..< count {
            let price = prices[i]
            if minprice > price {
                minprice = price
            } else {
                profit = max(price - minprice, profit)
            }
        }
        return profit
    }
}
