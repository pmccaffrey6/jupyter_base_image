FROM continuumio/miniconda3

RUN apt-get update && \
	conda config --set always_yes yes --set changeps1 no && \
	conda install -c conda-forge scikit-image && \
	conda install jupyter nb_conda && \
	mkdir ~/.jupyter && \
	mkdir /notebooks

COPY scripts/jupyter_notebook_config.json $HOME/.jupyter/jupyter_notebook_config.json

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["jupyter","notebook","--ip=0.0.0.0","--port=8000","--allow-root","--notebook-dir=/notebooks","--config=/.jupyter/jupyter_notebook_config.json"]
