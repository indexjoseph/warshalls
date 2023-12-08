###############################################################################
#
# Authors: Charles Barth and Joseph Oladeji
#
# Date: 12/3/2023
# 
# Assignment: Warshalls Algorithm (Honors Project)
#
# Description: In this project we were tasked with implementing Warshalls 
# Algorithm. This algorithm uses a register and each bit to store the values of 
# the adjacency matrix. The algorithm is used to find the transitive closure of 
# a graph. This program will display the before and after of the transitive 
# closure of the graph.
#
###############################################################################

.data

newline: .asciiz "\n"
space: .asciiz " "
debug: .asciiz "DEBUG"
beforeGraph: .asciiz "\nBefore:\n"
afterGraph: .asciiz "\nAfter:\n"

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

# # 3x3 graph
# li $s0, 3 # row size
# li $s1, 43 # load matrix into register

# # 4x4 graph
# li $s0, 4 # row size
# li $s1, 16916 # load matrix into register

# 5x5 graph
li $s0, 5 # row size
li $s1, 13107250 # load matrix into register

# mov $a0, $s0 # move matrix into register
# jal displayMatrix # jump to displayMatrix
li $s2, 0 # k
li $s5, 1 # mask for printing bits
li $s6, 0 # flag representing if transitive closure has been clompleted


#----------------------------- Display Matrix ---------------------------------


la $a0, beforeGraph
li $v0, 4
syscall

displayMatrixSetup:
    li $t0, 0 # index for displayMatrix
    mul $s7, $s0, $s0 # num loops for printing matrix
    li $s5, 1
    add $t3, $s1, $zero

displayMatrix:
    li      $s5,    1
    bge     $t0,    $s7,    endDisplayMatrix

    # if t0 % s0 == 0 then print new line
    div     $t1,    $t0,     $s0
    mfhi    $t2
    bne     $t2,    $zero,   printBit

    la      $a0,    newline
    li      $v0,    4
    syscall

printBit:
    and     $t2,    $t3,    $s5 # t2 = graph[i][j] & mask
    move    $a0,    $t2 # move graph[i][j] & mask into $a0
    li      $v0,    1
    syscall

    # print space
    la      $a0,    space
    li      $v0,    4
    syscall

    addi $t0, $t0, 1
    sll $s5, $s5, 1 # shift mask left by 1
    srl $t3, $t3, 1 # shift matrix left by 1
    j displayMatrix

endDisplayMatrix:
    la     $a0,    newline
    li      $v0,    4
    syscall

    bne $s6, $zero, end # if flag is 1 then end



#----------------------------- Warshalls Algorithm ---------------------------=
transitiveClosure:
    bge $s2, $s0, endTransitiveClosure # if k >= n then end

    li $s3, 0 # i
    

iLoop:
    bge $s3, $s0, restartTransitiveClosure # if i >= n then end

    li $s4, 0 # j

jLoop:
    bge $s4, $s0, restartILoop # if j >= n then end

    li $t0, 1 # mask for graph[i][j]
    li $t1, 1 # mask for graph[i][k]
    li $t2, 1 # mask for graph[j][k]

    mul $t3, $s3, $s0 # i * n
    add $t3, $t3, $s4 # i * n + j
    sll $t0, $t0, $t3 # mask for graph[i][j]

    mul $t4, $s3, $s0 # i * n
    add $t4, $t4, $s2 # i * n + k
    sll $t1, $t1, $t4 # mask for graph[i][k]

    mul $t5, $s2, $s0 # k * n
    add $t5, $t5, $s4 # k * n + j
    sll $t2, $t2, $t5 # mask for graph[j][k]

    and $t0, $s1, $t0 # graph[i][j]
    and $t1, $s1, $t1 # graph[i][k]
    and $t2, $s1, $t2 # graph[j][k]

    srl $t0, $t0, $t3 # shift graph[i][j] right by i * n + j
    srl $t1, $t1, $t4 # shift graph[i][k] right by i * n + k
    srl $t2, $t2, $t5 # shift graph[j][k] right by j * n + k

    and $t6, $t1, $t2 # graph[i][k] & graph[j][k]
    or $t0, $t0, $t6 # graph[i][j] | (graph[i][k] & graph[j][k])

    sll $t0, $t0, $t3 # shift graph[i][j] left by i * n + j
    or $s1, $s1, $t0 # graph[i][j] = graph[i][j] | (graph[i][k] & graph[j][k])
    

    addi $s4, $s4, 1
    j jLoop

restartILoop:
    addi $s3, $s3, 1 
    j iLoop

restartTransitiveClosure:
    addi $s2, $s2, 1
    j transitiveClosure

endTransitiveClosure:
    li $s6, 1 # set flag to 1
    la $a0, afterGraph
    li $v0, 4

    syscall
    li $t0, 0

    j displayMatrixSetup

end:
    li $v0, 10
    syscall