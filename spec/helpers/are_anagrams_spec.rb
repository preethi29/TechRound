require 'spec_helper'

describe AreAnagrams do
    it 'should return false if any of the inputs are not string' do
        are_anagrams = AreAnagrams.are_anagrams? 'abc', 1
        expect(are_anagrams).to be false
    end

    it 'should return false if inputs are of unequal length' do
        are_anagrams = AreAnagrams.are_anagrams? 'mam', 'madam'
        expect(are_anagrams).to be false
    end

    it 'should return true if inputs are anagrams' do
        are_anagrams = AreAnagrams.are_anagrams? 'orchestra', 'carthorse'
        expect(are_anagrams).to be true
        are_anagrams = AreAnagrams.are_anagrams? 'orchestra', 'orchestra'
        expect(are_anagrams).to be true
    end
end
