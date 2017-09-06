str1=raw_input("Enter name of inputfile: \n")
str2=raw_input("Enter name of outputfile: \n")

f = open(str1,"r+")
f2 = open(str2,"w")
# f3 = open("en-ra.data","w")

data = f.readlines()


n = len(data)
m=0
print n
for i in range(0,n-1):
    line = data[i]
    line = line.strip()
    print line
    m=m+1
    if line=="LevI-LevF   I- J / Parity -F     Energy (eV)     Rate (1/s)    Total Rate (1/s)":
        break

print m

result2 = []
nn=0
level1=[]
level2=[]
auger_ra=[]
auger_en=[]
for x in range(m+1,n-1):

    result = data[x]
    if result[1]!='-':
        nn = nn + 1
        result=result[0:14].replace('-',' ')+result[20:65]+'\n'
#        result=result[0:30].replace('/',' ')+result[30:len(result)]
#        f2.write(result[30:65]+'\n')
#        result=result[0:14]+result[30:65]+'\n'
        f2.write(result)
        level1.append(result.strip().split()[0])
        level2.append(result.strip().split()[1])
        auger_en.append(result.strip().split()[4])
        auger_ra.append(result.strip().split()[5])
#        f3.write(result2)
    else:
        break


"""
num=[level1[0]]
nnn=0
test=level1[0]
for s in range(0,nn-1):
	if test==level1[s]:
		pass
	else:
		test=level1[s]
		nnn=nnn+1
		num.append(test)


print nnn, num


Total = []
for ss in range(0,nnn):
	total = 0.0
	for sss in range(0,nn-1):
		if num[ss]==level1[sss]:
			total = total +float(auger_ra[sss])
	Total.append(total)

print Total
"""
f.close()
f2.close()
