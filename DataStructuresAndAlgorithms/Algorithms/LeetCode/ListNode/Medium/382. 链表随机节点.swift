//
//  382. 链表随机节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/9.
//

/*
 
 https://leetcode.cn/problems/linked-list-random-node/
 
 给你一个单链表，随机选择链表的一个节点，并返回相应的节点值。每个节点 被选中的概率一样 。

 实现 Solution 类：
	* Solution(ListNode head) 使用整数数组初始化对象。
	* int getRandom() 从链表中随机选择一个节点并返回该节点的值。链表中所有节点被选中的概率相等。
 
 */

import Foundation

extension Algorithm {
	static func test382() {
		let head = ListNode.getListNode([1,2,3,4,5,6,7,8])
		let random = Solution382(head)
		let result = random.getRandom()
		print(result)
	}
}

class Solution382 {
	
	/// 方法一：水塘抽样
	///
	/// 自己做出来的
	///	创建一个偶数链表，遍历链表一遍，将偶数挑出来，然后再组合
	///
	/// 复杂度分析
	/// 时间复杂度：初始化为 O(1)，随机选择为 O(n)。其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。我们只需要常数的空间保存若干变量
	///
	///	结果
	/// 时间 72 ms 击败 83.33%
	/// 内存 16.1 MB 击败 16.67%
	
	var list: ListNode?
	
	init(_ head: ListNode?) {
		list = head
	}
	
	func getRandom() -> Int {

		var cur = list
		var index = 1, res = list?.val ?? 0
		
		while cur != nil {
						
			if Int.random(in: 0 ..< index) == 0 {
				res = cur!.val
			}
			
			index += 1
			cur = cur?.next
		}
		
		return res
	}
}
