//
//  2095. 删除链表的中间节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/7/17.
//

/*
 
 https://leetcode.cn/problems/delete-the-middle-node-of-a-linked-list/description/
 
 给你一个链表的头节点 head 。删除 链表的 中间节点 ，并返回修改后的链表的头节点 head 。
 
 长度为 n 链表的中间节点是从头数起第 ⌊n / 2⌋ 个节点（下标从 0 开始）
 
 提示：

 链表中节点的数目在范围 [1, 105] 内
 1 <= Node.val <= 105
 
 */

import Foundation

extension Algorithm {
	static func test2095() {
		let input1 = ListNode.getListNode([1])
		let result = Solution().deleteMiddle(input1)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：快慢指针
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。其中 n 是链表中的节点数。遍历了一遍链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 1752 ms 击败 25.00%
	/// 内存 34.98 MB 击败 62.50%
	func deleteMiddle(_ head: ListNode?) -> ListNode? {
		
		if head == nil || head?.next == nil { return nil }
		
		var pre: ListNode? = ListNode(0, head)
		var fast = head
		var slow = head
		
		while fast != nil && fast?.next != nil {
			pre = slow
			slow = slow?.next
			fast = fast?.next?.next
		}
		
		pre?.next = pre?.next?.next
		
		return head
	}
	
}
