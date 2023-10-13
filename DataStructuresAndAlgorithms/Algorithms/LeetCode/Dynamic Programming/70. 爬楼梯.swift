//
//  70. 爬楼梯.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/10.
//

/*
 
 https://leetcode.cn/problems/climbing-stairs/description/
 
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

 示例 1：
 输入：n = 2
 输出：2
 解释：有两种方法可以爬到楼顶。
		1. 1 阶 + 1 阶
		2. 2 阶
 
 示例 2：
 输入：n = 3
 输出：3
 解释：有三种方法可以爬到楼顶。
		1. 1 阶 + 1 阶 + 1 阶
		2. 1 阶 + 2 阶
		3. 2 阶 + 1 阶
  
 提示：
 1 <= n <= 45
 
*/

import Foundation

extension Algorithm {
	
	static func test70() {
		let res = Solution().climbStairs(6)
		print(res)
	}
}

/*
 解题步骤：
	1. DP数组及下标的含义
		a. DP数组：dp[i]
		b. 下标i：第i个阶
		c. DP数组含义：达到第i阶有dp[i]种方法
	2. 递推公式
		dp[i] = dp[i - 2] + dp[i - 1]
	3. DP数组如何初始化
		dp[1] = 1
		dp[2] = 2
		dp[0] = 0 在意义上说得通，dp[0] = 1 可以跑得通代码，但是本身n是正整数，不存在0的情况，所以忽略
	4. 遍历顺序
		从前向后遍历
	5. 打印DP数组
 
 分析后可得出是一个斐波那契数列
 
 */

extension Solution {
	
	/// 方法一：动态规划
	///
	///	时间复杂度：O(n)
	///	空间复杂度：O(1)
	///
	/// 时间 0 ms   击败 100%
	/// 内存 13 MB 击败 80.33%
	func climbStairs(_ n: Int) -> Int {
		
		if n < 2  { return 1 }
		if n == 2 { return 2 }
		
		var a = 1, b = 2
		
		for _ in 3 ... n {
			let sum = a + b
			a = b
			b = sum
		}
		
		return b
	}
}
