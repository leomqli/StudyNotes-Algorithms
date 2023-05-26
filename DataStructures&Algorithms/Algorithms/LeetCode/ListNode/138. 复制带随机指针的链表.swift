//
//  138. 复制带随机指针的链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/4/26.
//
//  https://leetcode.cn/problems/copy-list-with-random-pointer/

import Foundation

extension Solution {
	
	func copyRandomList(_ head: Node?) -> Node? {
		return NodeSolution().copyRandomList(head)
	}
}

class NodeSolution {
	
	func copyRandomList(_ head: Node?) -> Node? {
		return copyRandomList1(head)
	}
	
	var hashMap = [Node: Node]()
	
	/// 方法一：回溯 + 哈希表
	///
	/// 思路
	///
	/// 本题要求我们对一个特殊的链表进行深拷贝。如果是普通链表，我们可以直接按照遍历的顺序创建链表节点。
	/// 而本题中因为随机指针的存在，当我们拷贝节点时，「当前节点的随机指针指向的节点」可能还没创建，因此我们需要变换思路。
	/// 一个可行方案是，我们利用回溯的方式，让每个节点的拷贝操作相互独立。
	/// 对于当前节点，我们首先要进行拷贝，然后我们进行「当前节点的后继节点」和「当前节点的随机指针指向的节点」拷贝，拷贝完成后将创建的新节点的指针返回，即可完成当前节点的两指针的赋值。
	///
	/// 具体地，我们用哈希表记录每一个节点对应新节点的创建情况。
	/// 遍历该链表的过程中，我们检查「当前节点的后继节点」和「当前节点的随机指针指向的节点」的创建情况。
	/// 如果这两个节点中的任何一个节点的新节点没有被创建，我们都立刻递归地进行创建。当我们拷贝完成，回溯到当前层时，我们即可完成当前节点的指针赋值。
	/// 注意一个节点可能被多个其他节点指向，因此我们可能递归地多次尝试拷贝某个节点，为了防止重复拷贝，我们需要首先检查当前节点是否被拷贝过，如果已经拷贝过，我们可以直接从哈希表中取出拷贝后的节点的指针并返回即可。
	///
	/// 在实际代码中，我们需要特别判断给定节点为空节点的情况。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。对于每个节点，我们至多访问其「后继节点」和「随机指针指向的节点」各一次，均摊每个点至多被访问两次。
	/// 空间复杂度：O(n)，其中 n 是链表的长度。为哈希表的空间开销。
	///
	///	结果
	/// 时间 36 ms 击败 12.5%
	/// 内存 15 MB 击败 75%
	private func copyRandomList1(_ head: Node?) -> Node? {
		
		guard head != nil else { return nil }
		
		// 老节点对应的新节点，已复制了，直接返回
		if let existNode = hashMap[head!] { return existNode }

		// 根据老节点的值，创建复制出新节点
		let newNode = Node(head!.val)
		
		// 使用老节点为key，新节点为value，存储到哈希表中
		hashMap[head!] = newNode
		
		// 递归调用开始创建next指针和random指针结点
		newNode.next = copyRandomList(head?.next)
		newNode.random = copyRandomList(head?.random)

		return hashMap[head!]
	}
	
