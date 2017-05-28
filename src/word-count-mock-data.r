# see http://tutoriels-data-mining.blogspot.fr/2015/04/programmation-r-sous-hadoop.html

Sys.setenv(HADOOP_STREAMING="/usr/local/hadoop/hadoop-streaming-2.5.0-cdh5.3.0.jar")

# loads package "rmr2"
library(rmr2)

# set options for Java heap
bp<-list(
	hadoop= list(
		D = "mapreduce.map.java.opts=-Xmx1024M",
		D = "mapreduce.reduce.java.opts=-Xmx2048M",
		D = "mapreduce.map.memory.mb=1280",
		D = "mapreduce.reduce.memory.mb=2560"
	)
)

# parameters
rmr.options(backend.parameters=bp)

# exec in hadoop mode
rmr.options(backend="hadoop")

# map
mymap<-function(k,v){
	keyval(v,1)
}

# reduce
myreduce<-function(k,v){
	n <-length(v)
	keyval(k,n)
}

# in memory data
b <-c("The", "Apache", "Hadoop", "software", "library", "is", "a", "framework", "that", "allows", "for", "the", "distributed", "processing", "of", "large", "data", "sets", "across", "clusters", "of", "computers", "using", "simple", "programming", "models", "It", "is", "designed", "to", "scale", "up", "from", "single", "servers", "to", "thousands", "of", "machines", "each", "offering", "local", "computation", "and", "storage", "Rather", "than", "rely", "on", "hardware", "to", "deliver", "high", "availability", "the", "library", "itself", "is", "designed", "to", "detect", "and", "handle", "failures", "at", "the", "application", "layer", "so", "delivering", "a", "highly", "available", "service", "on", "top", "of", "a", "cluster", "of", "computers", "each", "of", "which", "may", "be", "prone", "to", "failures")

# copy in temp HDFS file
a <-to.dfs(b)

# map reduce
output <-mapreduce(input=a, map=mymap, reduce=myreduce
)

# display in R terminal the temp HDFS output
print(from.dfs(output))
