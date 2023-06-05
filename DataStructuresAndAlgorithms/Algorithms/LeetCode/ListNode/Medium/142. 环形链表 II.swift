//
//  142. 环形链表 II.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/5.
//

import Foundation

/*
 
 https://leetcode.cn/problems/linked-list-cycle-ii/
 
 给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。

 不允许修改 链表。
 
 进阶：你是否可以使用 O(1) 空间解决此题？
 
 */

extension Solution {
	
	///	方法一：哈希表缓存
	///
	///	思路
	///	使用哈希表缓存所有的节点，当遇到重复的时候，说明有循环链表，返回即可。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 44 ms 击败 37.12%
	/// 内存 15.6 MB 击败 5.30%
	func detectCycle(_ head: ListNode?) -> ListNode? {
		
		var set = Set<ListNode>()
		var cur = head
		
		while cur != nil && !set.contains(cur!) {
			set.insert(cur!)
			cur = cur?.next
		}
		
		return cur
	}
		
	///	方法二：快慢指针
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 44 ms 击败 37.12%
	/// 内存 15 MB 击败 93.18%
	func detectCycle2(_ head: ListNode?) -> ListNode? {
		
		var fast = head
		var slow = head
		
		while fast != nil && fast?.next != nil {
			slow = slow?.next
			fast = fast?.next?.next
						
			if fast == slow {
				var target = head
				
				while target != slow {
					target = target?.next
					slow = slow?.next
				}
				
				return target
			}
		}
				
		return nil
	}
	
}
