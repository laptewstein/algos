"""
Print first n elements from a fibonacci sequence
"""


def fibonacci_gen():
    """
    Fibonacci Generator
    """
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b


def first_n_elements(steps, gen):
    return map(
        next,
        (gen for _ in range(steps))
    )


if __name__ == '__main__':
    steps = first_n_elements(
        steps=20,
        gen=fibonacci_gen()
    )
    print(list(steps))