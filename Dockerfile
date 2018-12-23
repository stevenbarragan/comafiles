FROM golang:alpine

RUN apk -U add vim git openssl curl tmux zsh bash ncurses perl build-base

ENV USERNAME steven
ENV HOME /home/$USERNAME

RUN apk -U add --no-cache --virtual .build-deps build-base && \
    git clone https://github.com/jhawthorn/fzy && \
    cd fzy && make && make install && \
    apk del .build-deps

RUN apk add the_silver_searcher

RUN addgroup -g 1000 -S dev && \
    adduser -u 1000 -S $USERNAME -G dev

USER $USERNAME
WORKDIR $HOME

# ZSH
SHELL ["/bin/zsh", "-c"]

COPY zshrc $HOME/.zshrc
RUN curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

COPY --chown=steven:dev /volt/ $HOME/volt/
ENV VOLTPATH $HOME/volt
RUN go get github.com/vim-volt/volt

RUN volt get sheerun/vim-polyglot \
	tpope/vim-sensible \
  mhinz/vim-signify \
	justinmk/vim-dirvish \
	kristijanhusak/vim-dirvish-git \
	danishprakash/vim-githubinator \
	terryma/vim-multiple-cursors \
	editorconfig/editorconfig-vim \
	junegunn/vim-easy-align \
	rstacruz/vim-closer \
	tpope/vim-endwise \
	itchyny/lightline.vim \
  tpope/vim-commentary \
  MikeDacre/tmux-zsh-vim-titles

RUN mkdir -p $HOME/.vim/colors
RUN chown $USERNAME $HOME/.vim/colors
WORKDIR $HOME/.vim/colors
RUN curl -O https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalfdark.vim

RUN mkdir -p $HOME/.vim/autoload/lightline/colorscheme
RUN chown $USERNAME $HOME/.vim/autoload/lightline/colorscheme
WORKDIR $HOME/.vim/autoload/lightline/colorscheme
RUN curl -O https://raw.githubusercontent.com/sonph/onehalf/master/vim/autoload/lightline/colorscheme/onehalfdark.vim

# TMUX

COPY tmux.conf $HOME/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

WORKDIR $HOME

ENTRYPOINT ["tmux"]
