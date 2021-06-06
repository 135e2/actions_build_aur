git config --global user.name 135e2-bot
git config --global user.email bot135e2@gmail.com
RESULT=$(git commit -am "Update submodules")
if [[ $RESULT != *"nothing to commit, working tree clean"* ]]; then
    git commit -am "Update submodules"
    git push
else
    echo "Already up to date"
fi