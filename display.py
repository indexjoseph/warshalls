import sys
import os

# Read input from the redirected file
graphList = []
fileInput = "warshalls_in.dot"
fileOutput = "warshalls_out.dot"
vertices = 3
beforeFileContent = "digraph warshalls_input{\n"
afterFileContent = "digraph warshalls_output{\n"

for line in sys.stdin:
    # Process each line as needed
    if(len(line.strip()) != 0):
        graphList.append(line.strip())

# Get the list of vertices before transitive closure
beforeList = graphList[1:4]

# Get the list of vertices after transitive closure
afterList = graphList[4:]


for i in range(len(beforeList)):
    beforeFileContent += "\t" + str(i) + "[label=\"" + str(i) + "\"]\n"
    afterFileContent += "\t" + str(i) + "[label=" + str(i) + "]\n"

for i in range(len(beforeList)):
    rowBefore = beforeList[i].split()
    rowAfter = afterList[i].split()
    for j in range(len(rowBefore)):
        if(rowBefore[j] == "1"):
            beforeFileContent += "\t" + str(i) + "->" + str(j) + "\n"
        if(rowAfter[j] == "1"):
            afterFileContent += "\t" + str(i) + "->" + str(j) + "\n"

beforeFileContent += "}"
afterFileContent += "}"


with open(fileInput, "w") as f:
    f.write(beforeFileContent)

with open(fileOutput, "w") as f:
    f.write(afterFileContent)

os.system("dot -Tpng " + fileInput + " -o " + fileInput + ".png")
os.system("dot -Tpng " + fileOutput + " -o " + fileOutput + ".png")


