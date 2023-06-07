//
//  147. 对链表进行插入排序.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/7.
//

/*
 
 https://leetcode.cn/problems/insertion-sort-list/
 
 */

import Foundation

extension Algorithm {
	static func test147() {
		let head = ListNode.getListNode([-1,5,3,4,0])
		let res = Solution().insertionSortList(head)
		print(ListNode.getResult(res))
	}
}

extension Solution {
	
	/// 方法一：从前往后找插入点
	///
	/// 复杂度分析
	/// 时间复杂度：O(n^2)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 144 ms 击败 100%
	/// 内存 14.8 MB 击败 N/A
	func insertionSortList(_ head: ListNode?) -> ListNode? {
		
		if head == nil { return nil }
		
		let dummy: ListNode? = ListNode(0, head)
		var list = head
		var cur = head?.next
		
		while cur != nil {
			
			if list!.val <= cur!.val {
				list = list?.next
			} else {
				
				var pre = dummy
				
				// 找到大于cur节点的前一节点
				while pre!.next!.val <= cur!.val {
					pre = pre?.next
				}
				
				// 将 list 指向 cur 的 next 节点
				list?.next = cur?.next
				// 将 cur 指向 大于他的节点
				cur?.next = pre?.next
				// 将大于 cur 节点的前一节点指向 cur 节点
				pre?.next = cur
			}
			
			cur = list?.next
		}
		
		return dummy?.next
	}
	
}
