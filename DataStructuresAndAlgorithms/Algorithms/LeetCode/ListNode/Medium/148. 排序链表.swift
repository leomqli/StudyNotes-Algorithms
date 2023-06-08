//
//  148. 排序链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/8.
//

/*
 
 https://leetcode.cn/problems/sort-list/
 
 进阶：你可以在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序吗？
 
 */

import Foundation

extension Algorithm {
	static func test148() {
		let head = ListNode.getListNode([4,2,1,3])
		let result = Solution().sortList2(head)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：插入排序
	///
	/// 结合 147. 对链表进行插入排序 的算法可以得出解法，但是会超时！
	///
	/// 复杂度分析
	/// 时间复杂度：O(n^2)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	func sortList(_ head: ListNode?) -> ListNode? {

		if head == nil { return nil }

		let dummy: ListNode? = ListNode(0, head)
		
		var list = head
		var cur = head?.next
		
		while cur != nil {
			
			if list!.val <= cur!.val {
				list = list?.next
			} else {
				
				var pre = dummy
				
				while pre!.next!.val <= cur!.val {
					pre = pre?.next
				}
				
				list?.next = cur?.next
				cur?.next = pre?.next
				pre?.next = cur
			}
			
			cur = list?.next
		}
		
		return dummy?.next
	}
	
	/*
	 
	 前言
	 
	 「147. 对链表进行插入排序」要求使用插入排序的方法对链表进行排序，插入排序的时间复杂度是 O(n^2)，其中 n 是链表的长度。
	 这道题考虑时间复杂度更低的排序算法。
	 题目的进阶问题要求达到 O(nlog⁡n) 的时间复杂度和 O(1) 的空间复杂度，时间复杂度是 O(nlog⁡n) 的排序算法包括归并排序、堆排序和快速排序（快速排序的最差时间复杂度是 O(n^2)），其中最适合链表的排序算法是归并排序。

	 归并排序基于分治算法。最容易想到的实现方式是自顶向下的递归实现，考虑到递归调用的栈空间，自顶向下归并排序的空间复杂度是 O(log⁡ n)。如果要达到 O(1) 的空间复杂度，则需要使用自底向上的实现方式。
	 
	 */
	
	/// 方法二：自顶向下归并排序
	///
	///	思路
	/// 对链表自顶向下归并排序的过程如下。
	/// 	1. 找到链表的中点，以中点为分界，将链表拆分成两个子链表。寻找链表的中点可以使用快慢指针的做法，快指针每次移动 2 步，慢指针每次移动 1 步，当快指针到达链表末尾时，慢指针指向的链表节点即为链表的中点。
	/// 	2. 对两个子链表分别排序。
	/// 	3. 将两个排序后的子链表合并，得到完整的排序后的链表。可以使用「21. 合并两个有序链表」的做法，将两个有序的子链表进行合并。
	///
	/// 上述过程可以通过递归实现。递归的终止条件是链表的节点个数小于或等于 1，即当链表为空或者链表只包含 1 个节点时，不需要对链表进行拆分和排序。
	///
	///	复杂度分析
	/// 时间复杂度：O(nlog n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(log n)。
	///
	///	结果
	/// 时间 928 ms 击败 7.69%
	/// 内存 22.8 MB 击败 100%
	func sortList2(_ head: ListNode?) -> ListNode? {
		return sortList(head, nil)
	}
	
	func sortList(_ head: ListNode?, _ tail: ListNode?) -> ListNode? {
		if head == nil {
			return nil
		}
		
		if head?.next == tail {
			head?.next = nil
			return head
		}
			
		var fast = head
		var slow = head
		
		while fast != tail && fast?.next != tail {
			fast = fast?.next?.next
			slow = slow?.next
		}
		
		let mid = slow
		let l1 = sortList(head, mid)
		let l2 = sortList(mid, tail)
		
		return mergeList148(l1, l2)
	}
	
