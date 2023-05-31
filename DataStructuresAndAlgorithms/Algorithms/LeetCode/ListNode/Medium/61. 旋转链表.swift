//
//  61. 旋转链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/31.
//

import Foundation

extension Algorithm {
	static func test61() {
		let head = ListNode.getListNode([1,2,3,4,5])
		let result = Solution().rotateRight(head, 2)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	///	方法一：闭合为环
	///
	///	思路
	///	记给定链表的长度为 n，注意到当向右移动的次数 k ≥ n 时，我们仅需要向右移动 k  mod  n 次即可。因为每 n 次移动都会让链表变为原状。
	///	这样我们可以知道，新链表的最后一个节点为原链表的第 (n−1) − (k  mod  n) 个节点（从 0 开始计数）。
	///
	///	这样，我们可以先将给定的链表连接成环，然后将指定位置断开。
	///
	///	具体代码中，我们首先计算出链表的长度 n，并找到该链表的末尾节点，将其与头节点相连。这样就得到了闭合为环的链表。
	///	然后我们找到新链表的最后一个节点（即原链表的第 (n−1) − (k  mod  n) 个节点），将当前闭合为环的链表断开，即可得到我们所需要的结果。
	///
	///	特别地，当链表长度不大于 1，或者 k 为 n 的倍数时，新链表将与原链表相同，我们无需进行任何处理。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，最坏情况下，我们需要遍历该链表两次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 12 ms 击败 43.90%
	/// 内存 13.8 MB 击败 46.34%
	func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
		
		if (k == 0 || head == nil || head?.next == nil) {
			return head;
		}

		// 遍历得到最后一个指针
		var count = 1
		var cur = head
		
		while cur?.next != nil {
			cur = cur?.next
			count += 1
		}
		
		// 旋转完正好与原链表相同的情况
		var index = count - k % count
		if index == count { return head }
		
		// 将给定的链表连接成环
		cur?.next = head
		
		// 移动到旋转末尾的指针
		while index != 0 {
			cur = cur?.next
			index -= 1
		}
		
		// 找到头节点
		let result = cur?.next
		
		// 断开环
		cur?.next = nil
		
		return result
	}
	
}
