//
//  151. 反转字符串中的单词.swift
//  Algorithms
//
//  Created by Leo on 2023/5/4.
//

/**
 
 https://leetcode.cn/problems/reverse-words-in-a-string/
 
 给你一个字符串 s ，请你反转字符串中 单词 的顺序。

 单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。

 返回 单词 顺序颠倒且 单词 之间用单个空格连接的结果字符串。

 注意：输入字符串 s中可能会存在前导空格、尾随空格或者单词间的多个空格。返回的结果字符串中，单词间应当仅用单个空格分隔，且不包含任何额外的空格。

 示例 1：

 输入：s = "the sky is blue"
 输出："blue is sky the"
 示例 2：

 输入：s = "  hello world  "
 输出："world hello"
 解释：反转后的字符串中不能存在前导空格和尾随空格。
 示例 3：

 输入：s = "a good   example"
 输出："example good a"
 解释：如果两个单词间有多余的空格，反转后的字符串需要将单词间的空格减少到仅有一个。
 
 */

import Foundation

extension Solution {
	
	/// 方法一：使用系统函数
	///
	/// 思路
	/// 将字符串按照空格切割，然后在进行组合
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是输入字符串的长度。
	///	空间复杂度：O(n)。
	///
	///	结果
	///	时间 36 ms 击败 97.44%（剑指 Offer）
	/// 内存 14.3 MB 击败 74.36%（剑指 Offer）
	///
	/// 时间 20 ms 击败 87.34%
	/// 内存 14.1 MB 击败 77.22%
	func reverseWords(_ s: String) -> String {
		
		var result = ""
		
		let array = s.split(separator: " ").reversed()
		
		array.enumerated().forEach { (index, value) in
			let tmp = index != array.count - 1 ? " " : ""
			result += String(value) + tmp
		}
		
		return result
	}
	
	/// 方法二：自行编写对应的函数
	///
	/// 思路
	///	1. 移除多余空格
	///	2. 将整个字符串反转
	///	3. 将每个单词反转
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是输入字符串的长度。
	///	空间复杂度：O(1)。
	///
	///	结果
	///	时间 32 ms 击败 36.71%
	/// 内存 14.3 MB 击败 45.57%
	func reverseWords2(_ s: String) -> String {
		var stringArr = removeSpace(s)
		reverseString(&stringArr, startIndex: 0, endIndex: stringArr.count - 1)
		reverseWord(&stringArr)
		return String(stringArr)
	}

	/// 1、移除多余的空格（前后所有的空格，中间只留一个空格）
	func removeSpace(_ s: String) -> [Character] {
		let ch = Array(s)
		var left = 0
		var right = ch.count - 1
		// 忽略字符串前面的所有空格
		while ch[left] == " " {
			left += 1
		}
		// 忽略字符串后面的所有空格
		while ch[right] == " " {
			right -= 1
		}

		// 接下来就是要处理中间的多余空格
		var lastArr = Array<Character>()
		while left <= right {
			// 准备加到新字符串当中的字符
			let char = ch[left]
			// 新的字符串的最后一个字符；或者原字符串中，准备加到新字符串的那个字符；这两个字符当中，只要有一个不是空格，就可以加到新的字符串当中
			if char != " " || lastArr[lastArr.count - 1] != " "  {
				lastArr.append(char)
			}
		  
			left += 1
		}
		return lastArr
	}

	/// 2、反转整个字符串
	func reverseString(_ s: inout [Character], startIndex: Int, endIndex: Int)  {
		var start = startIndex
		var end = endIndex
		while start < end {
			(s[start], s[end]) = (s[end], s[start])
			start += 1
			end -= 1
		}
	}

	/// 3、再次将字符串里面的单词反转
	func reverseWord(_ s: inout [Character]) {
		var start = 0
		var end = 0
		var entry = false

		for i in 0..<s.count {
			if !entry {
				start = i
				entry = true
			}
		  
			if entry && s[i] == " " && s[i - 1] != " " {
				end = i - 1
				entry = false
				reverseString(&s, startIndex: start, endIndex: end)
			}

			if entry && (i == s.count - 1) && s[i] != " " {
				end = i
				entry = false
				reverseString(&s, startIndex: start, endIndex: end)
			}
		}
	}
}
