//
//  344. 反转字符串.swift
//  Algorithms
//
//  Created by Leo on 2022-11-26.
//
//  https://leetcode.cn/problems/reverse-string

/*
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

 示例 1：
 输入：s = ["h","e","l","l","o"]
 输出：["o","l","l","e","h"]
 
 示例 2：
 输入：s = ["H","a","n","n","a","h"]
 输出：["h","a","n","n","a","H"]
  
 提示：
 1 <= s.length <= 105
 s[i] 都是 ASCII 码表中的可打印字符
 */

extension Algorithm {
    static func test344() {
        var s: [Character] = ["h","e","l","l","o"]
//        var s: [Character] = ["H","a","n","n","a","h"]
        Solution().reverseString(&s)
        print(s)
    }
}

extension Solution {
    
    /// 单指针（简化双指针）
    /// 时间复杂度：O(N)，其中 N 为字符数组的长度。一共执行了 N/2 次的交换。
    /// 空间复杂度：O(1)。只使用了常数空间来存放若干变量。
    /// 时间 132 ms 击败 88.33%
    /// 内存 18.2 MB 击败 31.66%
    func reverseString(_ s: inout [Character]) {
        
        let count = s.count
        let half = count / 2
        
        for i in 0 ..< half {
            (s[i], s[count - 1 - i]) = (s[count - 1 - i], s[i])
        }
    }
    
    /// 标准双指针
    func reverseString1(_ s: inout [Character]) {
        var l = 0, r = s.count - 1
        
        // 时间 136 ms 击败 73.33%
        // 内存 17.7 MB 击败 96.67%
        while l < r {
            (s[l],s[r]) = (s[r], s[l])
            l += 1
            r -= 1
        }
        
//        // 时间 136 ms 击败 73.33%
//        // 内存 17.9 MB 击败 84.44%
//        while l < r {
//            let temp = s[l]
//            s[l] = s[r]
//            s[r] = temp
//            l += 1
//            r -= 1
//        }
    }
}
