## start with the Docker latest Ubuntu-based image
FROM ubuntu:latest

## Remain current
RUN apt-get update -qq \
	&& apt-get dist-upgrade -y

RUN apt-get update -qq \
	&& apt-get install  -y  \
    curl \
		libnetcdf-dev 

RUN apt-get install  -y  \
  R
  
# Setup default cran repo
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

# This installs other R packages under Bioconductor
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('mzR')"

CMD "/bin/bash"
