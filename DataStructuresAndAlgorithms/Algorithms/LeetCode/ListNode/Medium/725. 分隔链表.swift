//
//  725. 分隔链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/7/11.
//

/*
 
 https://leetcode.cn/problems/split-linked-list-in-parts/
 
 给你一个头结点为 head 的单链表和一个整数 k ，请你设计一个算法将链表分隔为 k 个连续的部分。

 每部分的长度应该尽可能的相等：任意两部分的长度差距不能超过 1 。这可能会导致有些部分为 null 。

 这 k 个部分应该按照在链表中出现的顺序排列，并且排在前面的部分的长度应该大于或等于排在后面的长度。

 返回一个由上述 k 部分组成的数组。
 
 */

import Foundation

extension Algorithm {
	static func test725() {
		let input1 = ListNode.getListNode([1,2,3])
		let input2 = 5
		let result = Solution().splitListToParts(input1, input2)
		print(result)
	}
}

extension Solution {
	
	/// 方法一：反转链表后相加，最后再反转
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表两次，得到链表的长度和分隔链表。
	/// 空间复杂度：O(1)。只使用了常量的额外空间，注意返回值不计入空间复杂度。
	///
	///	结果
	/// 时间 20 ms 击败 N/A
	/// 内存 14.3 MB 击败 N/A
	func splitListToParts(_ head: ListNode?, _ k: Int) -> [ListNode?] {

		var cur = head
		var count = 0
		
		while cur != nil {
			count += 1
			cur = cur?.next
		}
		
		let quotient = count / k
		let remainder = count % k
		
		var result = [ListNode?](repeating: nil, count: k)
		
		cur = head
		var i = 0
		
		while i < k && cur != nil {
			result[i] = cur
			
			let size = quotient + (i < remainder ? 1 : 0)
			
			var j = 1
			
			while j < size {
				cur = cur?.next
				j += 1
			}
			
			let next = cur?.next
			cur?.next = nil
			cur = next
			
			i += 1
		}
		
		return result
	}
}
