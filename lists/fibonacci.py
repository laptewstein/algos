
def fibonacci():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b


f = fibonacci()
# print first 20 elements
print(list(map(
    next,
    (f for _ in range(20))
)))
