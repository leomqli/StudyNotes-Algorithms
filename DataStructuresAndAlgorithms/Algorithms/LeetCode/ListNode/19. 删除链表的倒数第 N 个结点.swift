//
//  19. 删除链表的倒数第 N 个结点.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/30.
//

/*
 
 https://leetcode.cn/problems/remove-nth-node-from-end-of-list/
 
 Medium
 
 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

 示例 1：
 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 
 示例 2：
 输入：head = [1], n = 1
 输出：[]
 
 示例 3：
 输入：head = [1,2], n = 1
 输出：[1]
  
 提示：
 链表中结点的数目为 sz
 1 <= sz <= 30
 0 <= Node.val <= 100
 1 <= n <= sz

 进阶：你能尝试使用一趟扫描实现吗？
 */

import Foundation

extension Algorithm {
	
	static func test19() {
		let head = ListNode.getListNode([1,2])
		let result = Solution().removeNthFromEnd(head, 2)
		print(ListNode.getResult(result))
	}
}

extension Solution {
		
	/// 方法：双指针/快慢指针
	///
	/// 注意头节点的判断问题，可以采用虚拟头节点来规避此问题
	///
	///	复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。
	/// 空间复杂度：O(1)。
	///
	/// 结果
	/// 时间 8 ms 击败 46.60%
	/// 内存 13.8 MB 击败 56.54%
	func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {

		let dummy: ListNode? = ListNode(0, head)
		
		var fast = head
		var slow = dummy
		var count = n
		
		while fast != nil {
			
			if count != 0 {
				fast = fast?.next
				count -= 1
				continue
			}
			
			fast = fast?.next
			slow = slow?.next
		}
		
		slow?.next = slow?.next?.next
		
		return dummy?.next
	}
}
