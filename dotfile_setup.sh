# https://www.atlassian.com/git/tutorials/dotfiles

git clone --bare git://github.com/anjoweichbrodt/dotfiles.git $HOME/.dotfiles

echo "alias dotconf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc

function dotconf {
        /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

mkdir -p .dotfiles-backup

dotconf checkout

if [ $? = 0  ]; then
        echo "Checked out config.";
        else
                echo "Backing up pre-existing dot files.";
                dotconf checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

dotconf checkout
dotconf config status.showUntrackedFiles no
