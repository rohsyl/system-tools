# gitlab.rohs.ch - getting started with a repo

# 1. Git global setup
```
git config --global user.name "your name"
git config --global user.email "your email"
```

# 2. Checkout repo into existing folder
```
cd existing_folder
git init
git remote add origin git@gitlab.rohs.ch:rohsyl/youtube_api3_client.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

# 3. Use GitHub Desktop to manage gitlab repo
- After the repo is manually get with the step 1 and 2 open GitHub Desktop
- File -> Add local repo
- Enjoy !