//
//  剑指 Offer 22. 链表中倒数第k个节点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/4/28.
//
//  https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/
//  输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。
//  例如，一个链表有 6 个节点，从头节点开始，它们的值依次是 1、2、3、4、5、6。这个链表的倒数第 3 个节点是值为 4 的节点。

import Foundation

extension Solution {
	
	/// 方法一：遍历存入数组，再读取
	///
	/// 思路
	///	将链表从头到尾遍历一遍，将节点存入数组中，然后取目标节点
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，n 是该链表的长度。
	///
	///	结果
	/// 时间 4 ms 击败 93.48%
	/// 内存 13.6 MB 击败 88.4%
	func getKthFromEnd1(_ head: ListNode?, _ k: Int) -> ListNode? {
		
		var list = [ListNode?]()
		var cur = head
		
		while cur != nil {
			list.append(cur)
			cur = cur?.next
		}
		
		return list[list.count - k]
	}
	
	/// 方法二：顺序查找
	///
	/// 思路
	///	最简单直接的方法即为顺序查找，假设当前链表的长度为 n，则我们知道链表的倒数第 k 个节点即为正数第 n−k+1 个节点，此时我们只需要顺序遍历完链表的 n−k 个节点即可到达倒数第 k 个节点。
	///	我们首先求出链表的长度 n，然后顺序遍历到链表的第 n−k 个节点返回即可。
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度，需要两次遍历。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 43.48%
	/// 内存 13.8 MB 击败 45.65%
	func getKthFromEnd2(_ head: ListNode?, _ k: Int) -> ListNode? {
		
		var count = 0
		var cur = head
		
		while cur != nil {
			count += 1
			cur = cur?.next
		}
		
		cur = head
		
		while count > k {
			count -= 1
			cur = cur?.next
		}
		
		return cur
	}
	
	/// 方法三：双指针
	///
	/// 思路
	/// 快慢指针的思想。
	/// 我们将第一个指针 fast 指向链表的第 k+1 个节点，第二个指针 slow 指向链表的第一个节点，此时指针 fast 与 slow 二者之间刚好间隔 k 个节点。
	/// 此时两个指针同步向后走，当第一个指针 fast 走到链表的尾部空节点时，则此时 slow 指针刚好指向链表的倒数第 k 个节点。
	/// 	我们首先将 fast 指向链表的头节点，然后向后走 k 步，则此时 fast 指针刚好指向链表的第 k+1 个节点。
	/// 	我们首先将 slow 指向链表的头节点，同时 slow 与 fast 同步向后走，当 fast 指针指向链表的尾部空节点时，则此时返回 slow 所指向的节点即可。
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。我们使用快慢指针，只需要一次遍历即可，复杂度为 O(n).
	///	空间复杂度：O(1)，使用常数大小的额外空间。
	///
	///	结果
	/// 时间 4 ms 击败 93.48%
	/// 内存 13.6 MB 击败 88.4%
	func getKthFromEnd3(_ head: ListNode?, _ k: Int) -> ListNode? {
		
		var former = head
		var latter = head
		
		for _ in 0 ..< k {
			former = former?.next
		}
		
		while former != nil {
			former = former?.next
			latter = latter?.next
		}
		
		return latter
	}
}
