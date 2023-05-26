//
//  剑指 Offer II 023. 两个链表的第一个重合节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/25.
//

/*
 
 https://leetcode.cn/problems/3u1WK4/
 
 进阶：能否设计一个时间复杂度 O(n) 、仅用 O(1) 内存的解决方案？
 
 注意：本题与主站 160 题相同：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/
 
 */

import Foundation

extension Solution {
	
	///	复杂度分析
	///	时间复杂度：O(m+n)，其中 m 和 n 是分别是链表 headA 和 headB 的长度。两个指针同时遍历两个链表，每个指针遍历两个链表各一次。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 204 ms 击败 77.78%
	/// 内存 16.5 MB 击败 33.33%
	func getIntersectionNode1(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
		
		guard headA != nil && headB != nil else { return nil }
		
		var m = headA
		var n = headB
		
		while m != n {
			m = m != nil ? m?.next : headB
			n = n != nil ? n?.next : headA
		}
		
		return m
	}
}

