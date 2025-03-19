function sshfs-mount --argument-names host --wraps sshfs
    mkdir --parents --verbose "$HOME/mnt/$host/"
    sshfs "$host:" "$HOME/mnt/$host/"
end
