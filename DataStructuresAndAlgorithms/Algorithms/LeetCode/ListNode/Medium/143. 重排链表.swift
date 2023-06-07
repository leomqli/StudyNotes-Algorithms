//
//  143. 重排链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/7.
//

/*
 
 https://leetcode.cn/problems/reorder-list/

 给定一个单链表 L 的头节点 head ，单链表 L 表示为：
 L0 → L1 → … → Ln - 1 → Ln
 
 请将其重新排列后变为：
 L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
 
 不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
 
 */

import Foundation

extension Algorithm {
	static func test143() {
		let head = ListNode.getListNode([1,2,3,4,5])
		Solution().reorderList2(head)
		print(ListNode.getResult(head))
	}
}

extension Solution {
	
	/// 方法一：线性表
	///
	///	思路
	///	因为链表不支持下标访问，所以我们无法随机访问链表中任意位置的元素。
	///	因此比较容易想到的一个方法是，我们利用线性表存储该链表，然后利用线性表可以下标访问的特点，直接按顺序访问指定元素，重建该链表即可。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 60 ms 击败 75.47%
	/// 内存 18.8 MB 击败 83.2%
	func reorderList(_ head: ListNode?) {
		
		var list = [ListNode?]()
		var cur = head
		
		while cur != nil {
			list.append(cur)
			cur = cur?.next
		}
		
		var l = 0
		var r = list.count - 1
		
		while l < r {
			list[l]?.next = list[r]
			l += 1
			
			if l == r { break }
			
			list[r]?.next = list[l]
			r -= 1
		}
		
		list[l]?.next = nil
	}
	
	/// 方法二：寻找链表中点 + 链表逆序 + 合并链表
	///
	///	思路
	///
	///	注意到目标链表即为将原链表的左半端和反转后的右半端合并后的结果。
	///	这样我们的任务即可划分为三步：
	///	1. 找到原链表的中点（参考「876. 链表的中间结点」）。
	///		我们可以使用快慢指针来 O(N) 找到链表的中间节点。
	///	2. 将原链表的右半端反转（参考「206. 反转链表」）。
	///		我们可以使用迭代法实现链表的反转。
	///	3. 将原链表的两端合并。
	///		因为两链表长度相差不超过 1，因此直接合并即可。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 56 ms 击败 94.34%
	/// 内存 18.8 MB 击败 75.47%
	func reorderList2(_ head: ListNode?) {
		
		if head == nil { return }
		
		let mid = middleNode143(head)
		let l1 = head
		var l2 = mid?.next
		
		mid?.next = nil
		l2 = reverseList143(l2)
		
		mergeList(l1, l2)
	}
	
	func middleNode143(_ head: ListNode?) -> ListNode? {
		
		var fast = head
		var slow = head
		
		while fast != nil && fast?.next != nil {
			fast = fast?.next?.next
			slow = slow?.next
		}
		
		return slow
	}
	
	func reverseList143(_ head: ListNode?) -> ListNode? {
		
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
	
	func mergeList(_ l1: ListNode?, _ l2: ListNode?) {
		
		var l1 = l1
		var l2 = l2

		var l1_next: ListNode? = nil
		var l2_next: ListNode? = nil
		
		while l1 != nil && l2 != nil {
			l1_next = l1?.next
			l2_next = l2?.next
			
			l1?.next = l2
			l1 = l1_next
			
			l2?.next = l1
			l2 = l2_next
		}
	}
}