	func mergeList148(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		
		let dummy: ListNode? = ListNode(0)
		var cur = dummy
		var l1 = l1
		var l2 = l2
		
		while l1 != nil && l2 != nil {
			
			if l1!.val <= l2!.val {
				cur?.next = l1
				l1 = l1?.next
			} else {
				cur?.next = l2
				l2 = l2?.next
			}
			cur = cur?.next
		}
		
		if l1 != nil {
			cur?.next = l1
		}
		
		if l2 != nil {
			cur?.next = l2
		}
		
		return dummy?.next
	}
	
	/// 方法三：自底向上归并排序
	///
	/// 使用自底向上的方法实现归并排序，则可以达到 O(1) 的空间复杂度。
	/// 首先求得链表的长度 length，然后将链表拆分成子链表进行合并。
	///
	/// 具体做法如下：
	/// 	1. 用 subLength 表示每次需要排序的子链表的长度，初始时 subLength = 1。
	/// 	2. 每次将链表拆分成若干个长度为 subLength 的子链表（最后一个子链表的长度可以小于 subLength），按照每两个子链表一组进行合并，
	/// 	  合并后即可得到若干个长度为 subLength × 2 的有序子链表（最后一个子链表的长度可以小于 subLength × 2）。
	/// 	  合并两个子链表仍然使用「21. 合并两个有序链表」的做法。
	/// 	3. 将 subLength 的值加倍，重复第 2 步，对更长的有序子链表进行合并操作，直到有序子链表的长度大于或等于 length，整个链表排序完毕。
	///
	/// 如何保证每次合并之后得到的子链表都是有序的呢？可以通过数学归纳法证明。
	/// 	1. 初始时 subLength=1，每个长度为 1 的子链表都是有序的。
	/// 	2. 如果每个长度为 subLength 的子链表已经有序，合并两个长度为 subLength 的有序子链表，得到长度为 subLength × 2 的子链表，一定也是有序的。
	/// 	3. 当最后一个子链表的长度小于 subLength 时，该子链表也是有序的，合并两个有序子链表之后得到的子链表一定也是有序的。
	///
	/// 因此可以保证最后得到的链表是有序的。
	///
	///	复杂度分析
	/// 时间复杂度：O(nlog n)，其中 n 是链表中的节点数。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 1028 ms 击败 5.77%
	/// 内存 23.1 MB 击败 71.15%
	func sortList3(_ head: ListNode?) -> ListNode? {
		if head == nil {
			return nil
		}
		
		var length = 0
		var cur = head
		
		while cur != nil {
			cur = cur?.next
			length += 1
		}
		
		var dummy: ListNode? = ListNode(0, head)
		
		var subLength = 1
		
		while subLength < length {
			
			var pre = dummy
			var cur = dummy?.next
			
			while cur != nil {
				
				var l1 = cur
				var tmp = 1
				while tmp < subLength && cur?.next != nil {
					tmp += 1
					cur = cur?.next
				}
				
				var l2 = cur?.next
				cur?.next = nil
				cur = l2
				
				tmp = 1
				while tmp < subLength && cur != nil && cur?.next != nil {
					tmp += 1
					cur = cur?.next
				}
				
				var next: ListNode? = nil
				
				if cur != nil {
					next = cur?.next
					cur?.next = nil
				}
					
				pre?.next = mergeList148(l1, l2)
				
				while pre?.next != nil {
					pre = pre?.next
				}
				
				cur = next
			}
			
			subLength *= 2
		}
		
		return dummy?.next
	}
	
	/// 方法四：数组
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表中的节点数。需要遍历3次。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 320 ms 击败 100%
	/// 内存 24.4 MB 击败 9.61%
	func sortList4(_ head: ListNode?) -> ListNode? {
		
		var list = [Int]()
		var cur = head
		
		while cur != nil {
			list.append(cur!.val)
			cur = cur?.next
		}
		
		var dummy = ListNode(0)
		var tmp = dummy
		
		list.sorted().forEach {
			let node = ListNode($0)
			tmp.next = node
			tmp = node
		}
		
		return dummy.next
	}
	
}
