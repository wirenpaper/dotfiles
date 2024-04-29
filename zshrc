# Set up the prompt
PS1='%(?.%F{darkgreen}.%F{red})[%1~]$%b%f '

CASE_INSENSITIVE="true"

setopt histignorealldups sharehistory
setopt MENU_COMPLETE
setopt no_list_ambiguous

bindkey -v

#export LS_COLORS="$(vivid generate one-light)"
#export LS_COLORS="$(vivid generate ayu)"
alias zig="~/progs/zig-linux-x86_64-0.12.0/zig"
alias vi="vim"
alias z="zig build-exe"
alias dk="exec gnome-terminal --full-screen '$@'"
alias zshrc="v ~/.zshrc"
alias rnd="cd ~/rnd"
alias gt="gnome-terminal"
alias cls=clear
alias harpoon="v ~/.local/share/nvim/harpoon.json"
alias ls="ls --color=auto -F"
alias sl="ls --color=auto -F"
#alias v="~/nvim-linux64/bin/nvim --listen 127.0.0.1:6666"
#alias v="~/nvim-linux64/bin/nvim"
alias v="nvim"
#alias n="nvr -s"
alias python=python3
alias s=python3
alias bat=batcat
alias oc="cd ~/rnd/ocaml"
alias gdb="gdb --silent"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export PATH="/home/saifr/zls/zig-out/bin:$PATH"
export PATH="/home/saifr/progs/zls/zig-out/bin:$PATH"
export PATH="/home/saifr/.cabal/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="/home/saifr/nvim-linux64/bin:$PATH"
export PATH="/home/saifr/progs/zig-linux-x86_64-0.12.0:$PATH"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit


bindkey "^P" reverse-menu-complete
zstyle ':completion:*' menu yes select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
alias c="cd"
#alias dsa="cd ~/rnd/dsa"
alias fl="cd ~/rnd/flet"
alias pytorch="cd ~/rnd/pytorch"
alias portfolio="cd ~/rnd/portfolio"

# This function calls the script below when loaded by
# the shell inside of neovim. It must be placed somewhere in
# your default shell's rc file e.g. ~/.zshrc

check_dir() {
	FILE1="$PWD/bookmark.txt"
	FILE2="$PWD/del.py"
	FILE3="$PWD/main.mk"
	FILE4="$PWD/mkdir.py"
	FILE5="$PWD/README.md"
	FILE6="$PWD/rm.py"
	FILE7="$PWD/test_macros.h"
	FILE8="$PWD/test_maingen.py"
	DIR1="$PWD/projects"
	DIR2="$PWD/skeleton"

	if [[ -f "$FILE1" && -f "$FILE2" && -f "$FILE3" && -f "$FILE4" && 
	      -f "$FILE5" && -f "$FILE6" && -f "$FILE7" && -f "$FILE8" && 
	      -d "$DIR1" && -d "$DIR2" ]]; then

		STORE=$PWD

		# "cd " should always prepend "projects/" to autocompletion
		function tab-completion() {
			if [[ $BUFFER =~ "^cd "[^/]*$ ]]; then
				BUFFER="cd projects/${BUFFER#cd }"
			elif [[ $BUFFER =~ "^rm -r "[^/]*$ ]]; then
				BUFFER="rm -r projects/${BUFFER#rm -r }"
			elif [[ $BUFFER =~ "^mv "[^/]*$ ]]; then
				BUFFER="mv projects/${BUFFER#mv }"
			elif [[ $BUFFER =~ "^cp -r"[^/]*$ ]]; then
				BUFFER="cp -r projects/${BUFFER#cp -r }"
			fi
			zle expand-or-complete
		}
		zle -N tab-completion
		bindkey '^I' tab-completion

		alias rm="s rm.py"
		alias mkdir="s mkdir.py"
		alias del="s del.py"
		jmp=$(<~/rnd/dsa/bookmark.txt)
		alias cur="cd $jmp"

		alias ls="s ls.py"
		alias sl="s ls.py"
		alias mv="s mv.py"
		alias cp="s cp.py"
		alias touch="s touch.py"
	else
		bindkey '^I' expand-or-complete

		if [[ $PWD =~ "^$STORE" ]]; then
			alias j="cd ~/rnd/dsa"
		else
			alias -g j &>/dev/null && \
			unalias j
		fi

		alias -g rm &>/dev/null && \
		unalias rm
		alias -g mkdir &>/dev/null && \
		unalias mkdir 
		alias -g del &>/dev/null && \
		unalias del
		alias -g cur &>/dev/null && \
		unalias cur
		alias -g ls &>/dev/null && \
		alias ls="ls --color=auto -F"
		alias sl="ls --color=auto -F"
		alias -g mv &>/dev/null && \
		unalias mv
		alias -g cp &>/dev/null && \
		unalias cp
		alias -g touch &>/dev/null && \
		unalias touch
	fi
}
precmd_functions+=(check_dir)

# opam configuration
[[ ! -r /home/saifr/.opam/opam-init/init.zsh ]] || source /home/saifr/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# This function calls the script below when loaded by
# the shell inside of neovim. It must be placed somewhere in
# your default shell's rc file e.g. ~/.zshrc

#export PATH=$PATH:$(go env GOPATH)/bin
export PATH="/home/saifr/scripts:$PATH"
neovim_autocd() {
	[[ $NVIM ]] && neovim-autocd.py
}
chpwd_functions+=( neovim_autocd )
