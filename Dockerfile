# ビルドステージ
FROM python:3.11-buster AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user -r requirements.txt

# 実行ステージ
FROM python:3.11-slim-buster

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get install -y \
    git \
    wget \
    vim \
    sudo \
    # opencv
    libgl1-mesa-dev \
    # tesseract
    apt-transport-https \
    lsb-release \
    gpg \
    && echo "deb https://notesalexp.org/tesseract-ocr5/$(lsb_release -cs)/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/notesalexp.list \
    && wget -O - https://notesalexp.org/debian/alexp_key.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/alexp_key.gpg \
    && apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    tesseract-ocr-jpn \
    # clean
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # create user
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY --from=builder /root/.local /home/$USERNAME/.local

USER vscode