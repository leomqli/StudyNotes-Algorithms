//
//  面试题 02.07. 链表相交.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/27.
//

/*
 
 https://leetcode.cn/problems/intersection-of-two-linked-lists-lcci/
 
 相同题目：
 160. 相交链表：https://leetcode.cn/problems/intersection-of-two-linked-lists/
 剑指 Offer II 023. 两个链表的第一个重合节点：https://leetcode.cn/problems/3u1WK4/
 
 进阶：你能否设计一个时间复杂度 O(n) 、仅用 O(1) 内存的解决方案？
 
 */

import Foundation


extension Solution {
	
	///	复杂度分析
	///	时间复杂度：O(m+n)，其中 m 和 n 是分别是链表 headA 和 headB的长度。
	///					两个指针同时遍历两个链表，每个指针遍历两个链表各一次。
	///	空间复杂度：O(1)。
	///
	///	结果（Java）
	/// 时间 1 ms 击败 97.62%
	/// 内存 45.5 MB 击败 5.10%
	func getIntersectionNode2(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
		
		var pA = headA
		var pB = headB
		
		while pA != pB {
			pA = pA == nil ? headB : pA?.next
			pB = pB == nil ? headA : pB?.next
		}
		
		return pA
	}
	
}
