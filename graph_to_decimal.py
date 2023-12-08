###############################################
# Authors: Charles Barth and Joseph Oladeji
# Description: This program takes a 2D list representing a graph and converts it to a decimal 
#              integer The least significant bit is the top left corner of the graph
###############################################

# # 3x3 graph
# graph = [
#     [1, 1, 0],
#     [1, 0, 1],
#     [0, 0, 0],
# ]

# 4x4 graph
graph = [
    [0,0,1,0],
    [1,0,0,0],
    [0,1,0,0],
    [0,0,1,0],
]

# 5x5 graph
# graph = [
#     [0,1,0,0,1],
#     [1,0,0,0,0],
#     [0,0,0,0,0],
#     [0,0,0,0,1],
#     [0,0,1,1,0],
# ]

binary_list = [num for sublist in graph for num in sublist]
binary_list.reverse() # Reverse the list to so top left is the least significant bit
binary_str = ''.join(map(str, binary_list))  # Convert the list to a string
decimal_int = int(binary_str, 2)  # Convert the binary string to an integer

print(decimal_int)