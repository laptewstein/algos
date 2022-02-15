import heapq

sorted_lists = [ [10, 15, 30], [12, 15, 20], [17, 20, 32] ]
expected_merged_list = [10, 12, 15, 15, 17, 20, 20, 30, 32]

def merge(lists):
    merged_list = []

    # populate initial heap with indexes pointing to minimum value in sorted lists (first element)
    heap = [(lst[0], i, 0) for i, lst in enumerate(lists) if lst]
    # reorder tuples by value (think of these numbers as next highest in sorted array)
    heapq.heapify(heap)

    while heap:
        # pop lowest value
        val, list_ind, element_ind = heapq.heappop(heap)

        merged_list.append(val)

        # assuming this is not the last element in original nested array
        if element_ind + 1 < len(lists[list_ind]):
            # read next value and push into the heap
            # basically reading next elements from the same array
            # until next lowest comes from another nested list
            # which we will traverse as well until next highest
            # points to another list, or the entire heap depletes.
            next_tuple = (lists[list_ind][element_ind + 1],
                          list_ind,
                          element_ind + 1)
            heapq.heappush(heap, next_tuple)
    return merged_list


print(merge(sorted_lists))
print(merge(sorted_lists) == expected_merged_list)