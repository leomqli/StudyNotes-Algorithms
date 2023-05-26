//
//  1. 两数之和.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-10.
//
//  https://leetcode.cn/problems/two-sum/solutions/

extension Algorithm {
    static func test1() {
        let nums = [3,2,4], target = 6
//        let nums = [2,7,11,15], target = 9
       
        print(Solution().twoSum1(nums, target))
    }
}

extension Solution {
    
    /// 方法一：暴力遍历法
	///
	/// 复杂度分析
    /// 时问复杂度：O(N^2)，只遍历N的平方次数组。
    /// 空间复杂度：O(1)，只使用了常数空问。
	///
	///	结果
	/// 时间 60 ms  击败 35.54%
	/// 内存 14 MB 击败 91.52%
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {

        guard nums.count > 2 else { return [0, 1] }
        
        var a = 0

        while a < nums.count {
            var b = a + 1
            
            print("a == \(a)")
            while b < nums.count {
                print("b == \(b)")
                if (nums[a] + nums[b] == target) {
                    return [a, b]
                }
                b += 1
            }
            a += 1
        }
        
        return []
    }
    
    /// 方法二：哈希表
	///
	/// 思路
	///
	///
	///	复杂度分析
    /// 时间复杂度：O(N)，其中 N 是数组中的元素数量。
    ///                对于每一个元素 x，我们可以 O(1) 地寻找 target - x。
    /// 空间复杂度：O(N)，其中 N 是数组中的元素数量。主要为哈希表的开销。
	///
	///	结果
	/// 时间 36 ms  击败 94.46%
	/// 内存 14.1MB 击败 73.48%
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()

        for (index, value) in nums.enumerated() {
            if let result = map[target - value] {
                return [result, index]
            } else {
                map[value] = index
            }
        }
        
        return []
    }
}
