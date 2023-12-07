###############################################################################
#
# Authors: Charles Barth and Joseph Oladeji
#
# Date: 12/3/2023
# 
# Assignment: Warshalls Algorithm (Honors Project)
#
# Description: In this project we were tasked with implementing Warshalls 
# Algorithm. This algorithm uses a register and each bit
# to store the values of the adjacency matrix. The algorithm is used to find
# the transitive closure of a graph. This program will display the before and
# after of the transitive closure of the graph.
#
###############################################################################

.data

newline: .asciiz "\n"
space: .asciiz " "

#----------------------------- Text Segment -----------------------------------
.text

.globl main

#----------------------------- Main -------------------------------------------
main:

###########################################################################
# main:
#  Main procedure that calls the display matrix procedure and the warshalls
#  algorithm procedure.
#
# Register Legend
#   $s0 -- row size
#   $s1 -- matrix
#   $s2 -- k
#   $s3 -- i
#   $s4 -- j
#   $a0 -- 
########################################################################### 

li $s0, 3 # row size
li $s1, 46 # load matrix into register
# mov $a0, $s0 # move matrix into register
# jal displayMatrix # jump to displayMatrix
li $s2, 0 # k
li $s5, 1 # mask for printing bits
li $s6, 0 # flag representing if transitive closure has been clompleted

#----------------------------- Display Matrix ---------------------------------
# displayMatrix:
#     li $t0, -1

# outerLoop:
#     # Print Newline
#     la      $a0,    newline
#     li      $v0,    4
#     syscall 

#     # Check if rowNum is greater than number of rows and exit if so
#     bge     $t0,    $s0,    exitOuterLoop
    
#     # Inner loop index
#     li      $t2,    0

# innerLoop:
#     bge $t2, $s0, outerLoop
#     add $t1, $s1, $zero
#     and $t2, $t1, 0x1

#     # Increment inner loop by 1
#     addi $a0, $t2, $zero
#     li      $v0,    4
#     syscall 
#     srl $t1, $t1, 1 
#     j innerLoop

# exitOuterLoop:

displayMatrix:
    li $t0, 0
    bge $t0, $s0, endDisplayMatrix

    li $s5, 1

    # if t0 % s0 == 0 then print new line
    div $t1, $t0, $s0
    mfhi $t2
    beq $t2, $zero, printNewLine


printBit:
    and $t2, $s1, $s5 # t2 = graph[i][j] & mask
    move $a0, $t2 # move graph[i][j] & mask into $a0
    li      $v0,    1

    # print space
    la      $a0,    space
    li      $v0,    4

    addi $t0, $t0, 1
    sll $s5, $s5, 1 # shift mask left by 1
    j displayMatrix

printNewLine:
    la      $a0,    newline
    li      $v0,    4
    syscall 

    j printBit

endDisplayMatrix:
    bne $s6, $zero, end # if flag is 1 then end



#----------------------------- Warshalls Algorithm ---------------------------=
transitiveClosure:
    bge $s2, $s0, endTransitiveClosure # if k >= n then end

    li $s3, 0 # i
    
    addi $s2, $s2, 1 
    

iLoop:
    bge $s3, $s0, transitiveClosure # if i >= n then end

    li $s4, 0 # j

jLoop:
    bge $s4, $s0, restartILoop # if j >= n then end

    li $t0, 1 # mask for graph[i][j]
    li $t1, 1 # mask for graph[i][k]
    li $t2, 1 # mask for graph[j][k]

    mul $t3, $s3, $s0 # i * n
    add $t3, $t3, $s4 # i * n + j
    sll $t0, $t0, $t3 # mask for graph[i][j]

    mul $t3, $s3, $s0 # i * n
    add $t3, $t3, $s2 # i * n + k
    sll $t1, $t1, $t3 # mask for graph[i][k]

    mul $t3, $s2, $s0 # k * n
    add $t3, $t3, $s4 # k * n + j
    sll $t2, $t2, $t3 # mask for graph[j][k]

    # t7 = graph[i][j], t8 = graph[i][k], t9 = graph[j][k]
    and $t5, $s1, $t0 # graph[i][j]
    and $t6, $s1, $t1 # graph[i][k]
    and $t8, $s1, $t2 # graph[j][k]

    # t10 = graph[i][j] | (graph[i][k] & graph[j][k])
    and $t9, $t6, $t8 # graph[i][k] & graph[j][k]
    or $s1, $t5, $t9 # graph[i][j] | (graph[i][k] & graph[j][k])
    

    addi $s4, $s4, 1 
    j jLoop

restartILoop:
    addi $s3, $s3, 1 
    j iLoop

endTransitiveClosure:
    li $s6, 1 # set flag to 1
    j displayMatrix

end:
    li $v0, 10
    syscall