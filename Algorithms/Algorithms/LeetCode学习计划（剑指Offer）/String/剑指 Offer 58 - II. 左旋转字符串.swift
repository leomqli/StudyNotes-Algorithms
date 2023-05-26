//
//  剑指 Offer 58 - II. 左旋转字符串.swift
//  Algorithms
//
//  Created by Leo on 2023/5/5.
//

import Foundation

/**
 
 https://leetcode.cn/problems/zuo-xuan-zhuan-zi-fu-chuan-lcof
 
 字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。

 示例 1：
 输入: s = "abcdefg", k = 2
 输出: "cdefgab"
 
 示例 2：
 输入: s = "lrloseumgh", k = 6
 输出: "umghlrlose"
  

 限制：
 1 <= k < s.length <= 10000
 
 */

extension Algorithm {
	static func testOffer58() {
		let s = "abcdefg"
		print(Solution().reverseLeftWords5(s, 2))
	}
}

extension Solution {
	
	/// 方法一：字符串切片
	///
	/// 思路
	/// 将字符串按照 n 位置切成两片，后拼接成新的结果
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 48 ms 击败 27.78%
	/// 内存 14.8 MB 击败 5.56%
	func reverseLeftWords1(_ s: String, _ n: Int) -> String {

		let strs = Array(s)
		let heads = strs[0 ..< n]
		let tails = strs[n ..< s.count]
		let result = tails + heads
		
		return String(result)
	}
	
	/// 方法二：列表遍历拼接
	///
	/// 思路
	///	遍历 s，将 n 位置前的字符串拼接至末尾，然后裁切
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 56 ms 击败 14.44%
	/// 内存 14.7 MB 击败 5.56%
	func reverseLeftWords2(_ s: String, _ n: Int) -> String {
		
		var strs: [Character] = Array(s)
		var index = 0
		
		while index < n {
			strs.append(strs[index])
			index += 1
		}
		
		let result = strs[n ..< strs.count]
		
		return String(result)
	}
	
	/// 方法三：列表遍历拼接（优化）
	///
	/// 思路
	///	遍历 s，将 n 位置前的字符串拼接至末尾
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 40 ms 击败 73.33%
	/// 内存 14.6 MB 击败 12.22%
	func reverseLeftWords3(_ s: String, _ n: Int) -> String {
		
		let strs: [Character] = Array(s)
		
		var res = [Character]()
		
		for c in n ..< s.count {
			res.append(strs[c])
		}
		
		for c in 0 ..< n {
			res.append(strs[c])
		}
		
		return String(res)
	}
	
	/// 方法四：列表遍历拼接（更加优化）
	///
	/// 思路
	///	遍历 s，利用求余运算，可将 n 位置前的字符串拼接至末尾
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 40 ms 击败 73.33%
	/// 内存 14.6 MB 击败 12.22%
	func reverseLeftWords4(_ s: String, _ n: Int) -> String {
		
		let strs: [Character] = Array(s)
		var res = [Character]()
		
		for c in n ..< n + s.count {
			res.append(strs[c % s.count])
		}
		
		return String(res)
	}
	
	/// 方法五：局部反转+整体反转
	///
	/// 思路
	///	1. 反转区间为前n的子串
	///	2. 反转区间为n到末尾的子串
	///	3. 反转整个字符串
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 44 ms 击败 47.78%
	/// 内存 14.6 MB 击败 14.45%
	func reverseLeftWords5(_ s: String, _ n: Int) -> String {
		
		var strs: [Character] = Array(s)
		
		reverseString(&strs, start: 0, end: n - 1)
		reverseString(&strs, start: n, end: s.count - 1)
		reverseString(&strs, start: 0, end: s.count - 1)
	
		return String(strs)
	}
	
	func reverseString(_ s: inout [Character], start: Int, end: Int) {
		
		var l = start, r = end
		
		while l < r {
			(s[l],s[r]) = (s[r], s[l])
			l += 1
			r -= 1
		}
	}
	
}
