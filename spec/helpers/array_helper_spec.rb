require 'spec_helper'

describe ArrayHelper do
    describe 'make_flat' do
        it 'should flatten the array' do
            flattened_array = ArrayHelper.make_flat([3, 1,[2,4,[6]], 5])
            expect(flattened_array).to eq([1,2,3,4,5,6])

            flattened_array = ArrayHelper.make_flat([])
            expect(flattened_array).to eq([])
        end
    end
end