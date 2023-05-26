//
//  3. 无重复字符的最长子串.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-20.
//
//  https://leetcode.cn/problems/longest-substring-without-repeating-characters/

extension Algorithm {
    static func test3() {
        let str = "abba"
        print(Solution().lengthOfLongestSubstring1(str))
    }
}

extension Solution {
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var dic = [Character: Int]()
        var start = 0
        var result = 0
        
        for (index, char) in s.enumerated() {
            // 如果发现重复字符，重置窗口起始位到之前保存字符的下一位
            if let previousIndex = dic[char] {
                // 重复字符的index可能比当前start更靠前，这时不需要再往前重置，否则必然包含重复字符(abba)
                start = max(previousIndex + 1, start)
            }
                        
            dic[char] = index
            // 当前窗口长度为index - start + 1, 判断是否需要更新最大长度
            result = max(result, index - start + 1)
        }
        return result
    }
    
    func lengthOfLongestSubstring1(_ s: String) -> Int {
        var res = 0, arr = [Character]()
        for c in s {
            if let index = arr.firstIndex(of: c) {
                arr.removeFirst(index + 1)
            }
            arr.append(c)
            res = max(arr.count, res)
        }
        return res
    }
}
