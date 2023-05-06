//
//  剑指 Offer 20. 表示数值的字符串.swift
//  Algorithms
//
//  Created by Leo on 2023/5/6.
//

/*
 请实现一个函数用来判断字符串是否表示数值（包括整数和小数）。

 数值（按顺序）可以分成以下几个部分：

 若干空格
 一个 小数 或者 整数
 （可选）一个 'e' 或 'E' ，后面跟着一个 整数
 若干空格
 
 小数（按顺序）可以分成以下几个部分：
 （可选）一个符号字符（'+' 或 '-'）
 
 下述格式之一：
 至少一位数字，后面跟着一个点 '.'
 至少一位数字，后面跟着一个点 '.' ，后面再跟着至少一位数字
 一个点 '.' ，后面跟着至少一位数字
 
 整数（按顺序）可以分成以下几个部分：
 （可选）一个符号字符（'+' 或 '-'）
 至少一位数字
 
 部分数值列举如下：
 ["+100", "5e2", "-123", "3.1416", "-1E-16", "0123"]
 
 部分非数值列举如下：
 ["12e", "1a3.14", "1.2.3", "+-5", "12e+5.4"]
  
 示例 1：
 输入：s = "0"
 输出：true
 
 示例 2：
 输入：s = "e"
 输出：false
 
 示例 3：
 输入：s = "."
 输出：false
 
 示例 4：
 输入：s = "    .1  "
 输出：true
  
 提示：
 1 <= s.length <= 20
 s 仅含英文字母（大写和小写），数字（0-9），加号 '+' ，减号 '-' ，空格 ' ' 或者点 '.' 。
 */

import Foundation

extension Algorithm {
	static func testOffer20() {
		let test = ["+100", "5e2", "-123", "3.1416", "-1E-16", "0123", "12e", "1a3.14", "1.2.3", "+-5", "12e+5.4", "1 "]
		test.forEach {
			print(Solution().isNumber1($0))
		}
	}
}

extension Solution {
	
	/// 方法一：正则表达式
	///
	///	复杂度分析
	///	时间复杂度：O(N)。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 16 ms 击败 18.75%
	/// 内存 13.8 MB 击败 87.50%
	func isNumber1(_ s: String) -> Bool {
		
		guard let regex = try? NSRegularExpression(
			pattern: #"^ *([-\+]?\d+((\.\d+)?|\.?)|([-\+]?\.\d+))([Ee][\+-]?\d+)? *$"#,
			options: .caseInsensitive
		) else {
			return false
		}
		
		let results = regex.matches(
			in: s,
			options: [],
			range: NSMakeRange(0, s.count)
		)
		
		return !results.isEmpty
	}
	
