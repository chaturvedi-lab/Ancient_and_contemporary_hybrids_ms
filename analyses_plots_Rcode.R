qfile <- read.table("q_K2_mod.txt", header=TRUE)
pops<-read.table("temp_pops.txt", header=FALSE)
pops <- read.table("temp_pops.txt", header=FALSE)
pops2 <- rbind(pops, pops) #create a column of pops repeated twice for each individual in the q file
q<-cbind(pops2, qfile)
q2pops <- cbind(pops2, q2)
q2mat<-cbind(q2pops$V1[1:185], q2pops$mean[1:835], q2pops$mean[836:1670])
length(q2pops$mean[836:1670])
head(q2mat)
head(q2pops$V1[1:835])
head(t(q2mat))
q2mat_prop<-cbind(q2mat[,2], q2mat[,3])
levels(pops$V1)
family<-as.factor(pops$V1)

## pca
gk2<-matrix(scan("geno_K2.txt", n=39193*835,sep=","), nrow=835,ncol=39193,byrow=T)
gk3<-matrix(scan("geno_K3.txt", n=39193*835,sep=","), nrow=835,ncol=39193,byrow=T)
gk4<-matrix(scan("geno_K4.txt", n=39193*835,sep=","), nrow=835,ncol=39193,byrow=T)
gk5<-matrix(scan("geno_K5.txt", n=39193*835,sep=","), nrow=835,ncol=39193,byrow=T)
g.avg<-(gk2+gk3+gk4+gk5)/4
head(g.avg)
dim(g.avg)
g.pca<-prcomp(g.avg, scale=TRUE)

##boxplot
qpop<-q[1:835,]
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
hyb$factor<-factor(hyb$V1, levels=c("BLD","BCR","BIC","BNP","BTB","FRC","PIN","PSP","RDL","RNV","DBS"))


## pca
## plot map, pca and barplot
pt_colors=c('#999999','#E69F00', '#56B4E9',"yellowgreen")
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
family<-as.factor(pops$V1)
usa <- map_data("usa")
state_dat<-map_data("state")
map_dat<-rbind(state_dat,usa)

p0 <- ggplot() +
  geom_polygon(data=map_dat,aes(x=long,y=lat,group=group, fill=region),fill="white",color="black", show.legend=FALSE) +
  coord_map("gilbert",xlim=c(-116,-105),ylim=c(40,49)) +
  labs(x=element_blank(), y=expression("Latitude"*~degree*N)) +
  theme(panel.border = element_rect(colour = "black", fill=NA, size=1),
        plot.margin=unit(c(0.25,0.25,0.25,0.25),'inches'),
        legend.position='none') +
  theme(rect = element_blank()) + theme(text = element_text(size=20),
                                        axis.text.x = element_blank(), axis.text.y = element_blank(), axis.ticks=element_blank(),axis.title.x=element_blank(),axis.title.y=element_blank())
p1 <- p0 + geom_point(data=locs,aes(x=longitude,y=latitude,colour=species,shape=species,size=5)) + scale_color_manual(values=pt_colors) + scale_shape_manual(values=c(18,16,17,15))

####### plot multipanel figure #################################
library(gridBase)
library(grid)
pdf("../mappcabarplot.pdf",width=10,height=10)
layout(matrix(c(1,2,3,3), 2, 3, byrow = TRUE))
## map
plot.new()
vps <- baseViewports()
pushViewport(vps$figure)
vp1 <-plotViewport(c(0.1,0,0,0.1))
print(p1, vp=vp1)

### pca ###
palette(mycols.list)
par(mar=c(4,5,0.5,0.5))
mycols.list<-c("#999999","#999999","#999999","#E69F00","#56B4E9","#999999","#56B4E9","#56B4E9","yellowgreen","#999999","#E69F00","#E69F00","#56B4E9","#56B4E9","#999999","#999999","#999999","#999999","#E69F00","#56B4E9","#E69F00","#56B4E9","#56B4E9")
palette(mycols.list)
plot(g.pca$x[,1], g.pca$x[,2],cex.lab=3, cex.axis=1, col="grey20", pch=21,bg=family, xlab= "", ylab = "", cex=1.5)
legend(-5, 62, legend=c(expression(italic("L. idas")),expression(italic("L. melissa")),"Old hybrids", "New hybrids-DBS"), fill=c("#E69F00", "#56B4E9", "#999999","yellowgreen"), cex=1.3)
title(xlab = "PC1 = 2.4%", cex.lab = 2,line = 3)
title(ylab = "PC2 = 0.98%", cex.lab = 2,line = 3)

### barplot #####
par(mar=c(5,7,3,1))
cols=c(rep("#999999",10),"yellowgreen")
boxplot(hyb$pcscores~hyb$factor, col=cols, ylab="", cex.lab=2, cex.axis=1.5)
title(ylab="PC1 Scores", cex.lab=2, line=3.5)
dev.off()
