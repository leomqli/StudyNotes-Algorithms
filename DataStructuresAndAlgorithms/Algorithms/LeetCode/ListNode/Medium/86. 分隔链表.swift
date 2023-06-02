//
//  86. 分隔链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/2.
//

/*
 
 https://leetcode.cn/problems/partition-list/description/
 
 */

import Foundation

extension Solution {
		
	///	方法一：模拟
	///
	///	直观来说我们只需维护两个链表 small 即可，small 链表按顺序存储所有小于 x 的节点，large 链表按顺序存储所有大于等于 x 的节点。
	///	遍历完原链表后，我们只要将 small 链表尾节点指向 large 链表的头节点即能完成对链表的分隔。
	///
	///	为了实现上述思路，我们设 smallHead 和 largeHead 分别为两个链表的哑节点，即它们的 next  指针指向链表的头节点，这样做的目的是为了更方便地处理头节点为空的边界条件。
	///	同时设 small 和 large 节点指向当前链表的末尾节点开始时 smallHead=small, largeHead=large。
	///	随后，从前往后遍历链表，判断当前链表的节点值是否小于 x，如果小于就将 small 的 next 指针指向该节点，否则将 large 的 next 指针指向该节点。
	///
	///	遍历结束后，我们将 large 指针置空，这是因为当前节点复用的是原链表的节点，而其 next 指针可能指向一个小于 x 的节点，我们需要切断这个引用。
	///	同时将 small 指针指向 largeHead 的 next 指针指向的节点，即真正意义上的 large 链表的头节点。最后返回 smallHead 的 next 指针即为我们要求的答案。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表一次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 12 ms 击败 36.36%
	/// 内存 13.6 MB 击败92.42%
	func partition(_ head: ListNode?, _ x: Int) -> ListNode? {

		var small: ListNode? = ListNode(-1000, head)
		let smallHead = small
		
		var large: ListNode? = ListNode(-1000, head)
		let largeHead = large
		
		var cur = head
		
		while cur != nil {
			
			if cur!.val < x {
				small?.next = cur
				small = small?.next
			} else {
				large?.next = cur
				large = large?.next
			}
			
			cur = cur?.next
		}
		
		large?.next = nil
		small?.next = largeHead?.next
		
		return smallHead?.next
	}
	
}
