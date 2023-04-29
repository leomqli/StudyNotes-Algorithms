//
//  2. 两数相加.swift
//  Algorithms
//
//  Created by Leo on 2022-11-20.
//
//  https://leetcode.cn/problems/add-two-numbers/solutions/

extension Algorithm {
    static func test2() {
        let l1 = ListNode.getListNode([9,9,9,9,9,9,9])
        let l2 = ListNode.getListNode([9,9,9,9])
        let l3 = Solution().addTwoNumbers(l1, l2)
        
        print(ListNode.getResult(l3))
    }
}

extension Solution {
    
    func addTwoNumbers(_ l1: ListNode?,
                       _ l2: ListNode?) -> ListNode? {
        return add(l1, l2, 0)
    }

    func add(_ l1: ListNode?,
             _ l2: ListNode?,
             _ carry: Int) -> ListNode? {
        
        if l1 == nil && l2 == nil && carry == 0 {
            return nil
        }
        
        let val1 = l1?.val ?? 0
        let val2 = l2?.val ?? 0
        let sum = carry + val1 + val2
                
        return ListNode(sum % 10, add(l1?.next, l2?.next, sum / 10))
    }
    
    func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1 = l1
        var list2 = l2
        
        let result = ListNode()
        
        var current = result
        var sum = 0
        
        while list1 != nil || list2 != nil || sum > 0 {
            if let tmp = list1 {
                sum += tmp.val
                list1 = tmp.next
            }
            
            if let tmp = list2 {
                sum += tmp.val
                list2 = tmp.next
            }
            
            current.next = ListNode(sum % 10)
            sum /= 10
            current = current.next!
        }
        
        return result.next
    }
}
