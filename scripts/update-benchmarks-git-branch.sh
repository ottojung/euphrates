#! /bin/sh

#################
## This script is supposed to be run on CI.
## It requires REPOLOGKEY variable to be set to the contents of the SSH key.
#################

set -e

cleanup() {
    cd ..
    rm -f "$SSHKEYFILE"
    rm -fr benchmarks-repo
}

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
git remote add mirror git@github.com:ottojung/repolog.git
git remote set-url --add mirror git@codeberg.org:otto/repolog.git


for TRY in $(seq 10)
do
    rm   -fr data/
    mkdir -p data/
    cp -T -r ../dist/benchmarks/ data/

    git add --all
    git commit --message 'update benchmarks'

    if git push origin "$BRANCH"
    then
        git push mirror --force "$BRANCH" || true
        cleanup
        exit 0
    fi

    sleep 5
    git fetch origin "$BRANCH"
    git reset --hard origin/"$BRANCH"
    git pull || true
    git clean -dfx
done

cleanup
exit 1
