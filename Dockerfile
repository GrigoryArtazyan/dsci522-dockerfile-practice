# Use Jupyter minimal-notebook as base image
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy your environment file into the image
COPY environment.yaml /tmp/environment.yaml

# Create the environment
RUN mamba env create -f /tmp/environment.yaml -n docker-env \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" \
    && /opt/conda/envs/docker-env/bin/python -m ipykernel install --user --name docker-env --display-name "Python (docker-env)"
