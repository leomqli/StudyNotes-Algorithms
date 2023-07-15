//
//  1721. 交换链表中的节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/7/15.
//

/*
 
 https://leetcode.cn/problems/swapping-nodes-in-a-linked-list/
 
 给你链表的头节点 head 和一个整数 k 。

 交换 链表正数第 k 个节点和倒数第 k 个节点的值后，返回链表的头节点（链表 从 1 开始索引）。
 
 提示：

 链表中节点的数目是 n
 1 <= k <= n <= 105
 0 <= Node.val <= 100
 
 */

import Foundation

extension Algorithm {
	static func test1721() {
		let input1 = ListNode.getListNode([1,2,3,4])
		let input2 = 3
		let result = Solution().swapNodes(input1, input2)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：模拟
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 968 ms 击败 100%
	/// 内存 32.78 MB 击败 100%
	func swapNodes(_ head: ListNode?, _ k: Int) -> ListNode? {
		
		let dummy: ListNode? = ListNode(0, head)
		var cur = dummy
		var index = 0
		
		var pre1: ListNode? = dummy
		var first: ListNode? = dummy?.next
		var pre2: ListNode? = dummy
		var last: ListNode? = dummy?.next
		
		while cur != nil {
			
			if index + 1 < k {
				pre1 = pre1?.next
				first = first?.next
			}
			
			if index > k {
				pre2 = pre2?.next
				last = last?.next
			}
			
			index += 1
			cur = cur?.next
		}
		
		let tmp = last?.next
		
		if first == pre2 {
			// 第k个节点是倒数第k个节点的前驱节点
			pre1?.next = last
			last?.next = first
			first?.next = tmp
		} else if pre1 == last {
			// 双数个节点且第k个节点是倒数第k个节点的前驱节点
			last?.next = first?.next
			pre2?.next = first
			first?.next = last
		} else {
			last?.next = first?.next
			pre2?.next = first
			pre1?.next = last
			first?.next = tmp
		}
		
		return dummy?.next
	}
	
}
