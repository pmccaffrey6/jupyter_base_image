FROM contimuumio/miniconda3

RUN apt-get update && \
	conda config --set always_yes yes --set changeps1 no && \
	conda create -f environment.yml && \
	conda install -c conda-forge scikit-image && \
	conda install jupyter nb_conda && \
	mkdir ~/.jupyter

COPY scripts/jupyter_notebook_config.json $HOME/.jupyter/jupyter_notebook_config.json

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["jupyter","notebook","--ip=0.0.0.0","port=8000","--allow-root"]
