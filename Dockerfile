## start with the Docker latest Ubuntu-based image
FROM ubuntu:latest

## Add repo for upstream R
RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list' \
	&& gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 \ 
	&& gpg -a --export E084DAB9 | sudo apt-key add -

## Remain current
RUN apt-get update -qq \
	&& apt-get dist-upgrade -y

## Intall build dependencies
RUN apt-get update -qq \
	&& apt-get install  -y  \
    	curl \
    	netcdf-bin \
	libnetcdf-dev 

## Install R
RUN apt-get install  -y  \
  r-base r-base-dev

  
# Setup default cran repo
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

# This installs other R packages under Bioconductor
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('mzR')"

CMD "/bin/bash"
