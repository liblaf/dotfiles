if status is-login
    if test -f '/etc/profile.d/cuda.sh'
        set --global --export CUDA_PATH /opt/cuda
        fish_add_path --global --path /opt/cuda/bin
        set --global --export NVCC_CCBIN '/usr/bin/g++-15'
    end

    if test -f '/etc/profile.d/flatpak-bindir.sh'
        fish_add_path --global --path /var/lib/flatpak/exports/bin
    end
end
