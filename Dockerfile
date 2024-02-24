FROM python:3.11-slim

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

WORKDIR /app

RUN \
    #
    # apt-get
    apt-get update && apt-get install -y \
    tesseract-ocr \
    curl \
    git \
    sudo \
    # for opencv
    libgl1-mesa-dev \ 
    # for jupyter
    gcc \
    python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    #
    # create user
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER vscode

COPY requirements.txt .
RUN pip install -r requirements.txt