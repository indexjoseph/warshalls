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
#   $s0 --
#   $a0 -- 
########################################################################### 

la $s0, matrix # load matrix into register
mov $a0, $s0 # move matrix into register
jal displayMatrix # jump to displayMatrix


#----------------------------- Display Matrix ---------------------------------
displayMatrix:
    add $sp, $sp, -4 # allocate space on stack
    sw $s0, 0($sp) # save return address

    add $t0, $a0, $zero # load 0 into register

    lw $s0, 0($sp) # load return address from stack
    add $sp, $sp, 4 # deallocate space on stack

#----------------------------- Warshalls Algorithm ---------------------------=
transitiveClosure:
    