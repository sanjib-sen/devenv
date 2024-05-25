# devenv

Run your own development environment within docker and ssh to it from anywhere
With neovim (kickstart.nvim), tmux, fzf, ohmyzsh, zsh-autosuggestions, fzf-tab, fast-syntax-highlighting and more.

## Instructions

1. Make sure you have docker installed
2. Git clone this
    ```sh
    git clone https://github.com/sanjib-sen/devenv
    ```
3. Copy .env.example to .env
    ```sh
    cp .env.example .env
    ```
4. Add your username and password for the dev container in the .env file. (Mandatory)
    ```.env
    USER=<your own username>
    PASSWORD=<your own password>
    SSH_PORT=<the port you want to expose for ssh, default:8654>
    ```
5. (Optional): Add your own .zshrc / .p10k.zsh / neovim config file/repo in the .env
6. (Optional): Expose your desired ports with `EXPOSE_EXTERNAL_PORT_RANGE` `EXPOSE_INTERNAL_PORT_RANGE`
7. (Optional): Modify `devenvironment.sh` file to add your own build tools, compilers, dotfiles, etc.
    For convenience, I have added commands for common languages and build tools. Uncomment to use them or add your own.
8. RUN using docker compose
    ```sh
    docker compose up -d
    ```
9. Now use it with ssh
    ```sh
    ssh -p <SSH_PORT/8654> <USER>:@<HOST>
    ```
10. Feel Free to modify the Dockerfile and devenvironment.sh to suit your needs.
