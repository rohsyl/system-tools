# colour your cat command output - the easy way

> Install Pygments and Highlight

- Use `apt install` command to install or update them
```
sudo apt install python-pygments highlight
```

> create `~/.bash_aliases` file

- Insert your aliases in the file
- Here aliases are `catp` for Pygmentize and `cath` for highlight
```
alias catp='pygmentize -g'
```
```
alias cath='highlight -O ansi —force'
```

- Modify `~/.bashrc`file and add these lines if they are not already in
``` 
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

- Activate alias by typing: 
```
source ~/.bash_aliases
```

