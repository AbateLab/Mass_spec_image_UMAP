# Run order:1, parse imzML file to csv
library(Cardinal)
library(data.table)
filename='./demo' #filename from bruker. No need to change anything else

# don't change below
path <- paste0(filename,".imzML")
path2 <- paste0(filename,".dat")
path3 <- "./demo.csv"
crd = read.csv(file='./testCoord.csv', header=FALSE, sep=',')
crd = as.matrix(crd);
crdy=crd[2,] + 110 #offset of origin
crdx=crd[1,] + 914 #offset of origin
mse <-readMSIData(path,attach.only=TRUE)
selindex <- pixels(mse, coord=list(x=crdx, y=crdy))
mse=mse[,selindex]

s <- spectra(mse)
ssum <- colSums(s)
id <- which(ssum>0)
mse<-mse[,id]

mse <- normalize(mse, method="tic")
mse <- mzAlign(mse)
mse <- process(mse)

msspec <- spectra(mse)
msmat <- msspec[,]
matsize <-dim(msmat)
to.write <- file(path2,'wb')
writeBin(matsize,to.write)
mzlist<-mz(mse)
writeBin(mzlist,to.write)
xydata<-coord(mse)
xydatamat<-data.matrix(xydata)
xydatavec<-as.vector(xydatamat)
writeBin(xydatavec,to.write)
close(to.write)
fwrite(msmat,path3,row.names=FALSE,col.names=FALSE)
