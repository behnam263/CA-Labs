import glob,os
from shutil import copyfile
finput=open('template.txt')
dir_path=os.path.dirname(os.path.realpath(__file__))
os.chdir(dir_path)


for file in glob.glob("*.uvprojx"):
    print(file)
    fproj=open(file, 'r+')
    break
projectfiletext=fproj
placeofgroups=projectfiletext.read().find('<Groups>')

projectfiletext.seek(0)
readfromfirst=projectfiletext.read(placeofgroups+10)
projectfiletext.seek(placeofgroups+89)
totheend=projectfiletext.read()
#projectfiletext.seek(placeofgroups+10)
#projectfiletext.seek(len(f.read()))

with open(file, "w") as outf:
    outf.write(readfromfirst)
    #outf.seek(len(readfromfirst))
    outf.write(finput.read())
    outf.write(totheend)


finput.close()
fproj.close()

copyfile(dir_path+"\\startup_LPC17xx.s",dir_path+"\\RTE\\Device\\LPC1768\\startup_LPC17xx.s")