library(Seurat)
MyData <- read.csv(file='./ExtractedDGE_demo.csv', header=TRUE, sep=',', row.names = 1)
mzlist <- read.csv(file='mzlist.txt',header=FALSE)
mzlist <- as.character(mzlist[,1])
pbmc <- CreateSeuratObject(counts = MyData, project = "TAL")
pbmc <- ScaleData(pbmc, features=mzlist)

pbmc <- FindNeighbors(pbmc,features=mzlist,dims=NULL)
pbmc <- FindClusters(pbmc, resolution =1, genes.use=mzlist)
pbmc <- RunUMAP(pbmc,  features=mzlist)

DimPlot(pbmc, reduction = "umap",label=TRUE)

