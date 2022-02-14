# 1. Check if a String is a Palindrome (ie. Reversing a String)

arr = [
    "The quick brown fox jumped over the sleeping dog",
    "Oozy rat in a sanitary zoo",
    "Carla loves chocolate"
]

def palindrome(line):
    lowerline = line.lower()
    str       = lowerline.replace(" ", "")
    line_reversed = ''.join(reversed(str))
    return line_reversed == str

for line in arr:
    print(palindrome(line))


# 2. Find the Most Frequent Item in an Array
arr = [2, 'b', 1, 'a', 2, 6, 'a', 3, 'b', 2, 9, 3, 2, 'b']

def frequent_item(list):
    # for element in arr count how many times it shows up in an arr
    # if we alredy seen the element -> skip
    element_dict = {}
    # steps:
    # 1. for each elem in array
    for element in arr:

        # 2. if elem in dict: skip ( we already counted these)
        if element in element_dict: continue

        # 3. if element not in dict:
        # 4. count how many times its there
        count = arr.count(element)

        # 5. set it in the dict
        element_dict[element] = count

    # 6. return the key with highest count (value)
    max_value = max([ value for value in element_dict.values() ])

    final_dict = {}
    for key, value in element_dict.items():
        if value == max_value:
            final_dict[key] = value
    return final_dict

print( frequent_item(arr) )
# => {2: 4}

# https://javascript.plainenglish.io/the-3-most-common-intern-coding-challenge-questions-and-how-to-solve-them-25be4f20abe6