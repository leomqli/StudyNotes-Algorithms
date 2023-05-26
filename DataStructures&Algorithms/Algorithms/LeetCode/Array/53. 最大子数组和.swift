//
//  53. 最大子数组和.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-23.
//
//  https://leetcode.cn/problems/maximum-subarray

extension Algorithm {
    static func test53() {
//        let nums = [1]
//        let nums = [-1, -2, 3, -1, -1]
//        let nums = [-2,1,-3,4,-1,2,1,-5,4]
//        let nums = [-2,1]
//        let nums = [-1,0,-2]
        let nums = [5,4,-1,7,8]
        print(Solution().maxSubArray(nums))
    }
}

extension Solution {
    
    /// 暴力穷举法（有问题）
    /// 将数组中的每个子数组都累加一遍，得到最大的和
    /// 时问复杂度：O(N^2)，只遍历N的平方次数组。
    /// 空间复杂度：O(1)，只使用了常数空问。
    func maxSubArray(_ nums: [Int]) -> Int {
        
        let length = nums.count - 1
        var maxSum = nums[0]

        for i in 0 ... length {
            
            var curSum: Int?

            if i == length {
                maxSum = max(nums[i], maxSum)
                continue
            }
            
            for j in i ... length {
                if curSum == nil {
                    curSum = nums[j]
                } else {
                    curSum = curSum! + nums[j]
                }
                
                maxSum = max(curSum!, maxSum)
            }
        }

        return maxSum
    }
    
    /// 贪心算法
    /// 核心：若当前指针所指元素之前的和小于 0，则丟弃当前元素之前的数列
    /// 时问复杂度：O(N)，只遍历一次数组。   时间 628 ms  击败 89.92%
    /// 空间复杂度：O(1)，只使用了常数空问。 内存 18.1 MB 击败 70.97%
    func maxSubArray1(_ nums: [Int]) -> Int {
        let lenth = nums.count
        var curSum = 0, maxSum = nums[0]
        
        for i in 1 ..< lenth {
            curSum = max(nums[i], curSum + nums[i])
            maxSum = max(curSum, maxSum)
        }
        
        return maxSum
    }
}
