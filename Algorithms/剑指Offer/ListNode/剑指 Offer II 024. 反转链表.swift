//
//  剑指 Offer II 024. 反转链表.swift
//  Algorithms
//
//  Created by Leo on 2023/5/25.
//

/*
 
 https://leetcode.cn/problems/UHnkqh/

 进阶：链表可以选用迭代或递归方式完成反转。你能否用两种方法解决这道题？

 注意：本题与主站 206 题相同： https://leetcode-cn.com/problems/reverse-linked-list/
 
 */

import Foundation

extension Solution {
	
	/// 方法一：迭代
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表一次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 100%
	/// 内存 14.7 MB 击败 27.27%
	func reverseList3(_ head: ListNode?) -> ListNode? {
		
		var pre: ListNode? = nil
		var cur = head
		
		while cur != nil {
			let next = cur?.next
			cur?.next = pre
			pre = cur
			cur = next
		}
		
		return pre
	}
	
	/// 方法二：递归
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表一次。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 16 ms 击败 20.45%
	/// 内存 14.6 MB 击败 31.82%
	func reverseList4(_ head: ListNode?) -> ListNode? {
		return recursiveMethod2(nil, cur: head)
	}
	
	func recursiveMethod2(_ pre: ListNode?, cur: ListNode?) -> ListNode? {
		guard cur != nil else { return pre }
		let next = cur?.next
		cur?.next = pre
		return recursiveMethod2(cur, cur: next)
	}
	
}
