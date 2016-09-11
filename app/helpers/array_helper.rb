module ArrayHelper
    def self.make_flat(array)
        flattened_array =[]
        flatten(array, flattened_array)
        sort(flattened_array, 0, flattened_array.length-1)
        return flattened_array
    end

    def self.flatten(array, flattened_array)
        array.each { |item|
            (item.is_a? Array) ? flatten(item, flattened_array) : flattened_array.push(item)
        }
    end
    private_class_method :flatten

    def self.sort(arr, start_index, end_index)
        return if start_index >= end_index
        pivot = arr[start_index]
        i = start_index
        for j in (1+start_index)..end_index
            if arr[j] <= pivot
                temp = arr[i]
                arr[i] = arr[j]
                arr[j] = temp
                i += 1
            end
        end
        sort(arr, start_index, i-1)
        sort(arr, i+1, end_index)
    end
    private_class_method :sort
end