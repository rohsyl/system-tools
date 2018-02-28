# gitlab.rohs.ch - generate ssh key

- Use puttygen to generate a private/public key pair
- The public key
	- Copy the public key
	- On gitlab.rohs.ch -> Profil -> Settings -> SSH Keys -> Add an SSH Key and paste the key in the Key field
- The private key
	- On puttygen, click on Conversions -> Export openssh key
	- Export key to ~/.ssh/gitlab ([~] is the current user home)
	- Create a new file called ~/.ssh/config
		```
		Host gitlab.rohs.ch
		User git
		Port 9122
		IdentityFile ~/.ssh/gitlab
		```