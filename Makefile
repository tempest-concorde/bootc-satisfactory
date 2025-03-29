
image:


iso:
	sudo rm -rf output
	mkdir output
	sudo podman pull ghcr.io/tempest-concorde/satisfactory:prod
	sudo podman pull quay.io/centos-bootc/bootc-image-builder:latest
	sudo podman run \
			--rm \
			-it \
			--privileged \
			--pull=newer \
			--security-opt label=type:unconfined_t \
			-v ./config.toml:/config.toml:ro \
			-v ./output:/output \
			-v /var/lib/containers/storage:/var/lib/containers/storage \
			quay.io/centos-bootc/bootc-image-builder:latest \
			--type qcow2 \
			--rootfs xfs \
			--use-librepo=True \
			ghcr.io/tempest-concorde/satisfactory:prod