# Use Jupyter minimal-notebook as base image
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy the conda lock file into the image
COPY environment.yaml /tmp/environment.yaml

# Install packages from lock file using mamba
RUN mamba env update -f /tmp/environment.yaml \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
