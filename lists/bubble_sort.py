def bubble_sort(lst):
    sorted = False
    while not sorted:
        sorted = True
        for idx in range(0, len(lst) - 1):
            if lst[idx] > lst[idx + 1]:
                lst[idx], lst[idx + 1] = lst[idx + 1], lst[idx]
                sorted = False



if __name__ == "__main__":
    # lst = map(
    #     int,
    #     raw_input('Enter comma-separated list values: ').split(',')
    # )
    lst = [238, 43, 2, 35, 8, 90, 9, 2838, 7, 3, 2, 5, 8, 3, 8, 0, 54, 3, 4, 6]
    sorted_lst = sorted(lst[:])

    print(lst)
    bubble_sort(lst)
    print(lst)

    print(lst == sorted_lst)

