//
//  504. 七进制数.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/7.
//

/*
 
 https://leetcode.cn/problems/base-7/description/
 
 给定一个整数 num，将其转化为 7 进制，并以字符串形式输出。

 示例 1:
 输入: num = 100
 输出: "202"
 
 示例 2:
 输入: num = -7
 输出: "-10"
  

 提示：
 -10^7 <= num <= 10^7
 
 */

import Foundation

extension Algorithm {
	static func test504() {
		let num = 100
		print(Solution().convertToBase73(num))
	}
}

extension Solution {
	
	/// 方法一：栈
	///
	///	时间复杂度：O(n)。
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 0 ms   击败 100%
	/// 内存 13.2 MB 击败 83.33%
	func convertToBase7(_ num: Int) -> String {
		
		if num == 0 { return "0" }
		
		let isNegativeNum = num < 0
		
		var tmp = isNegativeNum ? num * -1 : num
		
		var stack = Stack<Int>()
		
		while tmp != 0 {
			stack.push(tmp%7)
			tmp /= 7
		}
		
		var res = isNegativeNum ? "-" : ""
		
		while !stack.isEmpty {
			if let num = stack.pop() {
				res.append("\(num)")
			}
		}
		
		return res
	}
	
	/// 方法二：递归
	///
	///	时间复杂度：O(n)。
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 0 ms   击败 100%
	/// 内存 13.17 MB 击败 83.33%
	func convertToBase72(_ num: Int) -> String {
		if num == 0 {
			return "0"
		} else if num < 0 {
			return "-\(convertToBase72(-num))"
		} else {
			var num = num
			var res = ""
			while num > 0 {
				res = "\(num % 7)" + res
				num /= 7
			}
			return res
		}
	}
	
	/// 方法三：迭代
	///
	///	时间复杂度：O(n)。
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 0 ms   击败 100%
	/// 内存 13.27 MB 击败 50%
	func convertToBase73(_ num: Int) -> String {
		
		var number = num < 0 ? -num : num
		var res = ""
		
		while number >= 7 {
			res.append("\(number % 7)")
			number = number / 7
		}
		
		res.append("\(number)")
	   
		if num < 0 {
			res.append("-")
		}
		
		return String(res.reversed())
	}
}
