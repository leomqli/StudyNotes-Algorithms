//
//  2074. 反转偶数长度组的节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/7/16.
//

/*
 
 https://leetcode.cn/problems/reverse-nodes-in-even-length-groups/
 
 给你一个链表的头节点 head 。

 链表中的节点 按顺序 划分成若干 非空 组，这些非空组的长度构成一个自然数序列（1, 2, 3, 4, ...）。一个组的 长度 就是组中分配到的节点数目。换句话说：

 节点 1 分配给第一组
 节点 2 和 3 分配给第二组
 节点 4、5 和 6 分配给第三组，以此类推
 注意，最后一组的长度可能小于或者等于 1 + 倒数第二组的长度 。

 反转 每个 偶数 长度组中的节点，并返回修改后链表的头节点 head 。
 
 提示：
 
 链表中节点数目范围是 [1, 105]
 0 <= Node.val <= 105
 
 */

import Foundation

extension Algorithm {
	static func test2074() {
		let input1 = ListNode.getListNode([1,2,3,4,5])
		let result = Solution().reverseEvenLengthGroups(input1)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：模拟
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。其中 n 是链表中的节点数。遍历了两遍链表。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 1772 ms 击败 100%
	/// 内存 33.58 MB 击败 100%
	func reverseEvenLengthGroups(_ head: ListNode?) -> ListNode? {
		
		var pre = head
		var cur = head
		// 当前子链表数量
		var index = 1
		
		while cur != nil {
			
			var tmp = cur
			
			// 应该具有的长度 == 实际长度 或者 链表到头时 ，终止遍历
			var len = 0
			
			while len < index && tmp != nil {
				len += 1
				tmp = tmp?.next
			}
			
			var j = 0
			
			if len % 2 == 1 {
				// 实际子链表长度为奇数
				while j < len {
					j += 1
					pre = cur
					cur = cur?.next
				}
			} else {
				// 实际子链表长度为偶数
				while j < len - 1 {
					j += 1
					let next = cur?.next
					cur?.next = cur?.next?.next
					next?.next = pre?.next
					pre?.next = next
				}
				
				pre = cur
				cur = cur?.next
			}
			
			index += 1
		}
		
		return head
	}
}
