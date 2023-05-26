//
//  876. 链表的中间结点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/24.
//

/*
 
 https://leetcode.cn/problems/middle-of-the-linked-list/
 
 给你单链表的头结点 head ，请你找出并返回链表的中间结点。

 如果有两个中间结点，则返回第二个中间结点。
 
 */

import Foundation

extension Algorithm {
	
	static func test876() {
		let head = ListNode.getListNode([1,2,3,4,5])
		let node = Solution().middleNode(head)
		let result = ListNode.getResult(node)
		print(result)
	}
}

extension Solution {
	
	/// 方法一：快慢指针
	///
	/// 思路
	///	慢指针每次走一步，快指针每次走两步，当快指针为空（偶数个节点）或者它的next为空（奇数个节点）时，遍历结束，慢指针处在中间节点。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表半次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 0 ms 击败 100%
	/// 内存 13.9 MB 击败 13.33%
	func middleNode(_ head: ListNode?) -> ListNode? {

		var fast = head
		var slow = head
		
		/*
		 这里需要判断当前节点和当前节点的下一个节点都不为空的思考，可能有三个原因：
		 1、“仅判断当前节点的下一个节点不为空”，适用于奇数个节点的情况，而偶数个节点时需要判断“当前节点不为空”。
		 2、两个条件&&，才显得逻辑严谨，思路清晰。
		 3、对于不同语言的处理“null.next != null”，可能存在差异，导致出错
		 */
		while fast != nil && fast?.next != nil {
			fast = fast?.next?.next
			slow = slow?.next
		}
		
		return slow
	}
}
