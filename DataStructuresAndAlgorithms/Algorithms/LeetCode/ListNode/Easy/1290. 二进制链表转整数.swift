//
//  1290. 二进制链表转整数.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/24.
//

/*
 
 https://leetcode.cn/problems/convert-binary-number-in-a-linked-list-to-integer/
 
 给你一个单链表的引用结点 head。链表中每个结点的值不是 0 就是 1。已知此链表是一个整数数字的二进制表示形式。

 请你返回该链表所表示数字的 十进制值 。
 
 */

import Foundation

extension Algorithm {
	
	static func test1290() {
		let head = ListNode.getListNode([1,0,0,1,0,0,1,1,1,0,0,0,0,0,0])
		let result = Solution().getDecimalValue3(head)
		print(result)
	}
}

extension Solution {
	
	/// 方法一：反转链表➕然后累加
	///
	/// 思路
	///	先反转链表，然后遍历累加得到结果
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。会遍历两遍链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 4 ms 击败 66.67%
	/// 内存 14.1 MB 击败 16.67%
	func getDecimalValue(_ head: ListNode?) -> Int {

		var cur = reverseList(head)
		var result: Decimal = 0
		var index = 0
		
		while cur != nil {
			result += cur?.val == 1 ? pow(2, index) : 0
			index += 1
			cur = cur?.next
		}
		
		return NSDecimalNumber(decimal: result).intValue
	}
	
	/// 方法二：二进制反推
	///
	/// 思路
	///	由于链表中从高位到低位存放了数字的二进制表示，因此我们可以使用二进制转十进制的方法，在遍历一遍链表的同时得到数字的十进制值。
	///	5÷2=2余1
	///	2÷2=1余0
	///	1÷2=0余1
	///	===> 得出二进制 101，反推回去 商 x 除数 + 余数
	///	=> 0 x 2 + 1 = 1
	///	=> 1 x 2 + 0 = 2
	///	=> 2 x 2 + 1 = 5
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 4 ms 击败 66.67%
	/// 内存 13.8 MB 击败 50%
	func getDecimalValue2(_ head: ListNode?) -> Int {

		var cur = head
		var result = 0
		
		while cur != nil {
			result = result * 2 + (cur?.val ?? 0)
			cur = cur?.next
		}
		
		return result
	}
	
	/// 方法三：纯二进制运算
	///
	/// 思路
	///	由于链表中从高位到低位存放了数字的二进制表示，因此我们可以使用二进制转十进制的方法，在遍历一遍链表的同时得到数字的十进制值。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 16.67%
	/// 内存 13.7 MB 击败 100%
	func getDecimalValue3(_ head: ListNode?) -> Int {

		var cur = head
		var result = 0
		
		while cur != nil {
			// * 2
			result = result << 1
			// 向左移位后，最低位一定为0，所以可以用 或运算 和 最低位 做加法，因为不存在进位的情况下，或运算可以用作二进制的加法
			// 二进制的或运算，相当于 result = result | head.val
			result |= cur?.val ?? 0
			cur = cur?.next
		}
		
		return result
	}
}
