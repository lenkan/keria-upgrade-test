# Keria upgrade test

This repository contians a reproduction for an issue encountered when trying to upgrade a keria instance from 0.1.2 to 0.2.0-dev2.

In short,

- ./src/setup.ts contains a scripts that creates a two agents with a group AID using an older version of signify-ts
- ./src/connect.ts contains a script that connects to the keria instance using the main branch of signify-ts
- ./run-test.sh contains a shell script that runs the whole migration test.

The run-test.sh file contains the reproduction script that:

- Start a keria instance with version 0.1.x
- Runs the setup.ts script
- Stops the keria instance
- Runs keripy database migrations
- Runs keria sig-fix
- Starts a keria intance with version 0.2.0-devX
- Runs the connect.ts script

## How to run

Clone repo and run the run-test.sh scripts. Requires up to date docker version.

```
git clone git@github.com:lenkan/keria-upgrade-test.git
cd keria-upgrade-test
./run-test.sh
```
