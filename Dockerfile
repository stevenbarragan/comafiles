FROM golang:alpine

RUN apk -U add vim git openssl curl tmux zsh bash ncurses perl build-base
RUN apk add fzy --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN apk add zsh-vcs the_silver_searcher

RUN go get github.com/vim-volt/volt

ENV LANG en_US.UTF-8
ENV USERNAME steven
ENV HOME /home/$USERNAME
ENV TERM screen-256color
ENV ZPLUG_HOME $HOME/.zplug

RUN addgroup -g 1000 -S dev && \
    adduser -u 1000 -S $USERNAME -G dev

USER $USERNAME
WORKDIR $HOME

# ZSH
COPY zshrc $HOME/.zshrc
RUN git clone https://github.com/zplug/zplug $ZPLUG_HOME
COPY packages.zsh $ZPLUG_HOME/packages.zsh
SHELL ["/bin/zsh", "-c"]

COPY --chown=steven:dev /volt/ $HOME/.volt
ENV VOLTPATH $HOME/.volt

RUN volt get \
      danishprakash/vim-githubinator \
      editorconfig/editorconfig-vim \
      inside/vim-search-pulse \
      itchyny/lightline.vim \
      jeffkreeftmeijer/vim-numbertoggle \
      junegunn/vim-easy-align \
      justinmk/vim-dirvish \
      kristijanhusak/vim-dirvish-git \
      luochen1990/rainbow \
      mhinz/vim-signify \
      mikedacre/tmux-zsh-vim-titles \
      rrethy/vim-illuminate \
      rstacruz/vim-closer \
      sheerun/vim-polyglot \
      terryma/vim-multiple-cursors \
      terryma/vim-smooth-scroll \
      tpope/vim-commentary \
      tpope/vim-endwise \
      tpope/vim-sensible \
      jeffkreeftmeijer/vim-dim

# TMUX

COPY tmux.conf $HOME/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm/

# FONT

COPY mplus_1mn_nerd_font_complete.ttf /usr/share/fonts/

WORKDIR $HOME

ENTRYPOINT ["tmux"]
