# Nice linux aliases

Here is a list of usefull linux command alias to improve your experience.

## How to create command alias

Pour éviter de modifier trop souvent le fichier sensible qu'est .bashrc, il est conseillé d'utiliser le fichier .bash_aliases. 
Pour que celui-ci soit pris en compte, modifiez le fichier ~/.bashrc après l'avoir sauvegardé pour décommenter1), 
si ce n'est déjà le cas, les lignes suivantes:

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

La commande :

alias nom_de_votre_alias='commande de votre alias'

ou 

alias nom_de_votre_alias="commande de votre alias"

Pour que vos alias soient pris en compte après ajout dans les fichiers .bashrc ou .bash_aliases, il vous faudra relancer votre terminal ou saisir la commande

source ~/.bashrc

lister les alias :

alias



## List of usefull alias

### Improved ls -la
```
alias ll="ls --color -lAGbh --time-style='+%d %b %Y %H:%M'"
```

### Colour your cat command output - the easy way

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

