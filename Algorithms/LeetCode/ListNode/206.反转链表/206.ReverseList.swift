//
//  206.ReverseList.swift
//  Algorithms
//
//  Created by Leo on 2022-12-05.
//
//  206.反转链表
//  https://leetcode.cn/problems/reverse-linked-list

extension Algorithm {
    static func test206() {
        let head = [1,2,3,4,5]
        let headList = ListNode.getListNode(head)
        let list = Solution().reverseList(headList)
        let result = ListNode.getResult(list)
        print(result)
    }
}

extension Solution {
	
	func reverseList(_ head: ListNode?) -> ListNode? {
		
		print(reverseList1(head))
		print(reverseList2(head))
		
		return nil
	}
	
	/// 方法一：迭代
	///
	/// 思路
	///
	/// 假设链表为 1→2→3→∅，我们想要把它改成 ∅←1←2←3。
	/// 在遍历链表时，将当前节点的 next 指针改为指向前一个节点。由于节点没有引用其前一个节点，因此必须事先存储其前一个节点。在更改引用之前，还需要存储后一个节点。最后返回新的头引用。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表一次。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 8 ms 击败 99.4%
	/// 内存 14.6 MB 击败 62.6%
	///
	/// - Parameter head: 头节点
	/// - Returns: 链表
    func reverseList1(_ head: ListNode?) -> ListNode? {
        
		if head == nil || head?.next == nil {
            return head
        }

        var pre: ListNode? = nil
        var cur = head

        while cur != nil {
            // 保存下一个节点
			let next = cur?.next
            // 将指向反转
            cur?.next = pre
            // 移动pre指针
            pre = cur
            // 移动cur指针
            cur = next
        }
        
        return pre
    }
	
	
	/// 方法二：递归
	///
	/// 思路
	///	遍历节点，先将当前节点的下一节点保存，然后将下一节点指向上一节点，然后将当前节点与下一节点继续进行递归
	///	递归终止条件：遍历至尾节点时，下一节点为nil
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。需要遍历链表一次。
	/// 空间复杂度：O(n)。
	///
	///	结果
	/// 时间 12 ms 击败 60%
	/// 内存 14.6 MB 击败 36.67%
	func reverseList2(_ head: ListNode?) -> ListNode? {
		return recursiveMethod(nil, cur: head)
	}

	private func recursiveMethod(_ pre: ListNode?, cur: ListNode?) -> ListNode? {
		guard cur != nil else { return pre }
		let temp: ListNode? = cur?.next
		cur?.next = pre
		return recursiveMethod(cur, cur: temp)
	}
	
}
