#read in the q files
q2 <- read.csv("q_K2.txt", header=TRUE)
q3 <- read.csv("q_K3.txt", header=TRUE)
q4 <- read.csv("q_K4.txt", header=TRUE)
q5 <- read.csv("q_K5.txt", header=TRUE)
#read the population file
pops <- read.table("poporder.txt", header=FALSE)

#create a column of pops repeated twice for each individual in the q file
pops2 <- rbind(pops, pops)
pops3 <- rbind(pops, pops, pops)
pops4 <- rbind(pops, pops, pops, pops)
pops5 <- rbind(pops, pops, pops, pops, pops)

#combine q and pops info
q2pops <- cbind(pops2,q2)
q3pops <- cbind(pops3,q3)
q4pops <- cbind(pops4,q4)
q5pops <- cbind(pops5,q5)

#create a matrix for plotting
#q2
q2mat<-cbind(q2pops$mean[1:479], q2pops$mean[480:958])
#q2mat_prop<-cbind(q2mat[,2], q2mat[,3])
#transpose the matrix
q2mat_t<-t(q2mat)

#q3
q3mat<-cbind(q3pops$mean[1:479],q3pops$mean[480:958],q3pops$mean[959:1437])
dim(q3mat)
q3mat_t<-t(q3mat)


#q4
q4mat<-cbind(q4pops$mean[1:479], q4pops$mean[480:958], q4pops$mean[959:1437], q4pops$mean[1438:1916])
#q4mat_prop<-cbind(q4mat[,2], q4mat[,3])
#transpose the matrix
q4mat_t<-t(q4mat)

#q5
q5mat<-cbind(q5pops$mean[1:479], q5pops$mean[480:958], q5pops$mean[959:1437], q5pops$mean[1438:1916], q5pops$mean[1917:2395])
#q5mat_prop<-cbind(q5mat[,2], q5mat[,3])
#transpose the matrix
q5mat_t<-t(q5mat)

library(wesanderson)
cols = wes_palette(n=5, name="Darjeeling2")
#plot
par(mfrow=c(4,1))
barplot(q2mat_t, col=cols, space=0, xlim=c(1,479),border=NA,width=1,names.arg=pops$V1, ylab="K = 2",xlab="")

### pca ######################################################################################
##read in the files
gk2<-matrix(scan("g_K2.txt", n=39193*479,sep=","), nrow=479,ncol=39193,byrow=T)
gk3<-matrix(scan("g_K3.txt", n=39193*479,sep=","), nrow=479,ncol=39193,byrow=T)
gk4<-matrix(scan("g_K4.txt", n=39193*479,sep=","), nrow=479,ncol=39193,byrow=T)
gk5<-matrix(scan("g_K5.txt", n=39193*479,sep=","), nrow=479,ncol=39193,byrow=T)
g.avg<-(gk2+gk3+gk4+gk5)/4
head(g.avg)
dim(g.avg)
g.pca<-prcomp(g.avg, scale=TRUE)
plot(g.pca$x[,1], g.pca$x[,2])
pops<-read.table("temp_pops.txt", header=FALSE)
g.new<-cbind(pops$V1,g.avg)
g.pca<-prcomp(g.new[,-1], scale=TRUE)

## plot ##
family<-g.new[,1] #assign populations to families for coloring points in pca
par(mar=c(5,5,3.5,2))
mycols.list<-c("#999999","#999999","#999999","#E69F00","#56B4E9","#999999","#56B4E9","#56B4E9","yellowgreen","#999999","#E69F00","#E69F00","#56B4E9","#56B4E9","#999999","#999999","#999999","#999999","#E69F00","#56B4E9","#E69F00","#56B4E9","#56B4E9")
palette(mycols.list)
plot(g.pca$x[,1], g.pca$x[,2],cex.lab=3, cex.axis=1.5, col="grey20", pch=21,bg=family, xlab= "", ylab = "", cex=1.5)
title(main="(B) Plot of PCA ",cex.main = 2, adj=0)
legend(-20, 62, legend=c(expression(italic("L. idas")),expression(italic("L. melissa")),expression(paste("Jackson Hole",italic("-Lycaeides"))), expression(paste("Dubois", italic("-Lycaeides")))), fill=c("#E69F00", "#56B4E9", "#999999","yellowgreen"), cex=1.2)
title(xlab = "PC1 (2.4)%", cex.lab = 2,line = 3)
title(ylab = "PC2 (1.0)%", cex.lab = 2,line = 3)

