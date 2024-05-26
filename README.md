# devenv

Create and run your own development environment within docker and ssh to it from anywhere.
With neovim (kickstart.nvim), tmux, fzf, ohmyzsh, zsh-autosuggestions, fzf-tab, fast-syntax-highlighting and more.

## Instructions

1. Make sure you have docker installed
2. Git clone this repository
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
    SSH_PORT=<the port you want to expose for ssh, default:23>
    ```
5. (Optional): Add/Modify your own .zshrc / .p10k.zsh / neovim config file/repo in the .env
6. (Optional): Expose your desired ports with `EXPOSE_EXTERNAL_PORT_RANGE` and `EXPOSE_INTERNAL_PORT_RANGE`
7. (Optional): Modify `devenvironment.sh` file to add your own build tools, compilers, dotfiles, etc.
    For better understanding, I have added the commands to install the rust toolchain. Uncomment to use it or add your own
8. RUN using docker compose
    ```sh
    docker compose up -d
    ```
9. Now use it with ssh
    ```sh
    ssh -p <SSH_PORT/8654> <USER>:@<HOST>
    ```
10. Feel Free to Fork and modify the source code to suit your needs
