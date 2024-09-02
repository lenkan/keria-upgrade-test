# Keria upgrade test

This repository contians a reproduction for an issue encountered when trying to upgrade a keria instance from 0.1.2 to 0.2.0-dev2.

In short,

- ./src/setup.ts contains a scripts that creates a two agents with a group AID using the main branch of signify-ts.
- ./src/connect.ts contains a script that connects to the keria instance using the signify-ts branch of https://github.com/WebOfTrust/signify-ts/pull/267
- ./migrate.sh contains a shell script to run as part of the migration to the new keria version

The run-test.sh file contains the reproduction script that:

- Start a keria instance with version 0.1.x
- Runs the setup.ts script
- Stops the keria instance
- Runs keripy database migrations
- Starts a keria intance with version 0.2.0-devX
- Runs the connect.ts script

## How to run

Clone repo and run the run-test.sh scripts. Requires up to date docker version.

```
git clone git@github.com:lenkan/keria-upgrade-test.git
cd keria-upgrade-test
./run-test.sh
```
