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
        if head == nil || head?.next == nil {
            return head
        }

        var pre: ListNode? = nil
        var tmp: ListNode? = nil
        var cur = head

        while cur != nil {
            // 保存下一个节点
            tmp = cur?.next
            // 将指向反转
            cur?.next = pre
            // 移动pre指针
            pre = cur
            // 移动cur指针
            cur = tmp
        }
        
        return pre
    }
}
