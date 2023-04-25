//
//  160.GetIntersectionNode.swift
//  Algorithms
//
//  Created by Leo on 2023/4/23.
//

extension Algorithm {
	static func test160() {
		
	}
}

extension Solution {
	
	func getIntersectionNode(
		_ headA: ListNode?,
		_ headB: ListNode?
	) -> ListNode? {
		return getIntersectionNodeSolution1(headA, headB)
		return getIntersectionNodeSolution2(headA, headB)
	}
	
	/// 方法一：哈希集合
	///
	/// 思路
	/// 判断两个链表是否相交，可以使用哈希集合存储链表节点。
	/// 首先遍历链表 headA，并将链表 headA 中的每个节点加入哈希集合中。然后遍历链表 headB，对于遍历到的每个节点，判断该节点是否在哈希集合中：
	/// 如果当前节点不在哈希集合中，则继续遍历下一个节点；
	/// 如果当前节点在哈希集合中，则后面的节点都在哈希集合中，即从当前节点开始的所有节点都在两个链表的相交部分，因此在链表 headB 中遍历到的第一个在哈希集合中的节点就是两个链表相交的节点，返回该节点。
	/// 如果链表 headB 中的所有节点都不在哈希集合中，则两个链表不相交，返回 null。
	///
	/// 复杂度分析
	/// 时间复杂度：O(m+n)，其中 m 和 n 是分别是链表 headA 和 headB 的长度。需要遍历两个链表各一次。
	/// 空间复杂度：O(m)，其中 m 是链表 headA 的长度。需要使用哈希集合存储链表 headA 中的全部节点。
	///
	/// 结果
	/// 时间 196 ms 击败 96.89%
	/// 内存 17 MB 击败 5.59%
	///
 	/// - Parameters:
	///   - headA: 单链表的头节点
	///   - headB: 单链表的头节点
	/// - Returns: 两个单链表相交的起始节点
	func getIntersectionNodeSolution1(
		_ headA: ListNode?,
		_ headB: ListNode?
	) -> ListNode? {
		
		var set: Set<ListNode> = []
		
		var tmp = headA
		
		while tmp != nil {
			set.insert(tmp!)
			tmp = tmp?.next
		}
		
		tmp = headB
		
		while tmp != nil {
			if set.contains(tmp!) {
				return tmp
			}
			tmp = tmp?.next
		}
		
		return nil
	}
	
	/// 方法二：双指针
	///
	/// 思路
	///
	/// 使用双指针的方法，可以将空间复杂度降至 O(1)。
	///
	/// 只有当链表 headA 和 headB 都不为空时，两个链表才可能相交。因此首先判断链表 headA 和 headB 是否为空，如果其中至少有一个链表为空，则两个链表一定不相交，返回 nil。
	///
	/// 当链表 headA 和 headB 都不为空时，创建两个指针 pA 和 pB，初始时分别指向两个链表的头节点 headA 和 headB，然后将两个指针依次遍历两个链表的每个节点。具体做法如下：
	/// 	1. 每步操作需要同时更新指针 pA 和 pB。
	/// 	2. 如果指针 pA 不为空，则将指针 pA 移到下一个节点；如果指针 pB 不为空，则将指针 pB 移到下一个节点。
	/// 	3. 如果指针 pA 为空，则将指针 pA 移到链表 headB 的头节点；如果指针 pB 为空，则将指针 pB 移到链表 headA 的头节点。
	/// 	4. 当指针 pA 和 pB 指向同一个节点或者都为空时，返回它们指向的节点或者 nil。
	///
	///	证明
	///
	///	下面提供双指针方法的正确性证明。考虑两种情况，第一种情况是两个链表相交，第二种情况是两个链表不相交。
	///
	///	情况一：两个链表相交
	///	链表 headA 和 headB 的长度分别是 m 和 n。假设链表 headA 的不相交部分有 a 个节点，链表 headB 的不相交部分有 b 个节点，两个链表相交的部分有 c 个节点，则有 a + c = m，b + c = n。
	///		1. 如果 a = b，则两个指针会同时到达两个链表相交的节点，此时返回相交的节点；
	///		2. 如果 a ≠ b，则指针 pA 会遍历完链表 headA，指针 pB 会遍历完链表 headB，两个指针不会同时到达链表的尾节点，
	///		  然后指针 pA 移到链表 headB 的头节点，指针 pB 移到链表 headA 的头节点，
	///		  然后两个指针继续移动，在指针 pA 移动了 a + c + b 次、指针 pB 移动了 b + c + a 次之后，两个指针会同时到达两个链表相交的节点，该节点也是两个指针第一次同时指向的节点，此时返回相交的节点。
	///
	///	情况二：两个链表不相交
	///	链表 headA 和 headB 的长度分别是 m 和 n。考虑当 m = n 和 m ≠ n，两个指针分别会如何移动：
	///		1. 如果 m = n，则两个指针会同时到达两个链表的尾节点，然后同时变成空值 nil，此时返回 nil；
	///		2. 如果 m ≠ n，则由于两个链表没有公共节点，两个指针也不会同时到达两个链表的尾节点，因此两个指针都会遍历完两个链表，在指针 pA 移动了 m + n 次、指针 pB 移动了 n + m 次之后，两个指针会同时变成空值 nil，此时返回 nil。
	///
	///	复杂度分析
	///
	///	时间复杂度：O(m+n)，其中 m 和 n 是分别是链表 headA 和 headB 的长度。两个指针同时遍历两个链表，每个指针遍历两个链表各一次。
	///	空间复杂度：O(1)。
	///
	///	结果
	/// 时间 200 ms 击败 87.58%
	/// 内存 16.4 MB 击败 83.85%
	///
	/// - Parameters:
	///   - headA: 单链表的头节点
	///   - headB: 单链表的头节点
	/// - Returns: 两个单链表相交的起始节点
	func getIntersectionNodeSolution2(
		_ headA: ListNode?,
		_ headB: ListNode?
	) -> ListNode? {
		
		if headA == nil || headB == nil { return nil }
		
		var pA = headA
		var pB = headB
		
		while pA != pB {
			pA = pA == nil ? headB : pA?.next
			pB = pB == nil ? headA : pB?.next
		}
		
		return pA
	}
	
}
