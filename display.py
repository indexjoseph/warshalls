import sys

# Read input from the redirected file
graphList = []
fileInput = "warshalls-input"
fileOutput = "warshalls-output"
vertices = 3
beforeFileContent = "digraph warshalls-input{\n"
afterFileContent = "digraph warshalls-output{\n"

for line in sys.stdin:
    # Process each line as needed
    if(len(line.strip()) != 0):
        graphList.append(line.strip())
        print(line.strip())

beforeList = graphList[:3]
afterList = graphList[3:]

for i in range(len(beforeList)):
    beforeFileContent += "\t" + str(i) + "[label=\"" + str(i) + "\"]\n"
    afterFileContent += "\t" + str(i) + "[label=" + str(i) + "]\n"

for i in range(len(beforeList)):
    row = beforeList[i].split()
    for j in range(len(row)):
        if(row[j] == "1"):
            beforeFileContent += "\t" + str(i) + "->" + str(row[j]) + "\n"
beforeFileContent += "}"

for i in range(len(afterList)):
    row = afterList[i].split()
    for j in range(len(row)):
        if(row[j] == "1"):
            afterFileContent += "\t" + str(i) + "->" + str(row[j]) + "\n"
afterFileContent += "}"


with open(fileInput, "w") as f:
    f.write(beforeFileContent)

with open(fileOutput, "w") as f:
    f.write(afterFileContent)




