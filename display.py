import graphviz

def parse_matrix(input_str):
    lines = input_str.strip().split('\n')
    matrix = []
    for line in lines:
        # Skip lines that do not represent matrix entries
        if any(char.isalpha() for char in line):
            continue
        matrix.append(list(map(int, line.split())))
    return matrix

def generate_dot_file(matrix, output_path='graph'):
    dot = graphviz.Digraph(comment='Matrix Graph')

    for i, row in enumerate(matrix):
        for j, value in enumerate(row):
            dot.node(f'{i}_{j}', str(4))
    
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if j + 1 < len(matrix[0]):
                dot.edge(f'{i}_{j}', f'{i}_{j+1}')
            if i + 1 < len(matrix):
                dot.edge(f'{i}_{j}', f'{i+1}_{j}')

    dot.render("./graph.dot", format='png', cleanup=True)

if __name__ == "__main__":
    input_str = """Before:
    1 1 0 
    1 0 1 
    0 0 0"""

    # Extract matrix from the input string
    matrix = parse_matrix(input_str)

    # Generate dot file and visualize using Graphviz
    generate_dot_file(matrix)
    print("Graph created successfully. Check the 'graph.png' file.")
