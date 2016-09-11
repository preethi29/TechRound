module AreAnagrams
    def self.are_anagrams?(string_a, string_b)
        unless (string_a.is_a? String) && (string_b.is_a? String)
            puts 'Provide input as a string'
            return false
        end
        if string_a.nil? || string_b.nil?
            return string_a.nil? && string_b.nil?
        end
        if string_a.eql? string_b
            return true
        end
        if string_a.length != string_b.length
            return false
        end

        chars = Hash.new
        string_a.each_char { |char|
            chars[char].nil? ? chars[char] = 1 : chars[char] +=1
        }
        string_b.each_char { |char|
            if chars[char].nil?
                return false
            else
                chars[char] ==1 ? chars.delete(char) : chars[char] -=1
            end
        }
        return true
    end
end