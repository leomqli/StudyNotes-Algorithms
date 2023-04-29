//
//  剑指 Offer 18. 删除链表的节点.swift
//  Algorithms
//
//  Created by Leo on 2023/4/28.
//
//	给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。
// 	返回删除后的链表的头节点。

import Foundation

extension Solution {
	
	/// 方法一：双指针
	///
	/// 思路
	/// 1. 通过双指针（pre、cur）遍历链表，当cur的值与给定的值相同时，将cur节点的前一节点指向后一节点
	/// 2. 注意头节点和尾节点
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(1)，只创建了3个指针。
	///
	///	结果
	/// 时间 12 ms 击败 97.6%
	/// 内存 13.9 MB 击败 80.88%
	func deleteNode1(_ head: ListNode?, _ val: Int) -> ListNode? {
		
		var pre: ListNode? = nil
		var cur = head
		var res = head
		
		while cur != nil {
			if cur?.val == val {
				if pre == nil {
					// 头节点
					res = cur?.next
					cur?.next = nil
				} else if cur?.next == nil {
					// 尾节点
					pre?.next = nil
				} else {
					pre?.next = cur?.next
					cur?.next = nil
				}
				
				return res
			}
			
			pre = cur
			cur = cur?.next
		}
		
		return res
	}
	
	/// 方法二：双指针
	///
	/// 思路
	/// 1. 先判断头节点
	/// 2. 再用两个指针从第二个基点开始遍历
	/// 3. 如果遍历结束，next 有值，则直接删除此节点
	///
	///	结果
	/// 时间 12 ms 击败 97.6%
	/// 内存 13.9 MB 击败 80.88%
	func deleteNode2(_ head: ListNode?, _ val: Int) -> ListNode? {
		
		// 头节点
		guard head?.val != val else {
			let res = head?.next
			head?.next = nil
			return res
		}
		
		var cur = head
		var next = head?.next
		let res = head
		
		while next != nil && next?.val != val {
			cur = next
			next = next?.next
		}
		
		if next != nil {
			cur?.next = next?.next
			next?.next = nil
		}
		
		return res
	}
}
