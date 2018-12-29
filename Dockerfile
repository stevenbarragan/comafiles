FROM golang:alpine

RUN apk -U add vim git openssl curl tmux zsh bash ncurses perl build-base

ENV USERNAME steven
ENV HOME /home/$USERNAME

RUN apk -U add --no-cache --virtual .build-deps build-base && \
    git clone https://github.com/jhawthorn/fzy && \
    cd fzy && make && make install && \
    apk del .build-deps

RUN addgroup -g 1000 -S dev && \
    adduser -u 1000 -S $USERNAME -G dev

USER $USERNAME
WORKDIR $HOME

# ZSH
SHELL ["/bin/zsh", "-c"]

COPY zshrc $HOME/.zshrc
RUN curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

COPY --chown=steven:dev /volt/ $HOME/.volt
ENV VOLTPATH $HOME/.volt
RUN go get github.com/vim-volt/volt

RUN volt get \
      danishprakash/vim-githubinator \
      editorconfig/editorconfig-vim \
      inside/vim-search-pulse \
      itchyny/lightline.vim \
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
      tpope/vim-sensible

# TMUX

COPY tmux.conf $HOME/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm/

# FONT

COPY mplus_1mn_nerd_font_complete.ttf /usr/share/fonts/

WORKDIR $HOME

ENTRYPOINT ["tmux"]
