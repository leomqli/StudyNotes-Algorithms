//
//  92. 反转链表 II.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/13.
//

import Foundation

/*
 
 https://leetcode.cn/problems/reverse-linked-list-ii/description
 
 给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
 
 */

extension Algorithm {
	
	static func test92() {
		let l1 = ListNode.getListNode([1,2,3,4,5])
//		let result = Solution().reverseBetween1(l1, 1, 3)
		let result = Solution().reverseBetween2(l1, 2, 4)
		print(ListNode.getResult(result))
	}
}

extension Solution {
		
	/// 方法一：迭代
	///
	/// 思路
	/// 在遍历链表时，找到 left 节点的上一节点（l1）、left 节点（l2）和 right 节点（r）。然后 反转 l2 到 r 节点的链表，最后将节点拼接起来即可。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表两次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 4 ms 击败 77.78%
	/// 内存 13.7 MB 击败 76.19%
	func reverseBetween1(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
		
		var index = 1
		var cur = head
		
		var l1: ListNode? = nil
		var l2: ListNode? = nil
		var r: ListNode? = nil
		
		while cur != nil {
			
			if index == left - 1 {
				l1 = cur
			}
			
			if index == left {
				l2 = cur
			}
			
			if index == right {
				r = cur?.next
			}
			
			index += 1
			cur = cur?.next
		}
		
		var pre: ListNode? = nil
		
		cur = l2
		
		while cur != r {
			let tmp = cur?.next
			cur?.next = pre
			pre = cur
			cur = tmp
		}
		
		if l1 == nil {
			if r != nil {
				l2?.next = r
			}
			return pre
		} else {
			l1?.next = pre
			l2?.next = r
			return head
		}
	}
	
	/// 方法二：迭代的优化
	///
	/// 思路
	/// 在方法一上的优化
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表两次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 4 ms 击败 78.46%
	/// 内存 13.5 MB 击败 100%
	func reverseBetween2(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
		
		let dummyNode = ListNode(-1)
		dummyNode.next = head
		
		// 前驱节点
		var pre: ListNode? = dummyNode
		
		for _ in 0 ..< left - 1 {
			pre = pre?.next
		}
		
		// 左节点
		let leftNode = pre?.next
		
		// 右节点
		var rightNode: ListNode? = pre
		
		for _ in 0 ..< right - left + 1 {
			rightNode = rightNode?.next
		}
		
		// 后继节点
		let succ = rightNode?.next
		
		// 断开前驱与后继节点的连接
		pre?.next = nil
		rightNode?.next = nil
				
		// 反转 left ——> right 的节点
		var tmpH: ListNode? = nil
		var tmpL: ListNode? = leftNode
		
		while tmpL != nil {
			let next = tmpL?.next
			tmpL?.next = tmpH
			tmpH = tmpL
			tmpL = next
		}
		
		// 重连前驱和后继节点
		pre?.next = rightNode
		leftNode?.next = succ
		
		return dummyNode.next
	}
	
	/// 方法三：一次遍历「穿针引线」反转链表（头插法）
	///
	/// 思路
	/// 方法一的缺点是：如果 left 和 right 的区域很大，恰好是链表的头节点和尾节点时，找到 left 和 right 需要遍历一次，反转它们之间的链表还需要遍历一次，虽然总的时间复杂度为 O(N)，但遍历了链表 2 次。
	/// 在需要反转的区间里，每遍历到一个节点，让这个新节点来到反转部分的起始位置。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表两次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 10.77%
	/// 内存 13.6 MB 击败 98.46%
	func reverseBetween3(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
		
		let dummyNode = ListNode(-1)
		dummyNode.next = head
		
		var pre: ListNode? = dummyNode
		
		for _ in 0 ..< left - 1 {
			pre = pre?.next
		}
		
		let cur = pre?.next
		var next: ListNode? = nil
		
		for _ in 0 ..< right - left {
			next = cur?.next
			cur?.next = next?.next
			next?.next = pre?.next
			pre?.next = next
		}
		
		return dummyNode.next
	}
}
