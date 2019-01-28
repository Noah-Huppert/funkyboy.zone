# funkyboy.zone
linux server run at funkyboy.zone

# Table Of Contents
- [Overview](#overview)
- [Setup](#setup)
- [Files](#files)

# Overview
Server is setup using [Salt](https://saltstack.com).  

# Setup
On your computer:

1. Run the initial setup script:
   ```
   ./client-scripts/init.sh root@funkyboy.zone
   ```
2. Setup rest of server:
   ```
   ./client-scripts/apply.sh root@funkyboy.zone
   ```

# Files
- `server-scripts/` - Scripts to be run on the server
- `client-scripts/` - Scripts to be run on a client
- `{salt,pillar}/` - Salt files
