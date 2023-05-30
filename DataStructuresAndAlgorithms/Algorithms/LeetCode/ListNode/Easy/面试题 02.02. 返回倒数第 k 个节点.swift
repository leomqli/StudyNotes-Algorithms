//
//  面试题 02.02. 返回倒数第 k 个节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/27.
//

/*
 
 https://leetcode.cn/problems/kth-node-from-end-of-list-lcci/
 
 相同题目：
 https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/
 
 实现一种算法，找出单向链表中倒数第 k 个节点。返回该节点的值。

 注意：本题相对原题稍作改动

 示例：

 输入： 1->2->3->4->5 和 k = 2
 输出： 4
 说明：

 给定的 k 保证是有效的。
 
 */

import Foundation

extension Algorithm {
	
	static func test面试题0202() {
		let head = ListNode.getListNode([1,2,3,4,5])
		let result = Solution().kthToLast(head, 2)
		print(result)
	}
}

extension Solution {
	
	/// 方法一：两次循环
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。遍历了两遍链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 33.33%
	/// 内存 13.7 MB 击败 66.67%
	func kthToLast(_ head: ListNode?, _ k: Int) -> Int {
		
		var cur = head
		var count = 0
		
		while cur != nil {
			count += 1
			cur = cur?.next
		}
		
		let index = count - k
		cur = head
		count = 0
		
		while count != index {
			count += 1
			cur = cur?.next
		}
		
		return cur?.val ?? 0
	}
	
	/// 方法二：双指针
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。遍历了一遍链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 33.33%
	/// 内存 13.9 MB 击败 33.33%
	func kthToLast2(_ head: ListNode?, _ k: Int) -> Int {
		
		var fast = head
		var slow = head
		var count = k
		
		while fast != nil {
			
			if count != 0 {
				count -= 1
				fast = fast?.next
				continue
			}
			
			fast = fast?.next
			slow = slow?.next
		}
		
		return slow?.val ?? 0
	}
	
}
