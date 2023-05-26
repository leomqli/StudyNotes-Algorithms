//
//  203. 移除链表元素.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-12-05.
//
//  https://leetcode.cn/problems/remove-linked-list-elements

extension Algorithm {
    static func test203() {
        let head = [1,2,6,3,4,5,6], val = 6
        let list = ListNode.getListNode(head)
        let list1 = Solution().removeElements(list, val)
        let result = ListNode.getResult(list1)
        print(result)
    }
}

extension Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummyNode = ListNode()
        dummyNode.next = head
        var currentNode = dummyNode
        
        while let curNode = currentNode.next {
            if curNode.val == val {
                currentNode.next = curNode.next
            } else {
                currentNode = curNode
            }
        }
        return dummyNode.next
    }
}
