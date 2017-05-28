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
	words = strsplit(v, "\\W+")
	keyval(unlist(words),1) # one keyval per word
}

# reduce
myreduce<-function(k,v){
	n <-length(v)
	# only if more than 500 times
	if (n > 500) {
		keyval(k,n)
	}
}

# we need rhdfs
library(rhdfs)

# init hdfs access
hdfs.init()

# map reduce
output <-mapreduce(input="/data/miserables.txt", input.format="text", map=mymap, reduce=myreduce)

# display in R terminal the temp HDFS output
print(from.dfs(output))
