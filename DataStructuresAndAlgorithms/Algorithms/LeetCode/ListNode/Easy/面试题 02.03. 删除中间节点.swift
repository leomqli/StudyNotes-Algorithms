//
//  面试题 02.03. 删除中间节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/27.
//

/*
 
 https://leetcode.cn/problems/delete-middle-node-lcci/
 
 原题：
 https://leetcode.cn/problems/delete-node-in-a-linked-list/
 
 若链表中的某个节点，既不是链表头节点，也不是链表尾节点，则称其为该链表的「中间节点」。

 假定已知链表的某一个中间节点，请实现一种算法，将该节点从链表中删除。

 例如，传入节点 c（位于单向链表 a->b->c->d->e->f 中），将其删除后，剩余链表为 a->b->d->e->f

 示例：

 输入：节点 5 （位于单向链表 4->5->1->9 中）
 输出：不返回任何数据，从链表中删除传入的节点 5，使链表变为 4->1->9
 
 这个题目真他妈傻逼，什么脑子能想出来的
 
 */

import Foundation

extension Solution {
	
	/// 方法一：六耳猕猴成为斗战胜佛的故事
	///
	/// 复杂度分析
	/// 时间复杂度：O(1)。
	/// 空间复杂度：O(1)。
	///
	///	结果（Java）
	/// 时间 0 ms 击败 100%
	/// 内存 41.9 MB 击败 12.83%
	func deleteNode(_ head: ListNode?) {
		let next = head?.next
		head?.val = head?.next?.val ?? 0
		head?.next = head?.next?.next
		next?.next = nil
	}
}