	/// 方法二：迭代 + 节点拆分
	///
	/// 思路
	///
	/// 注意到方法一需要使用哈希表记录每一个节点对应新节点的创建情况，而我们可以使用一个小技巧来省去哈希表的空间。
	///	我们首先将该链表中每一个节点拆分为两个相连的节点，例如对于链表 A→B→C，我们可以将其拆分为 A→A′→B→B′→C→C′。对于任意一个原节点 S，其拷贝节点 S′ 即为其后继节点。
	///
	///	这样，我们可以直接找到每一个拷贝节点 S′ 的随机指针应当指向的节点，即为其原节点 S 的随机指针指向的节点 T 的后继节点 T′。
	///	需要注意原节点的随机指针可能为空，我们需要特别判断这种情况。
	///
	///	当我们完成了拷贝节点的随机指针的赋值，我们只需要将这个链表按照原节点与拷贝节点的种类进行拆分即可，只需要遍历一次。
	///	同样需要注意最后一个拷贝节点的后继节点为空，我们需要特别判断这种情况。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。我们只需要遍历该链表三次。
	/// 	读者们也可以自行尝试在计算拷贝节点的随机指针的同时计算其后继指针，这样只需要遍历两次。
	/// 空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	///	结果
	/// 时间 20 ms 击败 87.5%
	/// 内存 15.1 MB 击败 62.5%
	private func copyRandomList2(_ head: Node?) -> Node? {
		
		guard head != nil else { return nil }

		// 循环链接，得到：A->A′->B->B′
		var node1 = head
		
		while node1 != nil {
			let nodeCopy = Node(node1!.val)
			nodeCopy.next = node1?.next
			node1?.next = nodeCopy
			node1 = node1?.next?.next
		}

		// 循环拷贝 A-T 到 A′->T′
		var node2 = head
		
		while node2 != nil {
			let nodeCopy = node2?.next
			// node2?.random?是原来的随机节点，node2?.random?.next就是随机节点的copy节点了
			nodeCopy?.random = node2?.random?.next
			node2 = node2?.next?.next
		}

		// 拆分节点
		var node3 = head
		let node = head?.next
		
		while node3 != nil {
			let nodeCopy = node3?.next
			// 拆分 A->A′ 节点，将A->A′->B 变为 A->B A′->B
			node3?.next = node3?.next?.next
			// 拆分 A′->B 节点，将 A′->B 变为 A′->B′
			// 不能与第2句调换顺序，因为这行执行后会丢掉中间的一个原来节点的指针，eg:A->A'->B->B'执行后就会变为A->A'->B'，node3为A，如果在这句后面执行的话,node3?.next?.next得到的就是B’,而不是B
			nodeCopy?.next = nodeCopy?.next?.next
			
			node3 = node3?.next
		}

		return node
	}
	
	/// 方法三：迭代 + 节点拆分 优化版
	///
	/// 思路
	///
	/// 注意到方法一需要使用哈希表记录每一个节点对应新节点的创建情况，而我们可以使用一个小技巧来省去哈希表的空间。
	///	我们首先将该链表中每一个节点拆分为两个相连的节点，例如对于链表 A→B→C，我们可以将其拆分为 A→A′→B→B′→C→C′。对于任意一个原节点 S，其拷贝节点 S′ 即为其后继节点。
	///
	///	这样，我们可以直接找到每一个拷贝节点 S′ 的随机指针应当指向的节点，即为其原节点 S 的随机指针指向的节点 T 的后继节点 T′。
	///	需要注意原节点的随机指针可能为空，我们需要特别判断这种情况。
	///
	///	然后断掉 A→A′→B→B′，直接拆分为 A→B 和 A′→B′
	///	同样需要注意最后一个拷贝节点的后继节点为空，我们需要特别判断这种情况。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 是链表的长度。我们只需要遍历该链表两次次。
	/// 空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	///	结果
	/// 时间 20 ms 击败 87.5%
	/// 内存 15.1 MB 击败 62.5%
	private func copyRandomList3(_ head: Node?) -> Node? {
		
		guard head != nil else { return nil }

		// 循环链接，得到：A->A′->B->B′
		var node1 = head
		
		while node1 != nil {
			let nodeCopy = Node(node1!.val)
			nodeCopy.next = node1?.next
			node1?.next = nodeCopy
			node1 = node1?.next?.next
		}

		// 循环拷贝 A-T 到 A′->T′
		var node2 = head
		let node = head?.next
		
		while node2 != nil {
			
			let nodeCopy = node2?.next
			
			// node2?.random?是原来的随机节点，node2?.random?.next就是随机节点的copy节点了
			nodeCopy?.random = node2?.random?.next
			
			// 拆分 A->A′ 节点，将A->A′->B 变为 A->B A′->B
			node2?.next = node2?.next?.next
			
			// 拆分 A′->B 节点，将 A′->B 变为 A′->B′
			// 不能与第2句调换顺序，因为这行执行后会丢掉中间的一个原来节点的指针，eg:A->A'->B->B'执行后就会变为A->A'->B'，node3为A，如果在这句后面执行的话,node3?.next?.next得到的就是B’,而不是B
			nodeCopy?.next = nodeCopy?.next?.next
			
			node2 = node2?.next
		}

		return node
	}
	
}
