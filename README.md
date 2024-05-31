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
4. Modify the environmanet variables according to your needs. Recommended to change the user and password for the container. Check out the [Environment Variables Section](#environment-variables)
5. (Optional): Modify `devenvironment.sh` file to add your own build tools, compilers, dotfiles, etc.
6. RUN using docker compose
    ```sh
    docker compose up -d
    ```
7. Now use it with ssh
    ```sh
    ssh -p <SSH_PORT> <USER>:@<HOST>
    ```
8. Feel Free to Fork and modify the source code to suit your needs

## Environment Variables
  
  - ***`USER`*** = Your own username. Default 'devuser'
  - ***`PASSWORD`*** = Your own password. Password will be hashed. Default '1234'
  - (Optional) ***`ENVIRONMENT_NAME`*** = Give your container a name. Recommended to change if you want to create multiple dev environments. Default 'devenv'
  - (Optional) ***`EXPOSE_EXTERNAL_PORT_RANGE` / `EXPOSE_INTERNAL_PORT_RANGE`*** = Map your external port to container's internal port. e.g `EXPOSE_EXTERNAL_PORT_RANGE=5170-5199` and `EXPOSE_INTERNAL_PORT_RANGE=5170-5199` will map your local/external ports 5170 to 5199 to devenv's internal 5170 to 5199 ports. Default '5170-5199' for both.
  - (Optional) ***`EXPOSE_EXTERNAL_PORT_RANGE` / `EXPOSE_INTERNAL_PORT_RANGE`*** = Link your external/local directory with devenv/container's internal directory. e.g `EXPOSE_EXTERNAL_PATH_DIRECTORY=./data` and `EXPOSE_INTERNAL_PATH_DIRECTORY=~data` will link your local ./data directory to devenv/container's internal's /home/${USER}/data directory. You need to include `/` in front of the `EXPOSE_EXTERNAL_PATH_DIRECTORY` variable. e.g: './data' or '/data'. 'data' will not work. Default: './data' for external and 'data' for internal.
  - (Optional) ***`ZSHRC_FILE_URL`*** = Your .zshrc file url. Default [My Own .zshrc with necessary plugins installed](https://raw.githubusercontent.com/sanjib-sen/devenv/main/dotfiles/.zshrc)
  - (Optional) ***`P10K_FILE_URL`*** = Your powerlevel10k config file url. Default [Official Rainbow Theme Example Configuation by Powerlevle10k](https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-rainbow.zsh)
  - (Optional) ***`NEOVIM_CONFIG_REPO_URL`*** = Your own neovim config url. Default [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim.git)
