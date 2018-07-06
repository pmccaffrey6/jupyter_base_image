FROM continuumio/miniconda3

RUN apt-get update && \
	wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && \
	dpkg -i /tmp/libpng12.deb && \
 	rm /tmp/libpng12.deb && \
	apt-get install -y libgtk2.0-0 && \
	conda config --set always_yes yes --set changeps1 no && \
	conda install -c conda-forge scikit-image && \
	conda install jupyter nb_conda pandas scikit-learn pango && \
	conda install -c menpo opencv3 && \
	mkdir ~/.jupyter && \
	mkdir /notebooks

COPY scripts/jupyter_notebook_config.json /.jupyter/jupyter_notebook_config.json

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["jupyter","notebook","--ip=0.0.0.0","--port=8000","--allow-root","--notebook-dir=/notebooks","--config=/.jupyter/jupyter_notebook_config.json"]
