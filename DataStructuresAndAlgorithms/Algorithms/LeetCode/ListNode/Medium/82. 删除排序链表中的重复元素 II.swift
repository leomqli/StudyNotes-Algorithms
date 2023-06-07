//
//  82. 删除排序链表中的重复元素 II.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/1.
//

/*
 
 https://leetcode.cn/problems/remove-duplicates-from-sorted-list-ii/
 
 */

import Foundation

extension Solution {
	
	///	方法一：一次遍历
	///
	///	思路
	///
	///	由于给定的链表是排好序的，因此重复的元素在链表中出现的位置是连续的，因此我们只需要对链表进行一次遍历，就可以删除重复的元素。
	///	由于链表的头节点可能会被删除，因此我们需要额外使用一个哑节点（dummy node）指向链表的头节点。
	///
	///	具体地，我们从指针 cur 指向链表的哑节点，随后开始对链表进行遍历。如果当前 cur.next 与 cur.next.nex 对应的元素相同，那么我们就需要将 cur.next 以及所有后面拥有相同元素值的链表节点全部删除。
	///	我们记下这个元素值 x，随后不断将 cur.next 从链表中移除，直到 cur.next 为空节点或者其元素值不等于 x 为止。此时，我们将链表中所有元素值为 x 的节点全部删除。
	///
	///	如果当前 cur.next 与 cur.next.next 对应的元素不相同，那么说明链表中只有一个元素值为 cur.next 的节点，那么我们就可以将 cur 指向 cur.next。
	///
	///	当遍历完整个链表之后，我们返回链表的的哑节点的下一个节点 dummy.next 即可。
	///
	///	细节
	///
	///	需要注意 cur.next 以及 cur.next.next 可能为空节点，如果不加以判断，可能会产生运行错误。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 20 ms 击败 89.19%
	/// 内存 13.8 MB 击败 70.27%
	func deleteDuplicates2(_ head: ListNode?) -> ListNode? {

		var dummy: ListNode? = ListNode(-1000, head)
		
		var cur = dummy

		while cur?.next != nil && cur?.next?.next != nil {
			
			if cur?.next?.val == cur?.next?.next?.val {
				let val = cur?.next?.val
				
				/*
				 这样写更严谨
				 while (cur?.next != nil && cur?.next?.val == val) {
				 但是本质上 cur?.next 为 nil 时，cur?.next?.val == val 不成立，循环也不会继续
				 */
				while cur?.next?.val == val {
					cur?.next = cur?.next?.next
				}
			} else {
				cur = cur?.next
			}
		}
		
		return dummy?.next
	}
}
