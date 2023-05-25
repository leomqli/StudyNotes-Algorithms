//
//  剑指 Offer 67. 把字符串转换成整数.swift
//  Algorithms
//
//  Created by Leo on 2023/5/8.
//

/*
 
 https://leetcode.cn/problems/ba-zi-fu-chuan-zhuan-huan-cheng-zheng-shu-lcof
 
 与 LeetCode/String/8. 字符串转换整数(atoi).swift 是同一道题目，这里省略
 
 */

import Foundation

extension Solution {
	
	///	结果
	/// 时间 8 ms 击败 72.73%
	/// 内存 14.2 MB 击败 45.45%
	func strToInt(_ str: String) -> Int {
		return myAtoi(str)
	}
}
