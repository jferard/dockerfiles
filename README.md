# R Hadoop Docker

R Hadoop Docker is an adaptation of a [french tutorial](http://tutoriels-data-mining.blogspot.fr/2015/04/programmation-r-sous-hadoop.html) that explains how to count words in a hdfs file with the language R.

The tutorial was based on a Virtual Machine and a lot of manual installation/configuration. R Hadoop Docker uses the ability of Docker to set up an environment.

## The Docker container
The docker container is based on [hadoop-docker](https://github.com/sequenceiq/hadoop-docker/blob/master/Dockerfile) from sequenceiq.

It adds to the base image:
* some R packages
* the [R Hadoop bindings from RevolutionAnalytics](https://github.com/RevolutionAnalytics/RHadoop/wiki)
* data samples
* test programs
* a text editor (nano)

## How to use R Hadoop Docker
The 2 following steps are taken from [hadoop-docker README](https://github.com/sequenceiq/hadoop-docker)

### Build the image
```sudo docker build -t jferard/r-hadoop-docker:2.7.1 .```

### Start the container
```sudo docker run -it jferard/r-hadoop-docker:2.7.1 /etc/r-h-d-bootstrap.sh```

### Launch the examples
```cd /usr/local/src```
Then:
```Rscript word-count-mock-data.r```

Or:
```Rscript word-count.r```
