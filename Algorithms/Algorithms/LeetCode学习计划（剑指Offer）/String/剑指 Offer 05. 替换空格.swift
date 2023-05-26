//
//  剑指 Offer 05. 替换空格.swift
//  Algorithms
//
//  Created by Leo on 2023/5/5.
//

import Foundation

/*
 
 https://leetcode.cn/problems/ti-huan-kong-ge-lcof
 
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

 示例 1：
 输入：s = "We are happy."
 输出："We%20are%20happy."
  

 限制：
 0 <= s 的长度 <= 10000
 
 */


extension Solution {
	
	/// 方法一：系统函数
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 0 ms 击败 100%
	/// 内存 14.8 MB 击败 13.29%
	func replaceSpace1(_ s: String) -> String {
		return s.replacingOccurrences(of: " ", with: "%20")
	}
	
	/// 方法二：遍历替换
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 4 ms 击败 68.53%
	/// 内存 13.9 MB 击败 79.72%
	func replaceSpace2(_ s: String) -> String {
		var res = ""
		
		s.forEach {
			res += $0 == " " ? "%20" : String($0)
		}
		
		return res
	}
	
	/// 方法三：系统 Reduce 函数
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 4 ms 击败 68.53%
	/// 内存 14 MB 击败 46.15%
	func replaceSpace3(_ s: String) -> String {
		return s.reduce("") { res, char in
			if char == " " {
				return res + "%20"
			} else {
				return res + String(char)
			}
		}
	}
	
	/// 方法四：双指针
	///
	///	复杂度分析
	///	时间复杂度：O(n)。
	///	空间复杂度：O(n)。
	///
	///	结果
	/// 时间 4 ms 击败 68.53%
	/// 内存 14.1 MB 击败 36.36%
	func replaceSpace4(_ s: String) -> String {
		
		var count = 0
		
		s.forEach {
			guard $0 == " " else { return }
			count += 1
		}
		
		var strs = Array(s)
		strs += [Character](repeating: "0", count: count * 2)
		
		var lP = s.count - 1
		var rP = strs.count - 1
		
		while lP < rP {
			if strs[lP] == " " {
				strs[rP] = "0"
				strs[rP - 1] = "2"
				strs[rP - 2] = "%"
				rP -= 2
			} else {
				strs[rP] = strs[lP]
			}
			
			lP -= 1
			rP -= 1
		}
		
		return String(strs)
	}
	
}