	/// 方法二：确定有限状态自动机
	///
	/// https://leetcode.cn/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/solutions/372095/biao-shi-shu-zhi-de-zi-fu-chuan-by-leetcode-soluti/
	///
	/// 1、先定义自动机的【状态结合】
	/// 	1.1起始的空格/末尾的空格
	/// 	1.2符号位
	/// 	1.3整数部分
	/// 	1.4左侧有整数的小数点
	/// 	1.5左侧无整数的小树点
	/// 	1.6小数部分
	/// 	1.7字符e
	/// 	1.8指数部分的符号位
	/// 	1.9指数部分的整数部分
	/// 2、找出【初始状态】和【接受状态】的集合
	/// 3、定义【转移规则】
	///
	///	复杂度分析
	///	时间复杂度：O(n)，其中 n 为字符串的长度。我们需要遍历字符串的每个字符，其中状态转移所需的时间复杂度为 O(1)。
	///	空间复杂度：O(1)。只需要创建固定大小的状态转移表。
	///
	///	结果
	/// 时间 48 ms 击败 27.78%
	/// 内存 14.8 MB 击败 5.56%
	func isNumber2(_ s: String) -> Bool {

		var transfer = [State: [CharType: State]]()
		
		//开头可能是：空格，符号位，整数，小数点
		var initialMap = [CharType: State]()
		initialMap[.CHAR_SPACE] = .STATE_INITIAL
		initialMap[.CHAR_NUMBER] = .STATE_INTEGER
		initialMap[.CHAR_POINT] = .STATE_POINT_WITHOUT_INT
		initialMap[.CHAR_SIGN] = .STATE_INT_SIGN
		transfer[.STATE_INITIAL] = initialMap
		
		var intSignMap = [CharType: State]()
		intSignMap[.CHAR_NUMBER] = .STATE_INTEGER
		intSignMap[.CHAR_POINT] = .STATE_POINT_WITHOUT_INT
		transfer[.STATE_INT_SIGN] = intSignMap
		
		var integerMap = [CharType: State]()
		integerMap[.CHAR_NUMBER] = .STATE_INTEGER
		integerMap[.CHAR_POINT] = .STATE_POINT
		integerMap[.CHAR_EXP] = .STATE_EXP
		integerMap[.CHAR_SPACE] = .STATE_END
		transfer[.STATE_INTEGER] = integerMap
		
		var pointMap = [CharType: State]()
		pointMap[.CHAR_NUMBER] = .STATE_FRACTION
		pointMap[.CHAR_EXP] = .STATE_EXP
		pointMap[.CHAR_SPACE] = .STATE_END
		transfer[.STATE_POINT] = pointMap
		
		var pointWithoutIntMap = [CharType: State]()
		pointWithoutIntMap[.CHAR_NUMBER] = .STATE_FRACTION
		transfer[.STATE_POINT_WITHOUT_INT] = pointWithoutIntMap
		
		var fractionMap = [CharType: State]()
		fractionMap[.CHAR_NUMBER] = .STATE_FRACTION
		fractionMap[.CHAR_EXP] = .STATE_EXP
		fractionMap[.CHAR_SPACE] = .STATE_END
		transfer[.STATE_FRACTION] = fractionMap
		
		var expMap = [CharType: State]()
		expMap[.CHAR_NUMBER] = .STATE_EXP_NUMBER
		expMap[.CHAR_SIGN] = .STATE_EXP_SIGN
		transfer[.STATE_EXP] = expMap
		
		var expSignMap = [CharType: State]()
		expSignMap[.CHAR_NUMBER] = .STATE_EXP_NUMBER
		transfer[.STATE_EXP_SIGN] = expSignMap
		
		var expNumberMap = [CharType: State]()
		expNumberMap[.CHAR_NUMBER] = .STATE_EXP_NUMBER
		expNumberMap[.CHAR_SPACE] = .STATE_END
		transfer[.STATE_EXP_NUMBER] = expNumberMap
		
		var endMap = [CharType: State]()
		endMap[.CHAR_SPACE] = .STATE_END
		transfer[.STATE_END] = endMap
		
		var state: State = .STATE_INITIAL
		
		for item in s {
			let chatType: CharType = self.toCharType(item)
			if !(transfer[state]?.keys.contains(chatType) ?? false) {
				return false
			}else {
				state = transfer[state]![chatType]!
			}
		}
		return state == .STATE_INTEGER || state == .STATE_POINT || state == .STATE_FRACTION || state == .STATE_EXP_NUMBER || state == .STATE_END
	}
	
	func toCharType(_ ch: Character) -> CharType {
		if ch >= "0" && ch <= "9" {
			return .CHAR_NUMBER
		}
		else if ch == "e" || ch == "E" {
			return .CHAR_EXP
		}
		else if ch == "." {
			return .CHAR_POINT
		}
		else if ch == "+" || ch == "-" {
			return .CHAR_SIGN
		}
		else if ch == " " {
			return .CHAR_SPACE
		}
		else {
			return .CHAR_ILLEGAL
		}
	}
	
	enum State {
		case STATE_INITIAL
		case STATE_INT_SIGN
		case STATE_INTEGER
		case STATE_POINT
		case STATE_POINT_WITHOUT_INT
		case STATE_FRACTION
		case STATE_EXP
		case STATE_EXP_SIGN
		case STATE_EXP_NUMBER
		case STATE_END
	}
	
	enum CharType {
		case CHAR_NUMBER
		case CHAR_EXP
		case CHAR_POINT
		case CHAR_SIGN
		case CHAR_SPACE
		case CHAR_ILLEGAL
	}
}
