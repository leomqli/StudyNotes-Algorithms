//
//  剑指 Offer 21. 调整数组顺序使奇数位于偶数前面.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/4.
//
//  https://leetcode.cn/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof
//  输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数在数组的前半部分，所有偶数在数组的后半部分。
//

import Foundation

extension Solution {
	
	func exchange(_ nums: [Int]) -> [Int] {
		print(exchange1(nums))
		return []
	}
	
	/// 方法一：一次遍历
	///
	/// 思路
	///	遍历数组，将奇数和偶数挑选出来，存入新的数组，然后将两个数组合并
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该数组的长度。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 124 ms 击败 90.28%
	/// 内存 17.4 MB 击败 13.89%
	func exchange1(_ nums: [Int]) -> [Int] {
		
		var odds = [Int]()
		var evens = [Int]()
		
		nums.forEach {
			if $0 % 2 == 0 {
				evens.append($0)
			} else {
				odds.append($0)
			}
		}
		
		return odds + evens
	}
	
	/// 方法二：两次遍历
	/// 
	/// 思路
	///	新建一个数组 res 用来保存调整完成的数组。遍历两次 nums，第一次遍历时把所有奇数依次追加到 res 中，第二次遍历时把所有偶数依次追加到 res 中。
	///
	///	复杂度分析
	///	时间复杂度：O(n)，其中 n 为数组 nums 的长度。需遍历 nums 两次。
	///	空间复杂度：O(1)。结果不计入空间复杂度。
	///
	///	结果
	/// 时间 172 ms 击败 20.83%
	/// 内存 17.6 MB 击败 5.55%
	func exchange2(_ nums: [Int]) -> [Int] {
		
		var result = [Int]()
		
		nums.forEach {
			if $0 % 2 != 0 {
				result.append($0)
			}
		}
		
		nums.forEach {
			if $0 % 2 == 0 {
				result.append($0)
			}
		}
		
		return result
	}
	
	/// 方法三：双指针 + 一次遍历
	///
	/// 思路
	///	记数组 nums 的长度为 n。方法二需要遍历两次 nums，第一次遍历时遇到偶数会跳过，第二次遍历时遇到奇数会跳过，这部分可以优化。
	///	新建一个长度为 n 的数组 res 用来保存调整完成的数组。遍历一遍 nums，遇到奇数则从 res 左侧开始替换元素，遇到偶数则从 res 右侧开始替换元素。遍历完成后，res 就保存了调整完成的数组。
	///
	///	复杂度分析
	///	时间复杂度：O(n)，其中 n 为数组 nums 的长度。只需遍历 nums 一次。
	///	空间复杂度：O(1)。结果不计入空间复杂度。
	///
	///	结果
	/// 时间 128 ms 击败 56.94%
	/// 内存 17.1 MB 击败 38.89%
	func exchange3(_ nums: [Int]) -> [Int] {
				
		var result = [Int](repeating: 0, count: nums.count)
		var lP = 0
		var rP = result.count - 1
		
		for num in nums {
			if num % 2 != 0 {
				result[lP] = num
				lP += 1
			} else {
				result[rP] = num
				rP -= 1
			}
		}
		
		return result
	}
	
	/// 方法四：原地交换
	///
	///	思路
	///	记数组 nums 的长度为 n。
	///	先从 nums 左侧开始遍历，如果遇到的是奇数，就表示这个元素已经调整完成了，继续从左往右遍历，直到遇到一个偶数。
	///	然后从 nums 右侧开始遍历，如果遇到的是偶数，就表示这个元素已经调整完成了，继续从右往左遍历，直到遇到一个奇数。
	///	交换这个偶数和奇数的位置，并且重复两边的遍历，直到在中间相遇，nums 调整完成。
	///
	///	复杂度分析
	///	时间复杂度：O(n)，其中 n 为数组 nums 的长度。只需遍历 nums 一次。
	///	空间复杂度：O(1)。结果不计入空间复杂度。
	///
	///	结果
	/// 时间 128 ms 击败 56.94%
	/// 内存 17.1 MB 击败 41.67%
	func exchange4(_ nums: [Int]) -> [Int] {
		
		var result = nums
		var left = 0
		var right = result.count - 1
		
		while left < right {
			
			while left < right && result[left] % 2 == 1 {
				left += 1
			}
			
			while left < right && result[right] % 2 == 0 {
				right -= 1
			}
			
			if left < right {
				let tmp = result[left]
				result[left] = result[right]
				result[right] = tmp
				left += 1
				right -= 1
			}
		}
		
		return result
	}
	
}
