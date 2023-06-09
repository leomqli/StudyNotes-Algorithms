//
//  328. 奇偶链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/9.
//

/*
 
 https://leetcode.cn/problems/odd-even-linked-list/
 
 给定单链表的头节点 head ，将所有索引为奇数的节点和索引为偶数的节点分别组合在一起，然后返回重新排序的列表。

 第一个节点的索引被认为是 奇数 ， 第二个节点的索引为 偶数 ，以此类推。

 请注意，偶数组和奇数组内部的相对顺序应该与输入时保持一致。

 你必须在 O(1) 的额外空间复杂度和 O(n) 的时间复杂度下解决这个问题。
 
 */

import Foundation

extension Algorithm {
	static func test328() {
		let head = ListNode.getListNode([1,2,3,4,5,6,7,8])
		let result = Solution().oddEvenList2(head)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：分离节点后合并
	///
	/// 自己做出来的
	///	创建一个偶数链表，遍历链表一遍，将偶数挑出来，然后再组合
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 28 ms 击败 17.14%
	/// 内存 14.7 MB 击败 28.57%
	func oddEvenList(_ head: ListNode?) -> ListNode? {
		
		if head == nil || head?.next == nil { return head }
		
		var cur = head
		var even: ListNode? = ListNode(0)
		let saved = even
		
		while cur != nil && cur?.next != nil {
			if cur?.next?.next == nil {
				even?.next = cur?.next
				cur?.next = nil
			} else {
				let next = cur?.next?.next
				cur?.next?.next = nil
				even?.next = cur?.next
				even = even?.next
				cur?.next = next
				cur = cur?.next
			}
		}
		
		cur?.next = saved?.next
		
		return head
	}
	
	/// 方法二：分离节点后合并（方法一算法优化版）
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 20 ms 击败 97.14%
	/// 内存 14.7 MB 击败 57.14%
	func oddEvenList2(_ head: ListNode?) -> ListNode? {
		
		if head == nil || head?.next == nil { return head }
		
		let evenHead = head?.next
		var odd = head, even = evenHead
		
		while even != nil && even?.next != nil {
			odd?.next = even?.next
			odd = odd?.next
			even?.next = odd?.next
			even = even?.next
		}
		
		odd?.next = evenHead
		
		return head
	}
	
}
