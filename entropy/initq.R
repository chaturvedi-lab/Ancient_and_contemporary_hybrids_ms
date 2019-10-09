## read genotype estimates, i.e., g = 0 * Pr(g=0) + 1 * Pr(g=1) + 2 * Pr(g=2)
## row = locus, column = individual

L<-50
N<-835
g<-matrix(scan("pntest_file.txt",n=N*L,sep=" "),nrow=L,ncol=N,byrow=T)


## calculate N x N genotype covariance matrix
gmn<-apply(g,1,mean)
gmnmat<-matrix(gmn,nrow=L,ncol=N)
gprime<-g-gmnmat ## remove mean
gcovarmat<-matrix(NA,nrow=N,ncol=N)
for(i in 1:N){
    for(j in i:N){
        if (i==j){
            gcovarmat[i,j]<-cov(gprime[,i],gprime[,j])
        }
        else{
            gcovarmat[i,j]<-cov(gprime[,i],gprime[,j])
            gcovarmat[j,i]<-gcovarmat[i,j]
        }
    }
}

## pca on the genotype covariance matrix
pcgcov<-prcomp(x=gcovarmat,center=TRUE,scale=FALSE)

## kmeans and lda
library(MASS)
k2<-kmeans(pcgcov$x[,1:5],2,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k3<-kmeans(pcgcov$x[,1:5],3,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k4<-kmeans(pcgcov$x[,1:5],4,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k5<-kmeans(pcgcov$x[,1:5],5,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k6<-kmeans(pcgcov$x[,1:5],6,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k7<-kmeans(pcgcov$x[,1:5],7,iter.max=10,nstart=10,algorithm="Hartigan-Wong")
k8<-kmeans(pcgcov$x[,1:5],8,iter.max=10,nstart=10,algorithm="Hartigan-Wong")

ldak2<-lda(x=pcgcov$x[,1:5],grouping=k2$cluster,CV=TRUE)
ldak3<-lda(x=pcgcov$x[,1:5],grouping=k3$cluster,CV=TRUE)
ldak4<-lda(x=pcgcov$x[,1:5],grouping=k4$cluster,CV=TRUE)
ldak5<-lda(x=pcgcov$x[,1:5],grouping=k5$cluster,CV=TRUE)
ldak6<-lda(x=pcgcov$x[,1:5],grouping=k6$cluster,CV=TRUE)
ldak7<-lda(x=pcgcov$x[,1:5],grouping=k7$cluster,CV=TRUE)
ldak8<-lda(x=pcgcov$x[,1:5],grouping=k8$cluster,CV=TRUE)

write.table(round(ldak2$posterior,5),file="ldak2.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak3$posterior,5),file="ldak3.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak4$posterior,5),file="ldak4.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak5$posterior,5),file="ldak5.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak6$posterior,5),file="ldak6.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak7$posterior,5),file="ldak7.txt",quote=F,row.names=F,col.names=F)
write.table(round(ldak8$posterior,5),file="ldak8.txt",quote=F,row.names=F,col.names=F)

save(list=ls(),file="init.rdat")

## when you run entropy use provide the input values as, e.g., -q ldak2.txt
## also set -s to something like 50
