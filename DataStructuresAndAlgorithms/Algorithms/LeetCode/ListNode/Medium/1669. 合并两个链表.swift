//
//  1669. 合并两个链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/7/14.
//

/*
 
 https://leetcode.cn/problems/merge-in-between-linked-lists/
 
 给你两个链表 list1 和 list2 ，它们包含的元素分别为 n 个和 m 个。

 请你将 list1 中下标从 a 到 b 的全部节点都删除，并将list2 接在被删除节点的位置。
 
 提示：

 3 <= list1.length <= 104
 1 <= a <= b < list1.length - 1
 1 <= list2.length <= 104
 
 */

import Foundation

extension Solution {
	
	/// 方法一：模拟
	///
	/// 复杂度分析
	/// 时间复杂度：O(n+m)，其中 n 是list1的长度，m 是list2的长度。需要遍历链表两次，得到链表的长度和分隔链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 792 ms 击败 40%
	/// 内存 18.46 MB 击败 60%
	func mergeInBetween(
		_ list1: ListNode?,
		_ a: Int,
		_ b: Int,
		_ list2: ListNode?
	) -> ListNode? {
		
		var cur = list1
		var index = 0
		
		var head: ListNode? = nil
		var tail: ListNode? = nil
		
		while cur != nil {
			
			if index == a - 1 {
				head = cur
			}
			
			if index == b {
				tail = cur
			}
			
			index += 1
			cur = cur?.next
		}
		
		cur = list2
				
		while cur?.next != nil {
			cur = cur?.next
		}
		
		/*
		 
		 原始方式
			这样更有利于内存回收
			但是leetcode时间过长
		 
		 原始结果
		 时间 948 ms 击败 N/A
		 内存 18.59 MB 击败 40%
		  
		 let next = tail?.next
		 tail?.next = nil
		 
		 head?.next = list2
		 cur?.next = next
		 
		 */
		
		head?.next = list2
		cur?.next = tail?.next
		
		return list1
	}
	
	/// 方法二：模拟 时间最优法
	///
	/// 复杂度分析
	/// 时间复杂度：O(n+m)，其中 n 是list1的长度，m 是list2的长度。需要遍历链表两次，得到链表的长度和分隔链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 704 ms 击败 80%
	/// 内存 18.51 MB 击败 60%
	func mergeInBetween2(
		_ list1: ListNode?,
		_ a: Int,
		_ b: Int,
		_ list2: ListNode?
	) -> ListNode? {
		
		var cur = list1
		var index = 0
		
		var head: ListNode? = nil
		var tail: ListNode? = nil
		
		while cur != nil {
			
			if index == a - 1 {
				head = cur
			}
			
			if index == b + 1 {
				tail = cur
				break
			}
			
			index += 1
			cur = cur?.next
		}
		
		cur = list2
				
		while cur?.next != nil {
			cur = cur?.next
		}
		
		head?.next = list2
		cur?.next = tail
		
		return list1
	}
}
