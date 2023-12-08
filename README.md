# Warshalls Honors Contract

## Date: 12/3/2023

## Authors: Charles Barth and Joseph Oladeji

## Description

In this project we were tasked with implementing Warshalls
Algorithm. This algorithm uses a register and each bit to store the values of
the adjacency matrix. The algorithm is used to find the transitive closure of
a graph. This program will display the before and after of the transitive
closure of the graph.

There is a python script called graph_to_decimal.py that will convert a 2d array
into a decimal number. This is used to convert the adjacency matrix into a
decimal number that can be stored in a register. The top left element in the
matrix is the least significant bit and the bottom right element is the least
significant bit.

## Usage

```bash
spim -f warshalls.asm | python3 display.py  
```

## Requirements

GraphViz - <https://graphviz.org/>

## How to download?

pip (or pip3) install graphviz