### barplot ########
q = q2pops
qpop<-q[1:479,]
qpop<-cbind(qpop,g.pca$x[,1])
colnames(qpop)<-c("V1","mean","median","ci_lb","ci_ub","pcscores")
bld<-qpop[qpop$V1=='BLD',]
bcr<-qpop[qpop$V1=='BCR',]
bic<-qpop[qpop$V1=='BIC',]
bnp<-qpop[qpop$V1=='BNP',]
btb<-qpop[qpop$V1=='BTB',]
dbs<-qpop[qpop$V1=='DBS',]
frc<-qpop[qpop$V1=='FRC',]
pin<-qpop[qpop$V1=='PIN',]
psp<-qpop[qpop$V1=='PSP',]
rdl<-qpop[qpop$V1=='RDL',]
rnv<-qpop[qpop$V1=='RNV',]
hybrids<-rbind(bcr, bld, bic, bnp, btb, frc, pin,psp,rdl,rnv,dbs)
hyb<-droplevels(hybrids)
hybfactor<-factor(hyb$V1, levels=c("BLD","BCR","BIC","BNP","BTB","FRC","PIN","PSP","RDL","RNV","DBS"))

##plot ###
par(mar=c(9,7,3.5,2))
cols=c(rep("#999999",10),"yellowgreen")
boxplot(hyb$pcscores~hybfactor, col=cols, ylab="", cex.lab=2, cex.axis=1.5)
title(main="(C) Barplot for genetic variation",cex.main = 2, adj=0)
title(xlab=expression(paste("Jackson Hole",italic("-Lycaeides"))), cex.lab=2, line=3.5)
title(ylab="PC1 scores", cex.lab=2, line=3.5)

pdf("./pcabarplot.pdf",width=10,height=10)
layout(matrix(c(1,2,3,3), 2, 1, byrow = TRUE))
# pca
par(mar=c(5,5,3.5,2))
mycols.list<-c("#999999","#999999","#999999","#E69F00","#56B4E9","#999999","#56B4E9","#56B4E9","yellowgreen","#999999","#E69F00","#E69F00","#56B4E9","#56B4E9","#999999","#999999","#999999","#999999","#E69F00","#56B4E9","#E69F00","#56B4E9","#56B4E9")
palette(mycols.list)
plot(g.pca$x[,1], g.pca$x[,2],cex.lab=3, cex.axis=1.5, col="grey20", pch=21,bg=family, xlab= "", ylab = "", cex=1.5)
title(main="(B) Plot of PCA ",cex.main = 2, adj=0)
legend(-20, 62, legend=c(expression(italic("L. idas")),expression(italic("L. melissa")),expression(paste("Jackson Hole",italic("-Lycaeides"))), expression(paste("Dubois", italic("-Lycaeides")))), fill=c("#E69F00", "#56B4E9", "#999999","yellowgreen"), cex=1.2)
title(xlab = "PC1 (2.4)%", cex.lab = 2,line = 3)
title(ylab = "PC2 (1.0)%", cex.lab = 2,line = 3)

#barplot
par(mar=c(9,7,3.5,2))
cols=c(rep("#999999",10),"yellowgreen")
boxplot(hyb$pcscores~hybfactor, col=cols, ylab="", cex.lab=2, cex.axis=1.5)
title(main="(C) Barplot for genetic variation",cex.main = 2, adj=0)
title(xlab=expression(paste("Jackson Hole",italic("-Lycaeides"))), cex.lab=2, line=3.5)
title(ylab="PC1 scores", cex.lab=2, line=3.5)
dev.off()

## write out the average genotype estimates for popanc
write.table(cbind(pops,g.avg), file = "males_genoest_entropy.txt", col.names=FALSE, row.names=FALSE, quote=FALSE)
