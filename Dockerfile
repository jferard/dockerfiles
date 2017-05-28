FROM sequenceiq/hadoop-docker:2.7.1

RUN yum -y install epel-release
RUN yum -y install R

ENV HADOOP_CMD /usr/local/hadoop/bin/hadoop
ENV HADOOP_HOME /usr/local/hadoop

# for native
ENV HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native

# R packages
RUN echo 'install.packages(c("Rcpp", "RJSONIO", "bitops", "digest", "functional", "reshape2", "stringr", "plyr", "caTools", "rJava"), repos = "http://cran.us.r-project.org")' > /tmp/packages.R && Rscript /tmp/packages.R

# R HDFS Library
RUN echo 'install.packages("https://github.com/RevolutionAnalytics/rhdfs/blob/master/build/rhdfs_1.0.8.tar.gz?raw=true", repos = NULL, type = "source")' > /tmp/packages.R && Rscript /tmp/packages.R

# R RMR Library
RUN echo 'install.packages("https://github.com/RevolutionAnalytics/rmr2/blob/master/build/rmr2_3.3.0.tar.gz?raw=true", repos = NULL, type = "source")' > /tmp/packages.R && Rscript /tmp/packages.R

# for R
ADD https://repository.cloudera.com/content/groups/cdh-build/org/apache/hadoop/hadoop-streaming/2.6.0-cdh5.9.2/hadoop-streaming-2.6.0-cdh5.9.2.jar /usr/local/hadoop/hadoop-streaming-2.5.0-cdh5.3.0.jar

# data samples
RUN mkdir -p /usr/local/data
ADD https://www.gutenberg.org/cache/epub/135/pg135.txt /usr/local/data/miserables.txt
ADD r-h-d-bootstrap.sh /etc/r-h-d-bootstrap.sh

# programs
RUN mkdir -p /usr/local/src
ADD src /usr/local/src/

# ATOM
# ADD https://github.com/atom/atom/releases/download/v1.17.2/atom.x86_64.rpm /usr/local/atom.x86_64.rpm
# RUN yum -y localinstall /usr/local/atom.x86_64.rpm

# nano
RUN yum -y install nano
