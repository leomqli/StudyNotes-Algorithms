//
//  237. 删除链表中的节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/7.
//

/*
 
 https://leetcode.cn/problems/delete-node-in-a-linked-list/
 
 */

import Foundation

extension Solution {
	
	///	方法：糟糕，我成替身了
	///
	/// 复杂度分析
	/// 时间复杂度：O(1)。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 16 ms 击败 89.9%
	/// 内存 14 MB 击败 43.64%
	func deleteNode1(_ node: ListNode?) {
		let next = node?.next
		node?.val = next?.val ?? 0
		node?.next = next?.next
		next?.next = nil
	}
	
}
