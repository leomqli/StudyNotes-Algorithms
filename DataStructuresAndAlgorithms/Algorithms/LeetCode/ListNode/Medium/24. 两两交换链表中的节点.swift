//
//  24. 两两交换链表中的节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/30.
//

/*
 
 https://leetcode.cn/problems/swap-nodes-in-pairs/
 
 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。
 
 示例 1：
 输入：head = [1,2,3,4]
 输出：[2,1,4,3]
 
 示例 2：
 输入：head = []
 输出：[]
 
 示例 3：
 输入：head = [1]
 输出：[1]

 提示：
 链表中节点的数目在范围 [0, 100] 内
 0 <= Node.val <= 100
 
 */

import Foundation

extension Algorithm {
	
	static func test24() {
		let head = ListNode.getListNode([1,2,3,4])
		let result = Solution().swapPairs(head)
		print(ListNode.getResult(result))
	}
}


extension Solution {
	
	/// 方法：迭代
	///
	/// 重点在于 pA 和 pB 的交换，以及 cur 移动到的下一节点
	///
	///	复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的节点数量。
	/// 空间复杂度：O(1)。
	///
	/// 结果
	/// 时间 4 ms 击败 80.60%
	/// 内存 13.7 MB 击败 70.15%
	func swapPairs(_ head: ListNode?) -> ListNode? {

		if head == nil || head?.next == nil { return head }
		
		let dummy: ListNode? = ListNode(0, head)
		var cur = dummy
		
		while cur?.next != nil && cur?.next?.next != nil {
			let pA = cur?.next
			let pB = cur?.next?.next
			cur?.next = pB
			pA?.next = pB?.next
			pB?.next = pA
			cur = pA
		}
		
		return dummy?.next
	}
}
