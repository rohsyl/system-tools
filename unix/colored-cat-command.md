# colour your cat command output - the easy way

> Install Pygments and Highlight

- Use apt install command to install them or update them
	```
	sudo apt install python-pygments highlight
	```
> create both aliases

- Here aliases are `catp` for Pygmentize and `cath` for highlight
	`alias catp='pygmentize -g'`

	`alias cath='highlight -O ansi —force'`
