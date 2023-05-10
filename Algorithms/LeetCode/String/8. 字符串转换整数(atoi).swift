//
//  8. 字符串转换整数(atoi).swift
//  Algorithms
//
//  Created by Leo on 2023/5/8.
//

/*
 
 https://leetcode.cn/problems/string-to-integer-atoi/
 
 */

import Foundation

extension Solution {
	
	/// 方法一：自动机
	///
	///	复杂度分析
	///	时间复杂度：时间复杂度：O(n)，其中 n 为字符串的长度。我们只需要依次处理所有的字符，处理每个字符需要的时间为 O(1)。
	///	空间复杂度：O(1)。自动机的状态只需要常数空间存储。
	///
	///	结果
	/// 时间 12 ms 击败 21.52%
	/// 内存 14.4 MB 击败 20.25%
	func myAtoi(_ s: String) -> Int {
		let automaton = Automaton()
		
		for c in s {
			automaton.check(c)
		}
			
		let res = automaton.sign * automaton.ans
		
		if automaton.sign == -1 && res < Int32.min {
			return Int(Int32.min)
		} else if automaton.sign == 1 && res > Int32.max {
			return Int(Int32.max)
		}
		
		return res
	}
	
}

class Automaton {
	
	//! 符号，表示正数 或者 负数
	var sign = 1
	//! 结果
	var ans = 0
	
	private var state = "start"
	
	private var table =  [
		"start": ["start", "signed", "in_number", "end"],
		"signed": ["end", "end", "in_number", "end"],
		"in_number": ["end", "end", "in_number", "end"],
		"end": ["end", "end", "end", "end"]
	]
  
	func check(_ char: Character) {
		
		guard let tmp = table[state] else { return }
		
		state = tmp[getStatus(char)]
		
		if state == "in_number" {
			if ans > Int32.max || ans < Int32.min {
				state = "end"
				return
			}
			
			let str = String(char)
			let c = Int(str)!
			
			ans = ans * 10 + c
		} else if state == "signed" {
			sign = char == "+" ? 1 : -1
		}
	}
  
	private func getStatus(_ c: Character) -> Int {
		if c == " " {
			return 0
		}
		
		if c == "+" || c == "-" {
			return 1
		}
	  
		if c.isNumber {
			return 2
		}
		
		return 3
	}
}
