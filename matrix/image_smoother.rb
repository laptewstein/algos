# Given a 2D integer matrix M representing the gray scale of an image. Smoother the image. 
# Make the grayscale (0-255) of each cell to become the average (rounding down) of all the 8 surrounding cells + self. 
# If cell has less than 8 surrounding cells, then use as many as possible can.

# Example:
# Input: img = [[100,200,100],[200,50,200],[100,200,100]]
# Output: [[137,141,137],[141,138,141],[137,141,137]]
# Explanation:
# For the points (0,0), (0,2), (2,0), (2,2): floor((100+200+200+50)/4) = floor(137.5) = 137
# For the points (0,1), (1,0), (1,2), (2,1): floor((200+200+50+200+100+100)/6) = floor(141.666667) = 141
# For the point (1,1): floor((50+200+200+200+200+100+100+100+100)/9) = floor(138.888889) = 138

class Solution(object):
    def imageSmoother(self, M):
        if not M: return M
        new = [[0 for _ in range(len(M[0]))] for _ in range(len(M))]
        directions = ((0, 0), (0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (-1, -1), (-1, 1), (1, -1))
        for i in range(len(new)):
            for j in range(len(new[0])):
                total = 0
                count = 0
                for r, c in directions:
                    if i + r < 0 or j + c < 0 or i + r >= len(M) or j + c >= len(M[0]):
                        continue
                    total += M[i + r][j + c]
                    count += 1
                new[i][j] = total/count
        return new
