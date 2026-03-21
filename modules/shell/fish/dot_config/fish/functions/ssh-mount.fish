function ssh-mount --argument-names remote --wraps sshfs
    mkdir --parents --verbose "$HOME/mnt/$remote/"
    sshfs "$remote:" "$HOME/mnt/$remote/"
end
