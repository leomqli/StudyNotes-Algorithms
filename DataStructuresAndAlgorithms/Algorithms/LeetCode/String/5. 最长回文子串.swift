//
//  5. 最长回文子串.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-22.
//
//  https://leetcode.cn/problems/longest-palindromic-substring

extension Algorithm {
    static func test5() {
//        let s = "ac"
        let s = "abad"
//        let s = "eabcb"
//        let s = "civilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth"
        print(Solution().longestPalindrome(s))
    }
}

extension Solution {
    
    // MARK: - 官方中心扩散法

    /// 时间复杂度：O(n^2) 时间 20ms   击败 91.54%
    /// 空间复杂度：O(1)   内存 13.7MB 击败 99.62%
    func longestPalindrome(_ s: String) -> String {
        
        if s.count < 2 {
            return s
        }
        
        var begin = 0, maxLen = 1
        let charArr = Array(s), length = s.count - 1
        
        print(charArr)
        print("")
        
        // 从左向右，每一个位置都去做中心扩散
        // 最后一个位置不需要枚举，因为不会再向右边扩散
        for i in 0 ..< length {
            print("第\(i)次循环")
            let oddLen  = expandCenter(charArr, i, i)
            let evenLen = expandCenter(charArr, i, i + 1)
            
            let curMaxLen = max(oddLen, evenLen)
            print("curMaxLen = \(curMaxLen)")
            if curMaxLen > maxLen {
                maxLen = curMaxLen
                begin = i - (maxLen - 1) / 2
            }
            print("begin = \(begin), maxLen = \(maxLen)\n")
        }
        
        return String(charArr[begin...begin + maxLen - 1])
    }
    
    /// 最长回文子串的长度
    /// - Parameters:
    ///   - array: 原始字符串的字符数组
    ///   - left:  起始左边界（包含）
    ///   - right: 起始右边界（包含）
    /// - Returns: 回文串长度
    func expandCenter(_ array: [Character],
                      _ left: Int,
                      _ right: Int) -> Int {
        
        var l = left, r = right
        
        // 当left = right时，    回文中心是一个字符，长度为奇数
        // 当right = left + 1时，回文中心是两个字符，长度为偶数
        // 以left为中心向两边扩散
        while l >= 0 && r < array.count && array[l] == array[r] {
            l -= 1
            r += 1
            print("666")
        }
        
        print("left = \(left), right = \(right), l = \(l), r = \(r), 长度为\(r - l - 1)")
        // 跳出循环时，array[l] != array[r], 即i和j的字符是不包含在内的
        // 所以此时的最长长度为(r - l + 1) - 2
        return r - l - 1
    }
    
    // MARK: - 最快中心扩散法
    
    /// 时间复杂度：O(n^2) 时间 12ms    击败 100%
    /// 空间复杂度：O(1)   内存 14.2 MB 击败 66.15%
    func longestPalindrome1(_ s: String) -> String {
        if s.count == 1 { return s }
        
        let length = s.count - 1, array = Array(s)
        var begin = 0, maxLen = 1, i = 0
        
        while (i <= length) {
            var l = i - 1, r = i
            
            while (r < length && array[r] == array[r + 1]) {
                r += 1
            }
            
            // 第一个不相等的元素
            r += 1
            // 下次开始循环的新元素下标
            i = r
            
            while (l >= 0 && r <= length && array[l] == array[r]) {
                l -= 1
                r += 1
            }
            
            let curMaxLen = r - l - 1
            if (curMaxLen > maxLen) {
                maxLen = curMaxLen
                begin = l + 1
            }
        }
        
        return String(array[begin...(begin + maxLen - 1)])
    }

    
    // MARK: - 暴力算法

    /// 我的暴力算法
    /// 会超时
    func longestPalindrome2(_ s: String) -> String {
        
        var left = 0, right = s.count - 1, result = ""
        let charArr = Array(s)
        
        while left < s.count {
            
            while right >= left {
                
                guard result.count < s.count - left else {
                    return result
                }
                
                // 判断截取后的字符串是不是回文串
                if validPalindrome(charArr, left, right) {
                    let startIndex = s.index(s.startIndex, offsetBy: left)
                    let endIndex   = s.index(s.startIndex, offsetBy: right)
                    result = String(s[startIndex...endIndex])
                }
                
                // 如果剩余的字符串长度和最终的字符串长度一样则不进行下去
                if result.count == right - left + 1 {
                    break
                }
                
                right -= 1
            }
            
            left += 1
            right = s.count - 1
        }
        
        return result
    }
    
    /// 官方暴力解法
    /// 时间复杂度：O(n^3) 时间 484ms  击败 21.16%
    /// 空间复杂度：O(n)   内存 14.2MB 击败 72.31%
    func longestPalindrome3(_ s: String) -> String {
        
        if s.count < 2 {
            return s
        }
        
        var begin = 0, maxLen = 1
        let charArr = Array(s)
        
        for i in 0 ..< s.count - 1 {
            for j in i + 1 ..< s.count {
                print("i == \(i), j == \(j)")
                if j - i + 1 > maxLen && validPalindrome(charArr, i , j) {
                    maxLen = j - i + 1
                    begin = i
                }
            }
        }
        
        let startIndex = s.index(s.startIndex, offsetBy: begin)
        let endIndex   = s.index(s.startIndex, offsetBy: begin + maxLen - 1)
        return String(s[startIndex...endIndex])
    }
    
    // 验证子串 s[left...right]是否为回文串
    func validPalindrome(_ s: [Character],
                         _ left: Int,
                         _ right: Int) -> Bool {
        var l = left, r = right
        
        while l < r {
            if s[l] != s[r] {
                return false
            }
            l += 1
            r -= 1
        }
        
        return true
    }
}
