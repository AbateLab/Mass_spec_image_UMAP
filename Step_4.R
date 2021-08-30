library(Seurat)
MyData <- read.csv(file='./ExtractedDGE_demo.csv', header=TRUE, sep=',', row.names = 1)
mzlist <- read.csv(file='mzlist.txt',header=FALSE)
mzlist <- as.character(mzlist[,1])
pbmc <- CreateSeuratObject(counts = MyData, project = "TAL")
pbmc <- ScaleData(pbmc, features=mzlist)

pbmc <- FindNeighbors(pbmc,features=mzlist,dims=NULL)
pbmc <- FindClusters(pbmc, resolution =1, genes.use=mzlist)
pbmc <- RunUMAP(pbmc,  features=mzlist)


p1 <- DimPlot(pbmc, reduction = "umap",label=TRUE)
p2 <- FeaturePlot(pbmc,features='m/z 127')
p3 <- FeaturePlot(pbmc,features='m/z 169')
dev.new(width=10, height=4)
p1+p2+p3