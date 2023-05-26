//
//  剑指 Offer 57. 和为s的两个数字.swift
//  Algorithms
//
//  Created by Leo on 2023/5/4.
//
//  https://leetcode.cn/problems/he-wei-sde-liang-ge-shu-zi-lcof
//  输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。
//  与 LeetCode/Array/1. 两数之和.swift 相似

import Foundation

extension Solution {
	
	/// 方法一：使用字典缓存差
	///
	/// 思路
	///	遍历数组，判断 target 与 num 的差是否存在，不存在则保存至 dic 中
	///
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该数组的长度。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 124 ms 击败 90.28%
	/// 内存 17.4 MB 击败 13.89%
	func twoSum3(_ nums: [Int], _ target: Int) -> [Int] {
		
		var dic = [Int: Int]()
		
		for num in nums {
			let difference = target - num
			
			if dic[difference] != nil {
				return [difference, num]
			} else {
				dic[num] = difference
			}
		}
		
		return []
	}
	
	/// 方法二：双指针
	///
	/// 思路
	///	既然是递增数组，那么我们可以利用双指针来做这道题。
	///		1. 指针 i 指向数组首位数字，指针 j 指向数组末位数字。
	///		2. 若两数字之和大于了 target，则指针 j 往左移一位。
	///		3. 若两数字之和小于了 target，则指针 i 往右移一位。
	///		4. 若两数字之和等于了 target，返回结果 [i,j] 即可。
	///
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该数组的长度。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 1492 ms 击败 7.14%
	/// 内存 18.5 MB MB 击败 83.33%
	func twoSum4(_ nums: [Int], _ target: Int) -> [Int] {
		
		var left = 0
		var right = nums.count - 1
		
		while left < right {
			let sum = nums[left] + nums[right]
			
			if sum > target {
				right -= 1
			} else if sum < target {
				left += 1
			} else {
				return [nums[left], nums[right]]
			}
		}
		
		return []
	}
}
