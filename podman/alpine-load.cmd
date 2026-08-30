podman load -i alpine-aarch64.tar
podman load -i alpine-ppc64le.tar
podman load -i alpine-riscv64.tar

podman machine ssh "sudo tee /usr/local/bin/qemu-binfmt-conf.sh > /dev/null" < qemu-binfmt-conf.sh
podman machine ssh "sudo chmod +x /usr/local/bin/qemu-binfmt-conf.sh"
podman machine ssh "sudo tee /etc/systemd/system/qemu-binfmt.service > /dev/null" < qemu-binfmt.service
podman machine ssh "sudo systemctl daemon-reload"
podman machine ssh "sudo systemctl enable --now qemu-binfmt.service"

podman run --rm --platform linux/aarch64 localhost/alpine:aarch64 uname -m
podman run --rm --platform linux/ppc64le localhost/alpine:ppc64le uname -m
podman run --rm --platform linux/riscv64 localhost/alpine:riscv64 uname -m
