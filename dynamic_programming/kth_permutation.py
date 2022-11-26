def factorial(n):
  if n == 0: 
    return 1
  return n * factorial(n - 1)

def getPermutation(n: int, k: int) -> str:
  def kth_perm(string, k): #[1,2,3], 2
    permutation = [] 
    length = len(string)
    fact = factorial(length)
    while (string != []): 
      fact = fact // length
      index, k = divmod(k, fact)
      x = string[index] 
      permutation.append(x) 
      string = string[:index] + string[index+1:] 
      length -= 1
    return "".join(permutation)
  return kth_perm([str(i) for i in range(1, n+1)], k-1)

def kth_permutation(n, k):
  permutation = []
  unused =  list(range(1, n + 1))
  factorial = [1] * (n + 1)
  for idx in range(1, n+1):
    factorial[idx] = idx * factorial[idx - 1]
  k -= 1
  while n > 0:
    part_length = factorial[n] // n
    idx = k // part_length
    permutation.append(unused[idx])
    unused.pop(idx)
    n -= 1
    k %= part_length
  return ''.join(map(str, permutation))

print(getPermutation(3,3)) # 213
print(getPermutation(4,9)) # 2314
print(getPermutation(3,1)) # 123

print(kth_permutation(3,3)) # 213
print(kth_permutation(4,9)) # 2314
print(kth_permutation(3,1)) # 123

