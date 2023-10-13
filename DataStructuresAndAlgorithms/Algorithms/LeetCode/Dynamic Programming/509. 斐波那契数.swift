//
//  509. 斐波那契数.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/10.
//

/*
 
 https://leetcode.cn/problems/fibonacci-number/description/
 
 斐波那契数 （通常用 F(n) 表示）形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：
 F(0) = 0，F(1) = 1
 F(n) = F(n - 1) + F(n - 2)，其中 n > 1
 给定 n ，请计算 F(n) 。

 示例 1：
 输入：n = 2
 输出：1
 解释：F(2) = F(1) + F(0) = 1 + 0 = 1
 
 示例 2：
 输入：n = 3
 输出：2
 解释：F(3) = F(2) + F(1) = 1 + 1 = 2
 
 示例 3：
 输入：n = 4
 输出：3
 解释：F(4) = F(3) + F(2) = 2 + 1 = 3
  
 提示：
 0 <= n <= 30
 
 */

import Foundation

extension Algorithm {
	
	static func test509() {
		let n = 6
		print(Solution().fib2(n))
	}
}

/*
 解题步骤：
	1. DP数组及下标的含义
		a. DP数组：dp[i]
		b. 下标i：第i个斐波那契数的值
		c. DP数组含义：第i个斐波那契数的值为dp[i]
	2. 递推公式
		dp[i] = dp[i - 1] + dpp[i - 2]
	3. DP数组如何初始化
		dp[0] = 1
		dp[1] = 1
	4. 遍历顺序
		从前向后遍历
	5. 打印DP数组
 
 思路（C++）
 vector<int> dp[n+1]
 dp[0] = 1; dp[1] = 1;
 for(i = 2; i <= n; i++)
	dp[i] = dp[i - 1] + dp[i - 2];
 return dp[n];
 最后处理边界情况（n <= 0）
 
 状态简化后：
 
 sum = dp[0] + dp[1]
 dp[0] = dp[1]
 dp[1] = sum

 */

extension Solution {

	/// 方法一：动态规划
	///
	///	时间复杂度：O(n)
	///	空间复杂度：O(1)
	///
	/// 时间 0 ms   击败 100%
	/// 内存 13.08 MB 击败 53%
	func fib(_ n: Int) -> Int {
		
		guard n > 1 else { return n }
		
		var a = 0, b = 1, i = 2
		
		while i <= n {
			let c = a + b
			a = b
			b = c
			i += 1
		}
		
		return b
	}
	
	/// 方法二：动态规划
	///
	///	时间复杂度：O(n^2)
	///	空间复杂度：O(n)
	///
	/// 太垃圾，会存在栈溢出的现象
	func fib2(_ n: Int) -> Int {
		guard n > 1 else { return n }
		return fib2(n - 1) + fib2(n - 2)
	}
	
}
