# Dockerfile for the notebook images
FROM jupyter/minimal-notebook

USER root

# install graphviz
RUN apt-get update && \
	apt-get -qq install -y graphviz

# Install Julia
RUN	cd /opt && \
	wget -q https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz && \
	tar xvfz julia-1.1.0-linux-x86_64.tar.gz && \
	rm julia-1.1.0-linux-x86_64.tar.gz && \
	ln -s /opt/julia-1.1.0/bin/julia /usr/local/bin/julia

USER $NB_USER

# Install nbextensions, collatex + dependencies
RUN pip install --no-cache-dir collatex jupyter_contrib_nbextensions

# setup julia + hypercollate + nbextensions
# https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/runtools/readme.html
RUN	julia -e 'using Pkg;Pkg.add("IJulia");Pkg.develop(PackageSpec(url = "https://github.com/brambg/HyperCollate.jl")); using HyperCollate' && \
	jupyter contrib nbextension install --user #&& \
	jupyter nbextension enable code_prettify codefolding highlighter

# avoid security token at startup
CMD ["start-notebook.sh", "--NotebookApp.token=''"]