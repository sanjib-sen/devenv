FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive

# Install baseline packages
RUN apt-get update && \
    apt-get install --yes \
    curl \
    wget \
    software-properties-common \
    openssh-server \
    tmux \
    zsh \
    fzf \
    locales \
    openssl \
    sudo \
    vim \
    unzip \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable && apt-get update && apt-get install --yes neovim

# Make typing unicode characters in the terminal work.
ENV LANG en_US.UTF-8

ARG USER
ARG PASSWORD
ARG ZSHRC_FILE_URL
ARG P10K_FILE_URL

RUN useradd ${USER} \
    --create-home \
    --shell=/usr/bin/zsh \
    --groups=sudo \
    --uid=1001 \
    --password "$(openssl passwd -6 $PASSWORD)" \
    --user-group && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

USER ${USER}
WORKDIR /home/${USER}
SHELL ["/usr/bin/zsh", "-c"]

# Download and Install Oh My ZSH, themes and plugins
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Remove default .zshrc with own and create a directory for codes
RUN rm .zshrc && mkdir codes

# Download own .zshrc and powerlevel10k configuration
RUN wget https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-rainbow.zsh -O .p10k.zsh \
    && wget https://raw.githubusercontent.com/sanjib-sen/devenv/main/dotfiles/.zshrc -O .zshrc

# Download Kickstart.nvim
RUN git clone https://github.com/nvim-lua/kickstart.nvim.git /home/${USER}/.config/nvim

COPY devenvironment.sh .
RUN sudo chmod +x devenvironment.sh && ./devenvironment.sh

# Expose Port 22
EXPOSE 22/tcp
RUN source ~/.zshrc

# Run SSH and an infinite process
ENTRYPOINT sudo service ssh start && echo "$(service ssh status)" && tail -f /dev/null
