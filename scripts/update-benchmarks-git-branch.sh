#! /bin/sh

#################
## This script is supposed to be run on CI.
## It requires REPOLOGKEY variable to be set to the contents of the SSH key.
#################

set -e

if test -z "$REPOLOGKEY"
then
    echo 'Variable $REPOLOGKEY is not set' 1>&2
    exit 1
fi

SSHKEYFILE="$PWD/sshkey~"
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i $SSHKEYFILE"
rm -f "$SSHKEYFILE"
echo "$REPOLOGKEY" > "$SSHKEYFILE"
chmod u=r,g=,o= "$SSHKEYFILE"
BRANCH="euphrates-master"

set -x

git clone \
    --branch "$BRANCH" \
    pubgit@vau.place:repolog.git \
    benchmarks-repo \

cd benchmarks-repo/

git config user.name "Otto Jung (bot)"
git config user.email "otto.jung@vauplace.com"
git config gpg.format ssh
git config commit.gpgsign true
git config user.signingkey "$SSHKEYFILE"
git remote set-url --add origin pubgit@vau.place:repolog.git
git remote set-url --add origin git@github.com:ottojung/repolog.git
git remote set-url --add origin git@codeberg.org:otto/repolog.git


for TRY in $(seq 10)
do
    rm   -fr data/
    mkdir -p data/
    cp -T -r ../dist/benchmarks/ data/

    git add --all
    git commit --message 'update benchmarks'

    if git push origin "$BRANCH"
    then break
    fi

    sleep 5
    git fetch origin "$BRANCH"
    git reset --hard "$BRANCH"
    git clean -dfx
done

rm -f "$SSHKEYFILE"
rm -fr benchmarks-repo
