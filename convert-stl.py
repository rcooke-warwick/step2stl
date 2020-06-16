from OCC.STEPControl import STEPControl_Reader
from OCC.StlAPI import StlAPI_Writer
import sys

input_file  = sys.argv[1][0]   
output_file = sys.argv[1][1]   


step_reader = STEPControl_Reader()
step_reader.ReadFile( input_file )
step_reader.TransferRoot()
myshape = step_reader.Shape()
print("File read")

# Export to STL
stl_writer = StlAPI_Writer()
stl_writer.SetASCIIMode(True)
stl_writer.Write(myshape, output_file)
print("Written")

