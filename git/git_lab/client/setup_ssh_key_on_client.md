# gitlab.rohs.ch - generate ssh key

> git and putty with puttygen must be installed

- Use puttygen to generate a private/public key pair
- The public key
	- Copy the public key
	- On gitlab.publicKey -> Profil -> Settings -> SSH Keys -> Add an SSH Key and paste the key in the Key field
- The private key
	- On puttygen, click on Conversions -> Export openssh key for Linux and putty key for Windows
	- Export key to `~/.ssh/gitlab` ([~] is the current user home)
-The config file
	- Create a new file called `~/.ssh/config`
		```
		Host gitlab.yourserver.tld
		User git
		Port >your ssh port<
		IdentityFile ~/.ssh/gitlab.privateKey
		```
	
	> Warning : On Linux, the key permission must be set to 600

## If you want to use git on localhost

- The public Key
	- Copy the public key in `~/.ssh/authorized_keys`
- The private Key
	- Copy the private key in `~/.ssh/gitlab.privateKey`
- The config file
	- Open the `~/.ssh/config` file and add 
		```
		Host localhost
		User git
		Port >your ssh port<
		IdentityFile ~/.ssh/gitlab.privateKey
		```
