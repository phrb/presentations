FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04
LABEL name="haq-quantization-sampling"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential                                          \
        vim                                                      \
        cmake                                                    \
        git                                                      \
        python3-dev                                              \
        libssl-dev                                               \
        libffi-dev                                               \
        libxml2-dev                                              \
        libxslt1-dev                                             \
        zlib1g-dev                                               \
        python3-pip                                              \
        python3-setuptools                                       \
        python3-pandas                                           \
        curl                                                     \
        ca-certificates                                          \
        libjpeg-dev                                              \
        libpng-dev                                               \
        liblapack-dev                                            \
        libopenblas-dev                                          \
        r-base &&                                                \
        rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages("http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_1.0.3.tar.gz", repos = NULL, type = "source")'
RUN Rscript -e 'install.packages(c("rsm", "dplyr", "tidyr", "DiceKriging", "DiceDesign", "DiceOptim","randtoolbox", "future.apply"), repos="http://cran.us.r-project.org")'

RUN pip3 install wheel

RUN pip3 install               \
        'Pillow==6.1'          \
        'torch==1.2'           \
        'torchvision==0.4.0'   \
        'numpy>=1.14'          \
        'easydict>=1.8'        \
        'progress>=1.4'        \
        'matplotlib<3.1'       \
        'scikit-learn>=0.21.0' \
        'tensorboardX>=1.7'

ENV http_proxy "http://web-proxy-pa.labs.hpecorp.net:8088/"
ENV https_proxy "http://web-proxy-pa.labs.hpecorp.net:8088/"
